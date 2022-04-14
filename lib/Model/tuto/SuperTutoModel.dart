import 'package:plantholic/Model/tuto/tutoModels.dart';
import 'package:json_annotation/json_annotation.dart';

part 'SuperTutoModel.g.dart';

@JsonSerializable()
class SuperTutoModel {
  List<tutoModel> data;
  SuperTutoModel({this.data});
  factory SuperTutoModel.fromJson(Map<String, dynamic> json) =>
      _$SuperTutoModelFromJson(json);
  Map<String, dynamic> toJson() => _$SuperTutoModelToJson(this);
}
