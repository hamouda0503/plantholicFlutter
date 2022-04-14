import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:plantholic/app_colors.dart';
import 'package:plantholic/onboarding/Onboarding.dart';
import 'package:plantholic/onboarding/introduction_animation/introduction_animation_screen.dart';



class SplashScreen extends StatefulWidget {
  SplashScreen({Key key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    //set time to load the new page
    Future.delayed(Duration(seconds: 7), () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => IntroductionAnimationScreen()));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.Grey,
      body: Container(
        color: AppColors.Grey,
        alignment: Alignment.center,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            new Container(
              child: Lottie.asset('assets/logoplantholic.json')),
            // SizedBox(
            //     child: Lottie.asset('assets/logoplantholic.json')),

          ],
        ),
      ),
    );
  }
}