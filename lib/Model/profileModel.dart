import 'package:json_annotation/json_annotation.dart';

part 'profileModel.g.dart';

@JsonSerializable()
class ProfileModel {

  String name;
  String username;
  String img;
  // String DOB;
  // String titleline;
  String about;
  ProfileModel({
      // {this.DOB,
      this.about,
      this.name,
      this.img,
      // this.titleline,
      this.username});

  factory ProfileModel.fromJson(Map<String, dynamic> json) =>
      _$ProfileModelFromJson(json);
  Map<String, dynamic> toJson() => _$ProfileModelToJson(this);
}
