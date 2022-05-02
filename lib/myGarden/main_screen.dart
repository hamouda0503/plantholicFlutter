import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:plantholic/myGarden/add_plant.dart';
import 'package:plantholic/myplant/home.dart';
import '../NetworkHandler.dart';
import './detail_screen.dart';
import 'Modelo/plant_info.dart';


class MainScreen extends StatefulWidget {
  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  NetworkHandler networkHandler = NetworkHandler();

  MyPlant plant = MyPlant();


  List<dynamic> data = [];


  @override
  void initState() {
    super.initState();
    fetchData();
  }
//   void scheduleNotification(MyPlant plant) async {
//     var scheduleNotificationDataTime = DateTime.parse(plant.nextWaterDate);
//     // DateTime(
//     //   DateTime.now().year,
//     //   DateTime.now().month,
//     //   DateTime.now().day,
//     //   DateTime.now().hour,
//     //   DateTime.now().minute,

//     // );
// print(DateTime.parse(plant.nextWaterDate));
//     var androidPlatformChannelSpecifics = AndroidNotificationDetails(
//       'plant_notif',
//       'plant_notif',
//       'Channel for plant notfication',
//       icon: 'ic_launcher',
//       largeIcon: DrawableResourceAndroidBitmap('ic_launcher'),
//       sound: RawResourceAndroidNotificationSound(''),
//     );

//     var iOSPlatformChannelSpecifics = IOSNotificationDetails(
//       sound: '',
//       presentAlert: true,
//       presentBadge: true,
//       presentSound: true,
//     );

//     var platformChannelSpecifics =
//         NotificationDetails(android: androidPlatformChannelSpecifics,iOS: iOSPlatformChannelSpecifics);

//     await FlutterLocalNotificationsPlugin().schedule(
//       0,
//       'test',
//       'nabta',
//       scheduleNotificationDataTime,
//       platformChannelSpecifics,
//     );
//     print("hello");
//   }

  String remainingDaysString(MyPlant plant) {
    final DateTime now = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, 10);
    final Duration remaining = DateTime.parse(plant.nextWaterDate).difference(now);

    if (remaining.inDays == 0) {
      return "Aujourd'hui";
    }
    else if (remaining.inDays == 1) {
      return "Demain";
    }
    else if (remaining.inDays < 0) {
      return "Dépassé";
    }

    return "${remaining.inDays} jours";
  }

  void fetchData() async {
    var response = await networkHandler.get("/myplant/getData");
    List<dynamic> plantsMapped =
    response["data"].map((a) => MyPlant.fromJson(a)).toList();
    setState(() {
      data = plantsMapped;
      print(data.length);
    });
    if (mounted) setState(() {});
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.symmetric(vertical: 30.0, horizontal: 0.0),
        child: Column(
          children: <Widget>[

            Container(
              margin: EdgeInsets.only(top: 7.0, left: 7.0, right: 7.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Expanded(
                    flex: 7,
                    child:
                    Align(
                      alignment: Alignment.centerLeft,
                      child: IconButton(
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) {
                            return AddInfoPlant();
                          }));
                            //  scheduleNotification(data[0]);
                        },
                        iconSize: 30.0,
                        icon: new Icon(Icons.add, color: Colors.black38),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Row(
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(right: 5.0),
                            height: 40,
                            // decoration: ShapeDecoration(
                            //     color: Colors.lightGreen.shade200,
                            //     shape: CircleBorder()
                            // ),
                            child: IconButton(
                              onPressed: () {},
                              iconSize: 28.0,
                              icon: new Icon(Icons.search, color: Colors.black45),
                            ),
                          ),
                          Container(
                            height: 40,
                            decoration: ShapeDecoration(
                                color: Colors.lightGreen.shade200,
                                shape: CircleBorder()
                            ),
                            child: IconButton(
                              onPressed: () {},
                              icon: new Icon(Icons.person_outline, color: Colors.black45),
                            ),
                          ),
                        ],
                      ),

                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                top: 25.0,
                right: 20.0,
                bottom: 10.0,
                left: 21.0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Water Your Plants!',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),

            Expanded(
              child: ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) {
                          return PlantDetailsPage(plant:data[index]);
                        }));
                      },
                      child:
                      ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: Container(
                          margin: EdgeInsets.symmetric(vertical: 5.0, horizontal: 15.0),
                          child:  Card(
                            child: Container(
                              color: Colors.lightGreen.shade100,
                              child: Column(
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[

                                      Expanded(
                                        flex: 3,
                                        child: Container(
                                          height: 100,
                                          child:
                                          data[index].image==null?SizedBox():Image.memory(base64.decode(data[index].image)),
                                        ),
                                      ),


                                      Expanded(
                                        flex: 5,
                                        child: Container(
                                          height: 100,
                                          child: Column(
                                            children: <Widget>[


                                              Expanded(
                                                flex: 1,
                                                child: Container(
                                                  padding: EdgeInsets.only(left: 15.0),
                                                  child: Align(
                                                    alignment: Alignment.bottomLeft,
                                                    child: Text(
                                                      data[index].nickname,
                                                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                                    ),
                                                  ),
                                                ),
                                              ),


                                              Expanded(
                                                flex: 1,
                                                child: Container(
                                                  child: Row(
                                                    children: <Widget>[
                                                      InkWell(
                                                        child: Align(
                                                          alignment: Alignment.topLeft,
                                                          
                                                          child: IconButton(
                                                            icon: new Icon(
                                                              Icons.water_rounded,
                                                              color: Colors.lightGreen.shade900,
                                                              size: 20.0,
                                                            ),
                                                            onPressed: () {
                                                                                                          
                                                            },
                                                          ),
                                                        ),
                                                      ),
                                                      Align(
                                                        alignment: Alignment.centerLeft,
                                                        child: Text(
                                                          remainingDaysString(data[index]),
                                                          style: TextStyle(
                                                              fontSize: 14,
                                                              color: Colors.lightGreen.shade900
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),

                                      Expanded(
                                        flex: 2,
                                        child: Container(
                                          height: 50,
                                          decoration: ShapeDecoration(
                                              color: Colors.white,
                                              shape: CircleBorder()
                                          ),
                                          child: WaterDropButton(),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  }

              ),
            ),
          ],
        ),
      ),
    );
  }
}

class WaterDropButton extends StatefulWidget {
  @override
  _WaterDropButtonState createState() => _WaterDropButtonState();
}

class _WaterDropButtonState extends State<WaterDropButton> {
  bool isWatered = false;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        isWatered ? Icons.check_rounded : Icons.water_rounded,
        color: Colors.lightGreen.shade900,
      ),
      onPressed: () {
        setState(() {
          isWatered = !isWatered;
        });
      },
    );
  }
}