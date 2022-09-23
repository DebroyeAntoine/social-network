import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:social_network/repository/models/post.dart';

import '../repository/post_repository.dart';

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
  }
  final PostRepository _postRepository;

  void _onDescriptionChanged(
      PostDescriptionChanged event,
      Emitter<PostState> emit,
      ) {
    emit(state.copyWith(description: event.description));
  }

  Future<void> _onSubmitted(
      PostSubmitted event,
      Emitter<PostState> emit,
      ) async {
    //emit(state.copyWith(status: PostStatus.loading));
    final post = (state.initialPost ?? Post(description: '', user: 'antoine',
        date: Timestamp.now(), id: '')).copyWith(
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
