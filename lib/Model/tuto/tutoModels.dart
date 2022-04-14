import 'package:json_annotation/json_annotation.dart';

part 'tutoModels.g.dart';

@JsonSerializable()
class tutoModel {
  String coverImage;
  @JsonKey(name: "_id")
  String id;
  String username;
  String title;
  String body;

  tutoModel(
      {this.coverImage,
      this.id,
      this.username,
      this.body,
      this.title});
  factory tutoModel.fromJson(Map<String, dynamic> json) =>
      _$tutoModelFromJson(json);
  Map<String, dynamic> toJson() => _$tutoModelToJson(this);
}
