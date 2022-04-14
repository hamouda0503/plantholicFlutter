import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:plantholic/Blog/addBlog.dart';
import 'package:plantholic/Blog/ShowData.dart';
import 'package:plantholic/Blog/tips.dart';
import 'package:plantholic/Home/ui/home/home_screen.dart';
import 'package:plantholic/Home/ui/screens/home/home.dart';
import 'package:plantholic/Icons/ternav_icons.dart';
import 'package:plantholic/Pages/old/WelcomePage.dart';

import 'package:plantholic/Profile/ProfileScreen.dart';
import 'package:plantholic/Profile/profile_screen.dart';
import 'package:plantholic/Screen/TutoScreen.dart';
import 'package:plantholic/Screen/category.dart';
import 'package:plantholic/app_colors.dart';
import 'package:plantholic/detector/pages/landing_page/landing_page.dart';
import 'package:plantholic/myplant/home.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:plantholic/note/note_screen.dart';

import '../NetworkHandler.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentState = 0;
  final storage = FlutterSecureStorage();
  List<Widget> widgets = [HomeScreen(), ProfileScreen(),myplant(), ExploreMenu(),LandingPage()];
  List<String> titleString = ["Home", "Profile", "My Plants", "Tuto"];

  Widget profilePhoto = Container(
    height: 100,
    width: 100,
    child: CircleAvatar(
      radius: 50,
      backgroundImage: NetworkHandler().getImage(""),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.Grey,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.white,
          onPressed: () {
            // Navigator.of(context)
            //     .push(MaterialPageRoute(builder: (context) => LandingPage()));
            setState(() {
              currentState = 4;
            });
          },
          child: IconButton(
            onPressed: null,
            icon: Image.asset("assets/line-scan.png"),
            iconSize: 10,
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          color: Colors.white,
          shape: CircularNotchedRectangle(),
          notchMargin: 12,
          child: Container(
            height: 70,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  IconButton(
                    onPressed: () {
                      setState(() {
                        currentState = 0;
                      });
                    },
                    icon: FaIcon(FontAwesomeIcons.home),
                    iconSize: 30,
                    color: currentState == 0
                        ? AppColors.Green
                        : Colors.green.shade200,
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        currentState = 2;
                      });
                    },
                    icon: FaIcon(FontAwesomeIcons.leaf),
                    iconSize: 30,
                    color: currentState == 2
                        ? AppColors.Green
                        : Colors.green.shade200,
                  ),
                  SizedBox(
                    width: 45,
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        currentState = 3;
                      });
                    },
                    icon: FaIcon(FontAwesomeIcons.bookOpen),
                    iconSize: 30,
                    color: currentState == 3
                        ? AppColors.Green
                        : Colors.green.shade200,
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        currentState = 1;
                      });
                    },
                    icon: FaIcon(FontAwesomeIcons.userAlt),
                    iconSize: 30,
                    color: currentState == 1
                        ? AppColors.Green
                        : Colors.green.shade200,
                  ),
                ],
              ),
            ),
          ),
        ),
        body: widgets[currentState]);
  }

  void logout() async {
    await storage.delete(key: "token");
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => WelcomePage()),
        (route) => false);
  }
}
