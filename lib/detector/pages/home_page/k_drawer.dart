import 'package:flutter/material.dart';
import '../how_to_use/how_to_use.dart';
import 'package:url_launcher/url_launcher.dart';

class KDrawer extends StatelessWidget {
  final Uri _emailLaunchUri = Uri(
      scheme: 'mailto',
      path: 'plant.app.bugs.report@gmail.com',
      queryParameters: {'subject': 'Bug Report'});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            color: Theme.of(context).accentColor,
            width: double.infinity,
            height: 100,
            child: DrawerHeader(
              child: Center(
                child: Text(
                  'Plant Disease Detector',
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'cascadia',
                    fontSize: 18,
                  ),
                ),
              ),
            ),
          ),
          InkWell(
            onTap: () {
              launch(_emailLaunchUri.toString());
            },
            child: ListTile(
              title: Text(
                'Report Bug!',
                style: TextStyle(
                  fontFamily: 'cascadia',
                  color: Theme.of(context).accentColor,
                  fontSize: 16,
                ),
              ),
            ),
          ),
          Divider(),
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => HowToUsePage(),
                ),
              );
            },
            child: ListTile(
              title: Text(
                'How to use',
                style: TextStyle(
                  fontFamily: 'cascadia',
                  color: Theme.of(context).accentColor,
                  fontSize: 16,
                ),
              ),
            ),
          ),
          Divider(),
        ],
      ),
    );
  }
}
