import 'package:json_annotation/json_annotation.dart';

part 'addBlogModels.g.dart';

@JsonSerializable()
class AddBlogModel {
  String coverImage;
  int like;
  int share;
  List<dynamic> comments;
  @JsonKey(name: "_id")
  String id;
  String username;
  String title;
  String body;

  AddBlogModel(
      {this.coverImage,
      this.like,
      this.share,
      this.comments,
      this.id,
      this.username,
      this.body,
      this.title});
  factory AddBlogModel.fromJson(Map<String, dynamic> json) =>
      _$AddBlogModelFromJson(json);
  Map<String, dynamic> toJson() => _$AddBlogModelToJson(this);
}