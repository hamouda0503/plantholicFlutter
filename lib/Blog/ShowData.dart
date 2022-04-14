import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:plantholic/Blog/soil.dart';
import 'package:plantholic/Pages/old/WelcomePage.dart';
import 'package:plantholic/Pages/feedback_screen.dart';

import '../NetworkHandler.dart';
import '../app_colors.dart';
import 'dictionary.dart';
import 'tips.dart';


class ShowData extends StatefulWidget {
  const ShowData({Key key,this.page}) : super(key: key);
  final int page ;

  @override
  _ShowDataState createState() => _ShowDataState();
}

class _ShowDataState extends State<ShowData> {
  final storage = FlutterSecureStorage();
  final List<Widget> _pages=[

    Tips(),
    SoilList(),
    Dictionary(),
    FeedbackScreen()


  ];
  Widget profilePhoto = Container(
    height: 100,
    width: 100,
    child: CircleAvatar(
      radius: 50,
      backgroundImage: NetworkHandler().getImage("devStack06"),
    ),
  );

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColors.Grey,
        body: Stack(
        children: [
        Center(
        child:_pages[widget.page],
    ),],),);
  }
  void logout()async{
    await storage.delete(key: "token");
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>WelcomePage()), (route) => false);
  }
}
