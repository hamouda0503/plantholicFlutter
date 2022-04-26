import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:plantholic/Pages/ForgetPassword.dart';
import 'package:plantholic/Pages/signup.dart';
import '../app_colors.dart';
import './animation/FadeAnimation.dart';
import '../NetworkHandler.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'ForgetPasswordcheck.dart';
import 'HomePage.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool vis = true;
  final _globalkey = GlobalKey<FormState>();
  NetworkHandler networkHandler = NetworkHandler();
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
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
            color: Colors.black,
          ),
        ),
      ),
      body: Container(
        height: 600,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: Form(
                key: _globalkey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        FadeAnimation(
                            1,
                            Text(
                              "Login",
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
                              "Login to your account",
                              style: TextStyle(
                                  fontSize: 15,
                                  fontFamily: 'Poppins'
                                  ,color: AppColors.Blue),
                            )),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 40),
                      child: Column(
                        children: <Widget>[
                          FadeAnimation(1.2, makeInput(label: "Username")),
                          FadeAnimation(
                              1.3, makeInputPassword(label: "Password")),
                          SizedBox(height: 5),
                         FadeAnimation(1.4,  Row(
                           mainAxisAlignment: MainAxisAlignment.center,
                           children: <Widget>[
                             SizedBox(width:140),
                             InkWell(
                               onTap: (){
                                 Navigator.push(
                                     context,
                                     MaterialPageRoute(
                                       builder: (context) => ForgetPasswordCheck(),
                                     )
                                 );
                               },
                               child: Text(
                                 "Forgot your password?",
                                 style: TextStyle(
                                     fontWeight: FontWeight.w600,
                                     fontSize: 12,
                                     fontFamily: 'Poppins'
                                     ,color: AppColors.Green),
                               ),
                             ),

                           ],
                         ),),
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
                                setState(() {
                                  circular = true;
                                });

                                //Login Logic start here
                                Map<String, String> data = {
                                  "username": _usernameController.text,
                                  "password": _passwordController.text,
                                };
                                var response = await networkHandler.post(
                                    "/user/login", data);

                                if (response.statusCode == 200 ||
                                    response.statusCode == 201) {
                                  Map<String, dynamic> output =
                                      json.decode(response.body);
                                  print(output["token"]);
                                  await storage.write(
                                      key: "token", value: output["token"]);
                                  setState(() {
                                    validate = true;
                                    circular = false;
                                  });
                                  Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => HomePage(),
                                      ),
                                      (route) => false);
                                } else {
                                  String output = json.decode(response.body);
                                  setState(() {
                                    validate = false;
                                    errorText = output;
                                    circular = false;
                                  });
                                }

                                // login logic End here
                              },
                              color: AppColors.Green,
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50)),
                              child: circular
                                  ? CircularProgressIndicator(color: AppColors.Grey,)
                                  : Text(
                                      "Login",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 18,
                                          fontFamily: 'Poppins'
                                          ,color: AppColors.Grey),
                                    ),
                            ),
                          ),
                        )),
                    FadeAnimation(
                        1.6,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              "Don't have an account?",
                              style: TextStyle(
                                  fontSize: 15, fontFamily: 'Poppins'
                                  ,color: AppColors.Blue),
                            ),
                            InkWell(
                              onTap: (){
                                Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => SignupPage(),
                                    ),
                                        (route) => false);
                              },
                              child: Text(
                                " Sign up",
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 15,
                                    fontFamily: 'Poppins'
                                    ,color: AppColors.Green),
                              ),
                            ),
                          ],
                        ))
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
        Container(
          decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30)
    ),
          child: TextField(

            obscureText: obscureText,
            controller: _usernameController,

          ),
        ),
        SizedBox(
          height: 30,
        ),
      ],
    );
  }

  Widget makeInputPassword({label}) {
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
          controller: _passwordController,
          obscureText: vis,
          decoration: InputDecoration(
            errorText: validate ? null : errorText,
            suffixIcon: IconButton(
              color: AppColors.Green,
              icon: Icon(vis ? Icons.visibility_off : Icons.visibility),
              onPressed: () {
                setState(() {
                  vis = !vis;
                });
              },
            ),
            helperStyle: TextStyle(
              fontSize: 14,
            ),
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
          height: 0,
        ),
      ],
    );
  }


}
