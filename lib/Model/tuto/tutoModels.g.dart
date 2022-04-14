// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tutoModels.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

tutoModel _$tutoModelFromJson(Map<String, dynamic> json) {
  return tutoModel(
    coverImage: json['coverImage'] as String,
    id: json['_id'] as String,
    username: json['username'] as String,
    body: json['body'] as String,
    title: json['title'] as String,
  );
}

Map<String, dynamic> _$tutoModelToJson(tutoModel instance) =>
    <String, dynamic>{
      'coverImage': instance.coverImage,
      '_id': instance.id,
      'username': instance.username,
      'title': instance.title,
      'body': instance.body,
    };
