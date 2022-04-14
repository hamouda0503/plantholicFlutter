import 'package:flutter/material.dart';

import 'package:plantholic/Home/ui/screens/home/widget_banner.dart';

import 'package:plantholic/Home/ui/screens/home/widget_title.dart';

import '../../../../app_colors.dart';

class Home extends StatefulWidget {
  const Home({ Key key }) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.Grey,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            WidgetBanner(),
            WidgetTitle(),

          ],
        ),
      ),
    );
  }
}