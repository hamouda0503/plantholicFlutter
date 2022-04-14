
class FeelsLike {
  FeelsLike({
     this.day,
     this.night,
     this.eve,
     this.morn,
  });
   num day;
   num night;
   num eve;
   num morn;

  FeelsLike.fromJson(Map<String, dynamic> json){
    day = json['day'];
    night = json['night'];
    eve = json['eve'];
    morn = json['morn'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['day'] = day;
    _data['night'] = night;
    _data['eve'] = eve;
    _data['morn'] = morn;
    return _data;
  }
}