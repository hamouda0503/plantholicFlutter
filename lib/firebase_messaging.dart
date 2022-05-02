import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class FireBase_Messeging extends StatefulWidget {
  const FireBase_Messeging({Key key}) : super(key: key);

  @override
  State<FireBase_Messeging> createState() => _FireBase_MessegingState();
}

class _FireBase_MessegingState extends State<FireBase_Messeging> {
  final FirebaseMessaging _fc = FirebaseMessaging();
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    configureCallBacks(); 
  }
  @override
  Widget build(BuildContext context) {
    return Container();
  }

  void configureCallBacks() {
    _fc.configure(
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
}
