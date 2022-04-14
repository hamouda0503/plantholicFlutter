// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'SuperModel1.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SuperModel1 _$SuperModel1FromJson(Map<String, dynamic> json) {
  return SuperModel1(
    data: (json['data'] as List)
        ?.map((e) =>
            e == null ? null : PlantModel.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$SuperModel1ToJson(SuperModel1 instance) =>
    <String, dynamic>{
      'data': instance.data,
    };
