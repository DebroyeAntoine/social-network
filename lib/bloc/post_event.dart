part of 'post_bloc.dart';

abstract class PostEvent extends Equatable {
  const PostEvent();

  @override
  List<Object> get props => [];
}

class PostDescriptionChanged extends PostEvent {
  const PostDescriptionChanged(this.description);

  final String description;

  @override
  List<Object> get props => [description];
}

class PostSubmitted extends PostEvent {
  const PostSubmitted();
}