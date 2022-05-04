import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:plantholic/myplant/home.dart';

import 'TipComponent.dart';
import 'featurred_plants.dart';
import 'header_with_seachbox.dart';
import 'recomend_plants.dart';
import 'title_with_more_bbtn.dart';

class Body extends StatefulWidget {
  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  
  FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
String messageTitle = "Empty";
String notificationAlert = "alert";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  fcm();
  configureCallBacks();
  subscribeToEvent();
  }

  void subscribeToEvent(){
    _firebaseMessaging.subscribeToTopic('Events');
  }

  void configureCallBacks() {
    _firebaseMessaging.configure(
      onMessage: (message) async {
        showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  content: ListTile(
                    subtitle: Text("onMessage"),
                  ),
                  actions: [
                    FlatButton(onPressed: ()=>Navigator.of(context).pop(), child: Text("ok"))
                  ],
                ));
      },
      onResume: (message) async {
        showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  content: ListTile(
                    subtitle: Text("onResume"),
                  ),
                  actions: [
                    FlatButton(onPressed: ()=>Navigator.of(context).pop(), child: Text("ok"))
                  ],
                ));
      },
      onLaunch: (message) async {
        showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  content: ListTile(
                    subtitle: Text("onLaunch"),
                  ),
                  actions: [
                    FlatButton(onPressed: ()=>Navigator.of(context).pop(), child: Text("ok"))
                  ],
                ));
      },
    );
  }
  
 
void fcm() async{

  final fcmToken = await FirebaseMessaging().getToken();
    print(fcmToken);
}


 
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          HeaderWithSearchBox(size: size),
          TipComponent(),
          TitleWithMoreBtn(
              title: "Recomended Plants",
              press: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => myplant()));
              }),
          RecomendsPlants(),
          TitleWithMoreBtn(title: "Featured Tutos", press: () {}),
          // FeaturedPlants(),
          SizedBox(height: 20),
          ],
      ),
    );
  }
}
