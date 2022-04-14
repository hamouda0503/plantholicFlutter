import '../models/weather.dart';

class Current {
  Current({
     this.dt,
     this.sunrise,
     this.sunset,
     this.temp,
     this.feelsLike,
     this.pressure,
     this.humidity,
     this.dewPoint,
     this.uvi,
     this.clouds,
     this.visibility,
     this.windSpeed,
     this.windDeg,
     this.windGust,
     this.weather,
  });
    num dt;
    num sunrise;
    num sunset;
    num temp;
    num feelsLike;
    num pressure;
    num humidity;
    num dewPoint;
    num uvi;
    num clouds;
    num visibility;
    num windSpeed;
    num windDeg;
    num windGust;
    List<Weather> weather;

  Current.fromJson(Map<String, dynamic> json){
    dt = json['dt'];
    sunrise = json['sunrise'];
    sunset = json['sunset'];
    temp = json['temp'];
    feelsLike = json['feels_like'];
    pressure = json['pressure'];
    humidity = json['humidity'];
    dewPoint = json['dew_point'];
    uvi = json['uvi'];
    clouds = json['clouds'];
    visibility = json['visibility'];
    windSpeed = json['wind_speed'];
    windDeg = json['wind_deg'];
    windGust = json['wind_gust'];
    weather = List.from(json['weather']).map((e)=>Weather.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['dt'] = dt;
    _data['sunrise'] = sunrise;
    _data['sunset'] = sunset;
    _data['temp'] = temp;
    _data['feels_like'] = feelsLike;
    _data['pressure'] = pressure;
    _data['humidity'] = humidity;
    _data['dew_point'] = dewPoint;
    _data['uvi'] = uvi;
    _data['clouds'] = clouds;
    _data['visibility'] = visibility;
    _data['wind_speed'] = windSpeed;
    _data['wind_deg'] = windDeg;
    _data['wind_gust'] = windGust;
    _data['weather'] = weather.map((e)=>e.toJson()).toList();
    return _data;
  }
}
