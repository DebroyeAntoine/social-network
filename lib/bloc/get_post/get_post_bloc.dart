import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

import '../../repository/models/post.dart';

import 'package:stream_transform/stream_transform.dart';

import '../../repository/post_repository.dart';

part 'get_post_event.dart';
part 'get_post_state.dart';

const _postLimit = 75;
const throttleDuration = Duration(milliseconds: 100);

EventTransformer<E> throttleDroppable<E>(Duration duration) {
  return (events, mapper) {
    return droppable<E>().call(events.throttle(duration), mapper);
  };
}

class GetPostBloc extends Bloc<GetPostEvent, GetPostState> {
  GetPostBloc({required PostRepository postRepository,
      })  : _postRepository = postRepository,
        super(
          const GetPostState()
  ) {
    on<PostFetched>(
      _onPostFetched,
      transformer: throttleDroppable(throttleDuration),
    );
    on<GetPostEvent>((event, emit) {
      // TODO: implement event handler
    });
  }

  final PostRepository _postRepository;

  Future<void> _onPostFetched(
      PostFetched event,
      Emitter<GetPostState> emit,
      ) async {
    if (state.hasReachedMax) return;
    try {
      if (state.status == PostStatus.initial) {
        final posts = await _fetchPosts();
        return emit(
          state.copyWith(
            status: PostStatus.success,
            posts: posts,
            hasReachedMax: false,
          ),
        );
      }
      final posts = await _fetchPosts(state.posts.length);
      posts.isEmpty
          ? emit(state.copyWith(hasReachedMax: true))
          : emit(
        state.copyWith(
          status: PostStatus.success,
          posts: List.of(state.posts)..addAll(posts),
          hasReachedMax: false,
        ),
      );
    } catch (_) {
      emit(state.copyWith(status: PostStatus.failure));
    }
  }

  Future<List<Post>> _fetchPosts([int startIndex = 0]) async {
    }
}
