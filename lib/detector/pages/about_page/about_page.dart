import 'package:flutter/material.dart';
import '../how_to_use/how_to_use.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutPage extends StatelessWidget {
  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    final Uri _emailLaunchUri = Uri(
        scheme: 'mailto',
        path: 'plant.app.bugs.report@gmail.com',
        queryParameters: {'subject': 'Bug Report'});

    final defaultTextStyle = TextStyle(fontFamily: 'cascadia');

    return Container(
      child: Scrollbar(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Divider(color: Colors.grey),
              SizedBox(height: 8),
              Text(
                'Plant Disease Detector',
                style: defaultTextStyle,
              ),
              SizedBox(height: 8),
              Divider(color: Colors.grey),
              ListTile(
                leading: Icon(Icons.email),
                title: Text(
                  'Report bug!',
                  style: defaultTextStyle,
                ),
                onTap: () {
                  launch(_emailLaunchUri.toString());
                },
              ),
              Divider(color: Colors.grey),
              ListTile(
                leading: Icon(Icons.help_center_rounded),
                title: Text(
                  'How to use',
                  style: defaultTextStyle,
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HowToUsePage(),
                      ));
                },
              ),
              Divider(color: Colors.grey),
              SizedBox(height: 34),
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Text(
                  'Close',
                  style: TextStyle(
                    color: Theme.of(context).accentColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
