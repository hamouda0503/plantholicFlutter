import 'package:plantholic/Model/plantModels.dart';
import 'package:json_annotation/json_annotation.dart';

part 'SuperModel1.g.dart';

@JsonSerializable()
class SuperModel1 {
  List<PlantModel> data;
  SuperModel1({this.data});
  factory SuperModel1.fromJson(Map<String, dynamic> json) =>
      _$SuperModel1FromJson(json);
  Map<String, dynamic> toJson() => _$SuperModel1ToJson(this);
}
