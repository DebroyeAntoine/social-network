import 'package:social_network/repository/models/post.dart';

abstract class PostRepository {
  Future<List<String>> fetchSports();

  Future<void> addNewPost(Post post);

  Stream<List<Post>> post();

  Future<void> updatePost(Post post);
}