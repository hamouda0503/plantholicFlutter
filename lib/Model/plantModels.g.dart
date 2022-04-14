// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'plantModels.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PlantModel _$PlantModelFromJson(Map<String, dynamic> json) {
  return PlantModel(
    plantName: json['plantName'] as String,
    id: json['_id'] as String,
    plantDescription: json['plantDescription'] as String,
    plantImageUrl: json['plantImageUrl'] as String,
    
  );
}

Map<String, dynamic> _$PlantModelToJson(PlantModel instance) =>
    <String, dynamic>{
      'plantName': instance.plantName,
      '_id': instance.id,
      'plantDescription': instance.plantDescription,
      'plantImageUrl': instance.plantImageUrl,
    };
