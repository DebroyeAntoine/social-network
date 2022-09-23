part of 'post_bloc.dart';

abstract class PostEvent extends Equatable {
  const PostEvent();

  @override
  List<Object?> get props => [];
}

class PostDescriptionChanged extends PostEvent {
  const PostDescriptionChanged(this.description);

  final String description;

  @override
  List<Object> get props => [description];
}

class PostSportChanged extends PostEvent {
  const PostSportChanged({this.sport});

  final String? sport;

  @override
  List<Object?> get props => [sport];
  }

class PostSubmitted extends PostEvent {
  const PostSubmitted();
}

class NewPostLoaded extends PostEvent {
  const NewPostLoaded();
}