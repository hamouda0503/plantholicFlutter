import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:plantholic/Pages/ForgetPasswordcheck.dart';

import 'package:plantholic/Pages/old/SignUpPage.dart';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:plantholic/Pages/splashscreen.dart';
import 'package:plantholic/Weather/screens/loading_screen.dart';
import 'package:plantholic/reference/models/photo_model.dart';
import 'package:plantholic/test.dart';
import 'package:provider/provider.dart';

import 'Pages/HomePage.dart';
import 'Weather/models/weather_provider.dart';
import 'onboarding/Onboarding.dart';

// import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
// FlutterLocalNotificationsPlugin();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // var initializationSettingsAndroid = AndroidInitializationSettings("icon");
  //
  // var initializationSettings =
  // InitializationSettings(android: initializationSettingsAndroid);
  //
  // await flutterLocalNotificationsPlugin.initialize(initializationSettings,
  //     onSelectNotification: (String payload) async {
  //       if (payload != null) {
  //         debugPrint("notificacion payload: " + payload);
  //       }
  //     });
  await Hive.initFlutter();
  Hive.registerAdapter(PhotoModelAdapter());
  await Hive.openBox<PhotoModel>('favorites');
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Widget page = null;
  final storage = FlutterSecureStorage();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkLogin();
  }

  void checkLogin() async {
    String token = await storage.read(key: "token");
    if (token != null) {
      setState(() {
        page = HomePage();
      });
    } else {
      setState(() {
        page = SplashScreen();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<WeatherData>(
      create: (BuildContext context) => WeatherData(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: page,
      ),
    );
  }
}




