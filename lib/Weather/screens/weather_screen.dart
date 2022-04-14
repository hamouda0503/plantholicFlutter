import 'package:flutter/material.dart';
import '../utilities/constants.dart';
import '../services/weather.dart';
import '../models/weather_response.dart';

import '../components/daily_weather.dart';
import '../components/hourly_weather.dart';
import '../components/location_name.dart';
import '../components/other_weather_info.dart';
import '../components/main_weather.dart';
import 'package:provider/provider.dart';
import '../models/weather_provider.dart';

class LocationScreen extends StatefulWidget {
  const LocationScreen({Key key}) : super(key: key);

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  WeatherModel weather = WeatherModel();
  WeatherResponse weatherRes;
  String temperature, weatherDesc, date;
  int weatherId;
  bool isNight;
  String locationName;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    weatherRes = Provider.of<WeatherData>(context).weatherData;
    updateUI(weatherRes);
  }

  void updateUI(WeatherResponse weatherRes) {
    setState(() {
      if (weatherRes == null) {
        temperature = '0';
        weatherId = 1000;
        weatherDesc = 'Unable to get weather data';
        return;
      }

      temperature = weatherRes.current.temp.round().toStringAsFixed(0);
      date = weather.timeStampToDate(weatherRes.current.dt.toInt());
      weatherId = weatherRes.current.weather.first.id.toInt();
      locationName = weatherRes.locationName;

      isNight = weather.isNight(
        weatherRes.current.dt,
        weatherRes.current.sunrise,
        weatherRes.current.sunset,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = (MediaQuery.of(context).size.width);
    double screenHeight = (MediaQuery.of(context).size.height);
    List<Color> colors = weather.getBackgroundColors(weatherId, isNight);

    return Scaffold(
      backgroundColor: colors[1],
      body: SizedBox(
        width: screenWidth,
        height: screenHeight,
        child: SingleChildScrollView(
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: colors,
              ),
            ),
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 4.0,
                    ),
                    Row(
                      children: [
                        IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: Icon(
                              Icons.arrow_back,
                              color: Colors.white,
                            )),
                        SizedBox(width: 100,),
                        LocationNameView(
                          weatherResponse: weatherRes,
                          cityName: locationName,
                          startColor: colors[0],
                          endColor: colors[1],
                        ),
                      ],
                    ),

                    myMarginVertical(),
                    MainWeatherView(
                      icon: weather.getWeatherAnimation(weatherId, isNight),
                      description: weather.getWeatherDesc(weatherId),
                      temp: temperature,
                      day: date,
                      screenWidth: screenWidth,
                    ),
                    // myDivider(),
                    myMarginVertical(),
                    HourlyList(weatherRes: weatherRes, weather: weather),
                    //HourlyWeather(),
                    myMarginVertical(),
                    // myDivider(),
                    DailyWeather(daily: weatherRes.daily),
                    myMarginVertical(),
                    myDivider(),
                    // myMargin(),
                    WeatherOtherInfo(
                      windSpeed: weatherRes.current.windSpeed
                          .round()
                          .toStringAsFixed(0),
                      humidity: weatherRes.current.humidity
                          .round()
                          .toStringAsFixed(0),
                      realFeel: weatherRes.current.feelsLike
                          .round()
                          .toStringAsFixed(0),
                    ),
                    myMarginVertical(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
