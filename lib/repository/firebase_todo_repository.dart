import 'package:social_network/repository/models/post.dart';
import 'package:social_network/repository/post_entity.dart';
import 'package:social_network/repository/post_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseTodosRepository implements PostRepository {
  final postCollection = FirebaseFirestore.instance.collection('todos');

  @override
  Future<void> addNewPost(Post post) {
    return postCollection.add(post.toEntity().toDocument());
  }

  @override
  Stream<List<Post>> post() {
    return postCollection.snapshots().map((snapshot) {
      return snapshot.docs
          .map((doc) => Post.fromEntity(PostEntity.fromSnapshot(doc)))
          .toList();
    });
  }

  @override
  Future<void> updatePost(Post update) {
    return postCollection
        .doc(update.id)
        .update(update.toEntity().toDocument());
  }
}