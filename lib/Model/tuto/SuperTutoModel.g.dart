// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'SuperTutoModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SuperTutoModel _$SuperTutoModelFromJson(Map<String, dynamic> json) {
  return SuperTutoModel(
    data: (json['data'] as List)
        ?.map((e) =>
            e == null ? null : tutoModel.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$SuperTutoModelToJson(SuperTutoModel instance) =>
    <String, dynamic>{
      'data': instance.data,
    };
