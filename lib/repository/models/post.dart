import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';
import 'package:uuid/uuid.dart';

import '../post_entity.dart';
import 'json_map.dart';
part 'post.g.dart';

/// {@template todo}
/// A single todo item.
///
/// Contains a [title], [description] and [id], in addition to a [isCompleted]
/// flag.
///
/// If an [id] is provided, it cannot be empty. If no [id] is provided, one
/// will be generated.
///
/// [Post]s are immutable and can be copied using [copyWith], in addition to
/// being serialized and deserialized using [toJson] and [fromJson]
/// respectively.
/// {@endtemplate}
@immutable
@JsonSerializable()
class Post extends Equatable {
  /// {@macro todo}
  Post({
    String? id,
    required this.description,
    this.image = '',
    required this.date,
    required this.user,
    required this.sport,
    required this.title,
    required this.distance,
  })  : /*assert(
  id == null,
  'id can not be null and should be empty',
  ),*/
        id = id ?? const Uuid().v4();

  /// The unique identifier of the todo.
  ///
  /// Cannot be empty.
  final String id;

  /// The title of the todo.
  ///
  /// Note that the title may be empty.
  final String description;

  final String sport;

  /// The description of the todo.
  ///
  /// Defaults to an empty string.
  final String image;

  /// Whether the todo is completed.
  ///
  /// Defaults to `false`.
  @JsonKey(fromJson: _fromJson, toJson: _toJson)
  final Timestamp date;

  final String user;

  final String title;

  final double distance;

  /// Returns a copy of this todo with the given values updated.
  ///
  /// {@macro todo}
  Post copyWith({
    String? id,
    String? description,
    String? image,
    Timestamp? date,
    String? user,
    String? sport,
    String? title,
    double? distance,
  }) {
    return Post(
      id: id ?? this.id,
      description: description ?? this.description,
      image: image ?? this.image,
      date: date ?? this.date,
      user: user ?? this.user,
      sport: sport ?? this.sport,
      title: title ?? this.title,
      distance: distance ?? this.distance
    );
  }

  /// Deserializes the given [JsonMap] into a [Post].
  static Post fromJson(JsonMap json) => _$PostFromJson(json);

  /// Converts this [Post] into a [JsonMap].
  JsonMap toJson() => _$PostToJson(this);

  @override
  List<Object> get props => [id, description, image, date, user, sport, title, distance];

  static int _toJson(Timestamp time) => time.millisecondsSinceEpoch;
  static Timestamp _fromJson (int time) =>
      Timestamp.fromMicrosecondsSinceEpoch(time);

  PostEntity toEntity() {
    return PostEntity(id, description, date, user, image, sport, title, distance);
  }

  static Post fromEntity(PostEntity entity) {
    return Post(
      description: entity.description,
      id: entity.id,
      date: entity.date,
      image: entity.image,
      user: entity.user,
      sport: entity.sport,
      title: entity.title,
      distance: entity.distance,
    );
  }
}
