import 'package:json_annotation/json_annotation.dart';

part 'plantModels.g.dart';

@JsonSerializable()
class PlantModel {
  @JsonKey(name: "_id")
  String id ;
  String plantName;
  String plantDescription;
  String plantImageUrl;


  PlantModel(
      {
      this.id,
      this.plantName,
      this.plantDescription,
      this.plantImageUrl}
      );

  factory PlantModel.fromJson(Map<String, dynamic> json) =>
      _$PlantModelFromJson(json);
  Map<String, dynamic> toJson() => _$PlantModelToJson(this);
}
