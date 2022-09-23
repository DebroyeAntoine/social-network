import 'package:social_network/repository/models/post.dart';
import 'package:social_network/repository/post_entity.dart';
import 'package:social_network/repository/post_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FireBasePostRepository implements PostRepository {
  final postCollection = FirebaseFirestore.instance.collection('posts');
  final usersCollection = FirebaseFirestore.instance.collection('users');

  @override
  Future<void> addNewPost(Post post) {
    var ref = postCollection.doc();
    post.copyWith(id:ref.id);
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

  static const _delay = Duration(milliseconds: 300);
  Future<void> wait() => Future.delayed(_delay);

  @override
  Future<List<String>> fetchSports() async {
    await wait();
    return ['Vélo', 'Course à pieds', 'Natation'];
  }
}