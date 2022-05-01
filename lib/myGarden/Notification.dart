//
// import 'package:flutter/material.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:plantholic/NetworkHandler.dart';
//
// import 'package:plantholic/myGarden/Modelo/plant_info.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// class NotificationHelper {
//
//   NotificationHelper._privateConstructor();
//   static final NotificationHelper instance = NotificationHelper._privateConstructor();
//
//   FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
//
//   void _initNotifications() {
//     const initializationSettingsAndroid = AndroidInitializationSettings('@mipmap/ic_launcher');
//     const initializationSettingsIOS = IOSInitializationSettings();
//     const initializationSettings = InitializationSettings(initializationSettingsAndroid, initializationSettingsIOS);
//
//     flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
//     flutterLocalNotificationsPlugin.initialize(initializationSettings);
//   }
//
//   Future _preparePlantsNotifications(DateTime now, TimeOfDay notifHour) async {
//
//     final List<MyPlant> toNotifie = await NetworkHandler().get("/myplant/getData");
//     final List<int> notifiedDate = [];
//     int currentId = 0;
//
//     for (final plant in toNotifie) {
//       final DateTime notificationTime = DateTime.parse(plant.nextWaterDate);
//
//       if (notificationTime.isBefore(now) || notificationTime.isAtSameMomentAs(now)) {
//         continue;
//       }
//
//       if (!notifiedDate.contains(notificationTime.millisecondsSinceEpoch)) {
//         const androidPlatformChannelSpecifics = AndroidNotificationDetails('plantChannelId', 'plantChannel', 'Le salon de notification des plantes à arroser');
//         const iOSPlatformChannelSpecifics = IOSNotificationDetails();
//         const NotificationDetails platformChannelSpecifics = NotificationDetails(androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
//
//         await flutterLocalNotificationsPlugin.schedule(
//             currentId,
//             'Pluctis',
//             "Vous avez des plantes à arroser aujourd'hui !",
//             notificationTime,
//             platformChannelSpecifics,
//             androidAllowWhileIdle: true);
//
//         notifiedDate.add(notificationTime.millisecondsSinceEpoch);
//         currentId++;
//       }
//     }
//   }
//
//
//   Future prepareDailyNotifications() async {
//     if (flutterLocalNotificationsPlugin == null) {
//       _initNotifications();
//     }
//
//     final SharedPreferences prefs = await SharedPreferences.getInstance();
//     final TimeOfDay  notifHour = TimeOfDay(hour: prefs.getInt("notifHour") ?? 10, minute: prefs.getInt("notifMinute") ?? 00);
//     final DateTime now = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, notifHour.hour, notifHour.minute);
//
//     await flutterLocalNotificationsPlugin.cancelAll();
//
//     await _preparePlantsNotifications(now, notifHour);
//   }
//
// }