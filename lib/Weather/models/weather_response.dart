import '../models/hourly.dart';
import '../models/current.dart';
import '../models/daily.dart';

class WeatherResponse {
  WeatherResponse({
    this.lat,
    this.lon,
    this.timezone,
    this.timezoneOffset,
    this.current,
    this.hourly,
    this.daily,
  });
   num lat;
   num lon;
   String timezone;
   num timezoneOffset;
   Current current;
   List<Hourly> hourly;
   List<Daily> daily;
   String locationName;

  WeatherResponse.fromJson(Map<String, dynamic> json){
    lat = json['lat'];
    lon = json['lon'];
    timezone = json['timezone'];
    timezoneOffset = json['timezone_offset'];
    current = Current.fromJson(json['current']);
    hourly = List.from(json['hourly']).map((e)=>Hourly.fromJson(e)).toList();
    daily = List.from(json['daily']).map((e)=>Daily.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['lat'] = lat;
    _data['lon'] = lon;
    _data['timezone'] = timezone;
    _data['timezone_offset'] = timezoneOffset;
    _data['current'] = current.toJson();
    _data['hourly'] = hourly.map((e)=>e.toJson()).toList();
    _data['daily'] = daily.map((e)=>e.toJson()).toList();
    return _data;
  }
}






