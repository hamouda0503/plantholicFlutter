import 'package:hive/hive.dart';

part 'photo_model.g.dart';

@HiveType(typeId: 0)
class PhotoModel extends HiveObject {
  @HiveField(0)
  int id;

  @HiveField(1)
  String url;

  @HiveField(2)
  PhotoSize photoSize;

  @HiveField(3)
  bool isFavorite;

  PhotoModel({
    this.id,
    this.url,
    this.photoSize,
    this.isFavorite = false,
  });

  PhotoModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    url = json['url'];
    photoSize = json['src'] != null ? PhotoSize.fromJson(json['src']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;

    data['url'] = this.url;
    if (this.photoSize != null) {
      data['src'] = this.photoSize.toJson();
    }
    return data;
  }
}

@HiveType(typeId: 0)
class PhotoSize {
  @HiveField(0)
  String original;
  @HiveField(1)
  String large2x;
  @HiveField(2)
  String large;
  @HiveField(3)
  String medium;
  @HiveField(4)
  String small;
  @HiveField(5)
  String portrait;
  @HiveField(6)
  String landscape;
  @HiveField(7)
  String tiny;

  PhotoSize({
    this.original,
    this.large2x,
    this.large,
    this.medium,
    this.small,
    this.portrait,
    this.landscape,
    this.tiny,
  });

  PhotoSize.fromJson(Map<String, dynamic> json) {
    original = json['original'];
    large2x = json['large2x'];
    large = json['large'];
    medium = json['medium'];
    small = json['small'];
    portrait = json['portrait'];
    landscape = json['landscape'];
    tiny = json['tiny'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['original'] = this.original;
    data['large2x'] = this.large2x;
    data['large'] = this.large;
    data['medium'] = this.medium;
    data['small'] = this.small;
    data['portrait'] = this.portrait;
    data['landscape'] = this.landscape;
    data['tiny'] = this.tiny;
    return data;
  }
}
