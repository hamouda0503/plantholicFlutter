import 'dart:ui';
import '../services/location.dart';
import '../services/networking.dart';
import '../models/weather_response.dart';
import '../utilities/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

const apiKey = '94d33f43d57639a43ba778514c5555f9';
const openWeatherOneCallURL = 'https://api.openweathermap.org/data/2.5/onecall';
const openWeatherCurrentWeatherURL =
    'https://api.openweathermap.org/data/2.5/weather';

num latitude = 0.0;
num longitude = 0.0;
bool isPass = false;
final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

class WeatherModel {
  Future<dynamic> getLocation(BuildContext context) async {
    Location location = Location();
    await location.determinePosition(context);

    latitude = location.latitude;
    longitude = location.longitude;

    clearManuelLocation();
    print(latitude.toString() + " " + longitude.toString());
    return getOneCallWeather();
  }

  Future<dynamic> getOneCallWeather() async {
    isPass = false;
    NetworkHelper networkHelper = NetworkHelper(
        '$openWeatherOneCallURL?lat=$latitude&lon=$longitude&exclude=minutely,alert&units=metric&appid=$apiKey');

    WeatherResponse weatherData = await networkHelper.getOneCallWeather();
    return weatherData;
  }

  Future<dynamic> getLocationWithLatLon(num lat, num lon) async {
    latitude = lat;
    longitude = lon;

    isPass = false;
    NetworkHelper networkHelper = NetworkHelper(
        '$openWeatherOneCallURL?lat=$latitude&lon=$longitude&exclude=minutely,alert&units=metric&appid=$apiKey');

    WeatherResponse weatherData = await networkHelper.getOneCallWeather();
    return weatherData;
  }

  Future<String> getLocationName() async {
    NetworkHelper networkHelper = NetworkHelper(
        '$openWeatherCurrentWeatherURL?lat=$latitude&lon=$longitude&units=metric&appid=$apiKey');
    dynamic weatherData = await networkHelper.getCurrentWeather();
    if (weatherData.toString().isNotEmpty) {
      return weatherData['name'];
    }
    return "";
  }

  Future<String> locationNameToLongLat(String search) async {
    NetworkHelper networkHelper = NetworkHelper(
        '$openWeatherCurrentWeatherURL?q=$search&units=metric&appid=$apiKey');
    dynamic weatherData = await networkHelper.getCurrentWeather();
    if (weatherData.toString().isNotEmpty) {
      latitude = weatherData['coord']['lat'];
      longitude = weatherData['coord']['lon'];
      saveManuelLocation(latitude, longitude);
      print(latitude.toString() + " " + longitude.toString());
      return weatherData['name'];
    }
    return "";
  }

  Future<void> saveManuelLocation(num lat, num lon) async {
    final SharedPreferences prefs = await _prefs;
    await prefs.setBool(isLocationManuel, true);
    await prefs.setString(manuelLatitude, lat.toString());
    await prefs.setString(manuelLongitude, lon.toString());
  }

  Future<void> clearManuelLocation() async {
    final SharedPreferences prefs = await _prefs;
    await prefs.setBool(isLocationManuel, false);
    await prefs.setString(manuelLatitude, "");
    await prefs.setString(manuelLongitude, "");
  }

  String getWeatherAnimation(int id, bool isNight) {
    if (id >= 200 && id <= 202) {
      return 'weather/weather-storm.json';
    } else if (id >= 210 && id <= 221) {
      return 'weather/weather-thunder.json';
    } else if (id >= 230 && id <= 232) {
      return 'weather/weather-storm.json';
    } else if (id >= 301 && id <= 321) {
      if (isNight) {
        return 'weather/weather-night-rainy.json';
      }
      return 'weather/weather-rainy.json';
    } else if (id >= 500 && id <= 531) {
      if (isNight) {
        return 'weather/weather-night-rainy.json';
      }
      return 'weather/weather-rainy.json';
    } else if (id >= 600 && id <= 622) {
      if (isNight) {
        return 'weather/weather-night-snow.json';
      }
      return 'weather/weather-snow.json';
    } else if (id >= 701 && id <= 781) {
      return 'weather/weather-misjson';
    } else if (id == 800) {
      if (isNight) {
        return 'weather/weather-night-clear.json';
      }
      return 'weather/weather-sunny.json';
    } else if (id >= 801 && id <= 804) {
      if (isNight) {
        return 'weather/weather-night-cloudy.json';
      }
      return 'weather/weather-cloudy.json';
    } else {
      if (isNight) {
        return 'weather/weather-night-cloudy.json';
      }
      return 'weather/weather-cloudy.json';
    }
  }

  List<Color> getBackgroundColors(int id, bool isNight) {
    if (isNight) {
      return [kNightStartColor, kNightEndColor];
    } else {
      if (id >= 200 && id <= 202) {
        return [kRainyStartColor, kRainyEndColor];
      } else if (id >= 210 && id <= 221) {
        return [kRainyStartColor, kRainyEndColor];
      } else if (id >= 230 && id <= 232) {
        return [kRainyStartColor, kRainyEndColor];
      } else if (id >= 301 && id <= 321) {
        return [kRainyStartColor, kRainyEndColor];
      } else if (id >= 500 && id <= 531) {
        return [kRainyStartColor, kRainyEndColor];
      } else if (id >= 600 && id <= 622) {
        return [kRainyStartColor, kRainyEndColor];
      } else if (id >= 701 && id <= 781) {
        return [kRainyStartColor, kRainyEndColor];
      } else if (id == 800) {
        return [kClearStartColor, kClearEndColor];
      } else if (id >= 801 && id <= 804) {
        return [kCloudyStartColor, kCloudyEndColor];
      } else {
        return [kCloudyStartColor, kCloudyEndColor];
      }
    }
  }

  String getWeatherDesc(int id) {
    if (id >= 200 && id <= 202) {
      return "Thunderstorm w/ Rain";
    } else if (id >= 210 && id <= 221) {
      return "Thunderstorm";
    } else if (id >= 230 && id <= 232) {
      return "Thunderstorm w/ Rain";
    } else if (id >= 300 && id <= 321) {
      return "Drizzle";
    } else if (id >= 500 && id <= 502) {
      return "Rainy";
    } else if (id >= 503 && id <= 531) {
      return "Shower Rain";
    } else if (id >= 600 && id <= 622) {
      return "Snow";
    } else if (id >= 701 && id <= 771) {
      return "Mist";
    } else if (id == 781) {
      return "Tornado";
    } else if (id == 800) {
      return "Clear";
    } else if (id == 801) {
      return "Few Clouds";
    } else if (id == 802) {
      return "Scattered Clouds";
    } else if (id == 803) {
      return "Broken Clouds";
    } else if (id == 804) {
      return "Overcast Clouds";
    } else {
      return "Few Clouds";
    }
  }

  String timeStampToDate(int timestamp) {
    var dt = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
    return DateFormat('dd MMM').format(dt);
  }

  String timestampToHour(int timestamp) {
    var dt = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
    return DateFormat('HH:mm').format(dt);
  }

  String timestampToDay(int timestamp) {
    var dt = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
    var dayName = DateFormat().add_EEEE().format(dt);
    if (dayName.toLowerCase() == "monday") {
      return "Monday";
    } else if (dayName.toLowerCase() == "tuesday") {
      return "Tuesday";
    } else if (dayName.toLowerCase() == "wednesday") {
      return "Wednesday";
    } else if (dayName.toLowerCase() == "thursday") {
      return "Thursday";
    } else if (dayName.toLowerCase() == "friday") {
      return "Friday";
    } else if (dayName.toLowerCase() == "saturday") {
      return "Saturday";
    } else if (dayName.toLowerCase() == "sunday") {
      return "Sunday";
    } else {
      return dayName;
    }
  }

  bool isNight(num dt, num sunrise, num sunset) {
    if (dt <= sunrise || dt >= sunset) {
      return true;
    } else {
      return false;
    }
  }



  bool isNightForHourly(num now, num time, num sunrise, num sunset) {
    if (timestampToHour(time.toInt()) == "00:00" &&
        timestampToHour(now.toInt()) != "00:00") {
      isPass = true;
    }

    if (isPass) {
      sunrise += 86400;
      sunset += 86400;
    }

    if (time <= sunrise || time >= sunset) {
      return true;
    } else {
      return false;
    }
  }
}
