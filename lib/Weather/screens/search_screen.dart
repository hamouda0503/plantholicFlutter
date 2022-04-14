import 'dart:math';
import '../models/weather_response.dart';
import '../utilities/debouncer.dart';
import 'package:flutter/material.dart';
import '../utilities/constants.dart';

import '../services/weather.dart';
import 'package:lottie/lottie.dart';


class SearchView extends StatefulWidget {
  const SearchView({Key key, this.startColor, this.endColor})
      : super(key: key);
  final Color startColor;
  final Color endColor;

  @override
  _SearchViewState createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> with TickerProviderStateMixin {
   AnimationController _controller;
  int index = 0;

  @override
  void initState() {
    super.initState();
    index = Random().nextInt(4) + 1;
    _controller = AnimationController(vsync: this);
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          index++;
          _controller.value = 0;
        });
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = (MediaQuery.of(context).size.width);
    double screenHeight = (MediaQuery.of(context).size.height);

    WeatherModel weather = WeatherModel();
    final debouncer = Debouncer(milliseconds: 3000);
    var textController = TextEditingController();

    void hideOpenDialog() {
      Navigator.of(context).pop();
    }

    void showLoadingIndicator() {
      showGeneralDialog(
        context: context,
        barrierDismissible: false,
        barrierColor: Colors.black.withAlpha(100),
        pageBuilder: (_, __, ___) {
          return Center(
            child: Wrap(
              children: [
                Lottie.asset(
                  'assets/weather/${animations[index % animations.length]}',
                  width: (screenWidth - ((screenWidth / 100) * 30)),
                  height: 200,
                  repeat: false,
                  animate: true,
                  controller: _controller,
                  onLoaded: (animations) {
                    _controller
                      ..duration = (animations.duration * 0.7)
                      ..forward();
                  },
                ),
              ],
            ),
          );
        },
      );
    }

    Future<void> search(String searchData) async {
      textController.clear();
      FocusScope.of(context).requestFocus(FocusNode());
      debouncer.cancel();
      if(searchData.toLowerCase() == "what do you hear starbuck"){ //a little easter egg
    
      }else{
        showLoadingIndicator();
        String locationName = await weather.locationNameToLongLat(searchData);
        if (locationName.isNotEmpty) {
          WeatherResponse weatherData = await WeatherModel().getOneCallWeather();
          weatherData.locationName = locationName;
          hideOpenDialog();
          Navigator.pop(context, weatherData);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
              "Location not found",
              style: kSubHeadlinePrimaryTextStyle,
            ),
            duration: const Duration(milliseconds: 2000),
            backgroundColor: widget.endColor,
          ));
          hideOpenDialog();
        }
      }
    }

    Future<void> getLocationWeather() async {
      showLoadingIndicator();
      try {
        WeatherResponse weatherData = await weather.getLocation(context);
        String locationName = await WeatherModel().getLocationName();
        weatherData.locationName = locationName;
        hideOpenDialog();
        Navigator.pop(context, weatherData);
      } catch (e) {
        hideOpenDialog();
      }
    }

    return Scaffold(
      backgroundColor: widget.endColor,
      body: SizedBox(
        width: screenWidth,
        height: screenHeight,
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [widget.startColor, widget.endColor],
            ),
          ),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SizedBox(
                height: 100,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: GestureDetector(
                            onTap: () {
                              Navigator.pop(context, null);
                            },
                            child: Container(
                              height: 63,
                              decoration: const BoxDecoration(
                                  color: kSearchViewColor,
                                  borderRadius: BorderRadius.vertical(
                                      bottom: Radius.circular(0),
                                      top: Radius.circular(4))),
                              child: const Icon(
                                Icons.arrow_back,
                                color: kSearchColor,
                                size: kIconSize,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: kMargin2x,
                        ),
                        Expanded(
                          flex: 4,
                          child: TextFormField(
                            controller: textController,
                            onFieldSubmitted: (value) => {search(value)},
                            onChanged: (value) => {
                              if (value.isNotEmpty)
                                {debouncer.run(() => search(value))}
                            },
                            textInputAction: TextInputAction.search,
                            cursorColor: widget.startColor,
                            style: kHeadlineTextStyle,
                            decoration: InputDecoration(
                                fillColor: kSearchViewColor,
                                filled: true,
                                prefixIcon: const Icon(
                                  Icons.search,
                                  color: kSearchColor,
                                  size: kIconSize,
                                ),
                                labelText: "Search",
                                labelStyle: kSubHeadlineTextStyle,
                                enabledBorder: const UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: kSearchViewColor),
                                ),
                                focusedBorder: const UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: kSearchViewColor),
                                )),
                          ),
                        ),
                        const SizedBox(
                          width: kMargin2x,
                        ),
                        Expanded(
                          flex: 1,
                          child: GestureDetector(
                            onTap: () {
                              getLocationWeather();
                            },
                            child: Container(
                              height: 63,
                              decoration: const BoxDecoration(
                                  color: kSearchViewColor,
                                  borderRadius: BorderRadius.vertical(
                                      bottom: Radius.circular(0),
                                      top: Radius.circular(4))),
                              child: const Icon(
                                Icons.location_pin,
                                color: kSearchColor,
                                size: kIconSize,
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
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
