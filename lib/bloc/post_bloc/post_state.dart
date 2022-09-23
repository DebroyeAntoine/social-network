part of 'post_bloc.dart';

enum PostStatus { initial, loading, success, failure }

extension PostStatusX on PostStatus {
  bool get isLoadingOrSuccess => [
    PostStatus.loading,
    PostStatus.success,
  ].contains(this);
}

class PostState extends Equatable {
  const PostState( {
    required this.date,
    this.status = PostStatus.initial,
    this.description = '',
    this.user = 'tmp',
    this.image = 'ii',
    this.initialPost,
    this.sports = const <String>[],
    this.sport,

  });

  bool get isNewPost => initialPost == null;

  final PostStatus status;
  final Post? initialPost;
  final String user;
  final String image;
  final Timestamp date;
  final String description;
  final List<String> sports;
  final String? sport;

  PostState copyWith({
    PostStatus? status,
    String? description,
    Post? initialPost,
    String? user,
    String? image,
    Timestamp? date,
    String? sport,
    List<String>? sports,
  }) {
    return PostState(
      date: date ?? this.date,
      initialPost: initialPost ?? this.initialPost,
      status: status ?? this.status,
      description: description ?? this.description,
      user: user ?? this.user,
      image: image ?? this.image,
      sport: sport ?? this.sport,
      sports: sports ?? this.sports,
    );
  }

   PostState.sportsLoadSuccess({required List<String> sports})
      : this(sports: sports, date: Timestamp.now());


  @override
  List<Object?> get props => [status, description, initialPost, image, user, date, sport, sports];
}
