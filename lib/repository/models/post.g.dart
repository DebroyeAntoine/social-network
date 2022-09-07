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
    );

Map<String, dynamic> _$PostToJson(Post instance) => <String, dynamic>{
      'id': instance.id,
      'description': instance.description,
      'image': instance.image,
      'date': Post._toJson(instance.date),
      'user': instance.user,
    };
