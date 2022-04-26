import 'dart:convert';

MyPlant MyPlantFromJson(String str) => MyPlant.fromJson(json.decode(str));

String MyPlantToJson(MyPlant data) => json.encode(data.toJson());

class MyPlant {
  String plant_name;
  String nickname;
  String specie;
  String image;

  String spot;
  String lastWatered;
  String waterCycle;
  int nextWater;
  String nextWaterDate;

  int id;

  MyPlant(
      {this.id,
      this.plant_name = "",
      this.specie = "",
      this.nickname = "",
      this.image = "",
      this.spot = "",
      this.lastWatered = "00",
      this.waterCycle = "00",
      this.nextWater = 00,
      this.nextWaterDate = "00"});

  factory MyPlant.fromJson(Map<String, dynamic> json) => MyPlant(
        id: json["id"],
        plant_name: json["plant_name"],
        specie: json["specie"],
        nickname: json["nickname"],
        image: json["image"],
        spot: json["spot"],
        lastWatered: json["lastWatered"],
        waterCycle: json["waterCycle"],
        nextWater: json["nextWater"],
        nextWaterDate: json["nextWaterDate"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "plant_name": plant_name,
        "nickname": nickname,
        "image": image,
        "spot": spot,
        "specie": specie,
        "lastWatered": lastWatered,
        "waterCycle": waterCycle,
        "nextWater": nextWater,
        "nextWaterDate": nextWaterDate
      };
}
