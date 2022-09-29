import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:social_network/repository/models/post.dart';

import '../../repository/post_repository.dart';

part 'post_event.dart';
part 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  PostBloc({
    required PostRepository postRepository,
  })  : _postRepository = postRepository,
        super(
         PostState(date: Timestamp.now()),
      ) {
    on<PostDescriptionChanged>(_onDescriptionChanged);
    on<PostSubmitted>(_onSubmitted);
    on<NewPostLoaded>(_onNewPostLoaded);
    on<PostSportChanged>(_onPostSportChanged);
    on<PostTitleChanged>(_onPostTitleChanged);
    on<PostDistanceChanged>(_onPostDistanceChanged);
  }
  final PostRepository _postRepository;

  Future<void> _onNewPostLoaded(
      NewPostLoaded event,
      Emitter<PostState> emit,
      ) async {
    final sports = await _postRepository.fetchSports();
    emit(PostState.sportsLoadSuccess(sports: sports));
  }

  Future<void> _onPostSportChanged(
      PostSportChanged event,
      Emitter<PostState> emit,
      ) async {
    emit(
      state.copyWith(sports: state.sports,sport: event.sport)
      );
  }

  void _onDescriptionChanged(
      PostDescriptionChanged event,
      Emitter<PostState> emit,
      ) {
    emit(state.copyWith(description: event.description));
  }

  Future<void> _onPostTitleChanged(
      PostTitleChanged event,
      Emitter<PostState> emit,
      ) async {
    emit(state.copyWith(title: event.title));
  }

  Future<void> _onPostDistanceChanged(
      PostDistanceChanged event,
      Emitter<PostState> emit,
      ) async {
    emit(state.copyWith(distance: event.distance));
  }

  Future<void> _onSubmitted(
      PostSubmitted event,
      Emitter<PostState> emit,
      ) async {
    //emit(state.copyWith(status: PostStatus.loading));
    final post = (state.initialPost ?? Post(description: '', user: 'antoine',
        date: Timestamp.now(), id: '', sport: 'vélo', title: 'Test', distance: 10)).copyWith(
      description: state.description,

    );

    try {
      await _postRepository.addNewPost(post);
      emit(state.copyWith(status: PostStatus.success, ));
    } catch (e) {
      emit(state.copyWith(status: PostStatus.failure));
    }
  }
}
