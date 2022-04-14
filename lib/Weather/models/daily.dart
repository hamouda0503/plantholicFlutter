import '../models/weather.dart';
import '../models/temp.dart';
import '../models/feels_like.dart';

class Daily {
  Daily({
     this.dt,
     this.sunrise,
     this.sunset,
     this.moonrise,
     this.moonset,
     this.moonPhase,
     this.temp,
     this.feelsLike,
     this.pressure,
     this.humidity,
     this.dewPoint,
     this.windSpeed,
     this.windDeg,
     this.windGust,
     this.weather,
     this.clouds,
     this.pop,
     this.uvi,
  });
    num dt;
    num sunrise;
    num sunset;
    num moonrise;
    num moonset;
    num moonPhase;
    Temp temp;
    FeelsLike feelsLike;
    num pressure;
    num humidity;
    num dewPoint;
    num windSpeed;
    num windDeg;
    num windGust;
    List<Weather> weather;
    num clouds;
    num pop;
    num uvi;

  Daily.fromJson(Map<String, dynamic> json){
    dt = json['dt'];
    sunrise = json['sunrise'];
    sunset = json['sunset'];
    moonrise = json['moonrise'];
    moonset = json['moonset'];
    moonPhase = json['moon_phase'];
    temp = Temp.fromJson(json['temp']);
    feelsLike = FeelsLike.fromJson(json['feels_like']);
    pressure = json['pressure'];
    humidity = json['humidity'];
    dewPoint = json['dew_point'];
    windSpeed = json['wind_speed'];
    windDeg = json['wind_deg'];
    windGust = json['wind_gust'];
    weather = List.from(json['weather']).map((e)=>Weather.fromJson(e)).toList();
    clouds = json['clouds'];
    pop = json['pop'];
    uvi = json['uvi'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['dt'] = dt;
    _data['sunrise'] = sunrise;
    _data['sunset'] = sunset;
    _data['moonrise'] = moonrise;
    _data['moonset'] = moonset;
    _data['moon_phase'] = moonPhase;
    _data['temp'] = temp.toJson();
    _data['feels_like'] = feelsLike.toJson();
    _data['pressure'] = pressure;
    _data['humidity'] = humidity;
    _data['dew_point'] = dewPoint;
    _data['wind_speed'] = windSpeed;
    _data['wind_deg'] = windDeg;
    _data['wind_gust'] = windGust;
    _data['weather'] = weather.map((e)=>e.toJson()).toList();
    _data['clouds'] = clouds;
    _data['pop'] = pop;
    _data['uvi'] = uvi;
    return _data;
  }
}
