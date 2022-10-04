

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class PostEntity extends Equatable {
  final String id;
  final String description;
  final Timestamp date;
  final String user;
  final String image;
  final String sport;
  final String title;
  final double distance;
  final Duration duration;

  const PostEntity(this.id, this.description, this.date, this.user, this.image,
      this.sport, this.title, this.distance, this.duration);

  Map<String, Object> toJson() {
    return {
      'date': date,
      'user': user,
      'image': image,
      'description': description,
      'id': id,
      'sport': sport,
      'title': title,
      'distance': distance,
      'duration': duration,
    };
  }

  @override
  String toString() {
    return 'PostEntity { date: $date, title: $title, sport: $sport user: $user, image: $image, '
        'description: $description, id: $id distance: $distance duration: $duration }';
  }

  static PostEntity fromJson(Map<String, Object> json) {
    return PostEntity(
      json['id'] as String,
      json['description'] as String,
      json['date'] as Timestamp,
      json['image'] as String,
      json['user'] as String,
      json['sport'] as String,
      json['title'] as String,
      json['distance'] as double,
      json['duration'] as Duration,
    );
  }

  static PostEntity fromSnapshot(DocumentSnapshot snap) {
    return PostEntity(
      snap.get('description'),
      snap.id,
      snap.get('image'),
      snap.get('date'),
      snap.get('user'),
      snap.get('sport'),
      snap.get('title'),
      snap.get('distance'),
      snap.get('duration'),
    );
  }

  Map<String, Object> toDocument() {
    return {
      'description': description,
      'image': image,
      'user': user,
      'date': date,
      'sport': sport,
      'title': title,
      'distance': distance,
      'duration': duration,
    };
  }

  @override
  // TODO: implement props
  List<Object?> get props => [id, description, image, user, date, sport, title, distance, duration];

}