

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class PostEntity extends Equatable {
  final String id;
  final String description;
  final Timestamp date;
  final String user;
  final String image;

  const PostEntity(this.id, this.description, this.date, this.user, this.image);

  Map<String, Object> toJson() {
    return {
      'date': date,
      'user': user,
      'image': image,
      'description': description,
      'id': id,
    };
  }

  @override
  String toString() {
    return 'PostEntity { date: $date, user: $user, image: $image, '
        'description: $description, id: $id }';
  }

  static PostEntity fromJson(Map<String, Object> json) {
    return PostEntity(
      json['id'] as String,
      json['description'] as String,
      json['date'] as Timestamp,
      json['image'] as String,
      json['user'] as String,
    );
  }

  static PostEntity fromSnapshot(DocumentSnapshot snap) {
    return PostEntity(
      snap.get('description'),
      snap.id,
      snap.get('image'),
      snap.get('date'),
      snap.get('user'),
    );
  }

  Map<String, Object> toDocument() {
    return {
      'description': description,
      'image': image,
      'user': user,
      'date': date
    };
  }

  @override
  // TODO: implement props
  List<Object?> get props => [id, description, image, user, date];

}