part of 'get_post_bloc.dart';

abstract class GetPostEvent extends Equatable {
  @override
  List<Object> get props => [];
}
class PostFetched extends GetPostEvent {
}
