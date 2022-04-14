import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:plantholic/Blog/Blogs.dart';
import 'package:plantholic/Pages/feedback_screen.dart';
import 'package:plantholic/Pages/main.dart';
import 'package:plantholic/Profile/Updateprofile.dart';
import 'package:plantholic/Profile/mainprofile/appointment_page.dart';
import 'package:plantholic/Screen/TutoScreen.dart';
import 'package:plantholic/app_colors.dart';

import '../../NetworkHandler.dart';
import '../MainProfile.dart';
import 'profile_menu.dart';
import 'profile_pic.dart';

class Body extends StatefulWidget {
  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final storage = FlutterSecureStorage();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(vertical: 15),
      child: Column(
        children: [
          ProfilePic(),
          SizedBox(height: 20),
          ProfileMenu(
            text: "My Account",
            icon: FaIcon(
              FontAwesomeIcons.user,
              color: AppColors.Green,
            ),
            press: () => {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ProfileData()))
            },
          ),
          ProfileMenu(
            text: "Notifications",
            icon: FaIcon(
              FontAwesomeIcons.bell,
              color: AppColors.Green,
            ),
            press: () {},
          ),
          ProfileMenu(
            text: "My Articles",
            icon: FaIcon(
              FontAwesomeIcons.fileAlt,
              color: AppColors.Green,
            ),
            press: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => TutoScreen(
                            url: "/blogpost/getOwnBlog",
                          )));
            },
          ),
          ProfileMenu(
            text: "FeedBack",
            icon: FaIcon(
              FontAwesomeIcons.comment,
              color: AppColors.Green,
            ),
            press: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => FeedbackScreen()));
            },
          ),
          ProfileMenu(
            text: "Log Out",
            icon: FaIcon(
              FontAwesomeIcons.arrowAltCircleLeft,
              color: AppColors.Green,
            ),
            press: () {
              logout();
            },
          ),
        ],
      ),
    );
  }

  void logout() async {
    await storage.delete(key: "token");
    Navigator.pushAndRemoveUntil(context,
        MaterialPageRoute(builder: (context) => HomePage()), (route) => false);
  }
}
