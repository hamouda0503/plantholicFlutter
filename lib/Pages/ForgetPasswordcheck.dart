import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:plantholic/Pages/ForgetPasswordChange.dart';
import 'package:plantholic/Pages/login.dart';
import 'package:plantholic/Pages/signup.dart';
import '../app_colors.dart';
import './animation/FadeAnimation.dart';
import '../NetworkHandler.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:plantholic/Model/response_model.dart';
import 'HomePage.dart';

class ForgetPasswordCheck extends StatefulWidget {
  const ForgetPasswordCheck({Key key}) : super(key: key);

  @override
  _ForgetPasswordCheckState createState() => _ForgetPasswordCheckState();
}

class _ForgetPasswordCheckState extends State<ForgetPasswordCheck> {
  bool vis = true;
  final _globalkey = GlobalKey<FormState>();
  NetworkHandler networkHandler = NetworkHandler();
  TextEditingController _emailController = TextEditingController();
  String errorText;
  bool validate = false;
  bool circular = false;
  final storage = new FlutterSecureStorage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.Grey,
      appBar: AppBar(
        elevation: 0,
        brightness: Brightness.light,
        backgroundColor: AppColors.Grey,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            size: 20,
            color: AppColors.Blue,
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/forget.jpg"),
            fit: BoxFit.cover,
          ),),

        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: Form(
                key: _globalkey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,

                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        SizedBox(
                          height: 30,
                        ),
                        FadeAnimation(
                            1,
                            Text(
                              "Forgot Password",
                              style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Butler',color: AppColors.Blue),
                            )),
                        SizedBox(
                          height: 20,
                        ),
                        FadeAnimation(
                            1.2,
                            Text(
                              "let's check your identity",
                              style: TextStyle(
                                  fontSize: 15,
                                  fontFamily: 'Poppins'
                                  ,color: AppColors.Blue),
                            )),
                        SizedBox(
                          height: 25,
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 40),
                      child: Column(
                        children: <Widget>[
                          FadeAnimation(1.2, makeInput(label: "email")),

                          SizedBox(height: 5),

                        ],
                      ),
                    ),
                    FadeAnimation(
                        1.5,
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 40),
                          child: Container(

                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: MaterialButton(
                              minWidth: double.infinity,
                              height: 60,
                              onPressed: () async {
                                ResponseModel response = await networkHandler.forgetPassword(_emailController.text);
                                print(response.message);
                                String a =response.message;
                                if (response.ok==true) {
                                  Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => ForgetPasswordChange(username: a,)),
                                          (route) => false);
                                }
                              },
                              color: AppColors.Green,
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50)),
                              child: circular
                                  ? CircularProgressIndicator()
                                  : Text(
                                "check",
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 18,
                                    fontFamily: 'Poppins'
                                    ,color: AppColors.Grey),
                              ),
                            ),
                          ),
                        )),

                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget makeInput({label, obscureText = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          label,
          style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w400,
              color: AppColors.Blue,
              fontFamily: 'Poppins'),
        ),
        SizedBox(
          height: 5,
        ),
        TextField(

          obscureText: obscureText,
          controller: _emailController,
          decoration: InputDecoration(
            fillColor: Colors.white,
            filled: true,
            errorText: validate ? null : errorText,
            contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey[400])),
            border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey[400])),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: AppColors.Green)),
          ),
        ),
        SizedBox(
          height: 30,
        ),
      ],
    );
  }


}
