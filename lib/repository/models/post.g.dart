// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Post _$PostFromJson(Map<String, dynamic> json) => Post(
      id: json['id'] as String?,
      description: json['description'] as String,
      image: json['image'] as String? ?? '',
      date: Post._fromJson(json['date'] as int),
      user: json['user'] as String,
      sport: json['sport'] as String? ?? '',
      title: json['title'] as String,
      distance: (json['distance'] as num).toDouble(),
      duration: json['duration'] as int,
    );

Map<String, dynamic> _$PostToJson(Post instance) => <String, dynamic>{
      'id': instance.id,
      'description': instance.description,
      'sport': instance.sport,
      'image': instance.image,
      'date': Post._toJson(instance.date),
      'user': instance.user,
      'title': instance.title,
      'distance': instance.distance,
      'duration': instance.duration,
    };
