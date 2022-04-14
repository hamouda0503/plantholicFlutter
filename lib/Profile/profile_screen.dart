import 'package:flutter/material.dart';
import 'package:plantholic/app_colors.dart';
import 'components/body.dart';

class Profile extends StatefulWidget {

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.Grey,

      body: Column(
        children: [
          SizedBox(height: 60,),
          Body(),
        ],
      ),

    );
  }
}
