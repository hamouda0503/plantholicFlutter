
import 'package:flutter/material.dart';
import 'package:plantholic/Blog/Blogs.dart';

import '../app_colors.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.Grey,
      body: SingleChildScrollView(
        child: Blogs(
          url: "/blogpost/getOtherBlog",
        ),
      ),
    );
  }
}
