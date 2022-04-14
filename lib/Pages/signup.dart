import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:plantholic/Pages/login.dart';
import 'package:plantholic/Profile/ProfileScreen.dart';
import 'package:plantholic/app_colors.dart';
import './animation/FadeAnimation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'form_validator.dart'as valid;
import '../NetworkHandler.dart';
import 'HomePage.dart';

class SignupPage extends StatefulWidget {
  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  bool vis = true;
  final _globalkey = GlobalKey<FormState>();
  NetworkHandler networkHandler = NetworkHandler();
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  String errorText;
  bool validate = false;
  bool circular = false;
  final storage = new FlutterSecureStorage();
  static final FacebookLogin facebookSignIn = new FacebookLogin();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
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
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 40),
          height: 650,
          width: double.infinity,
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
                          "Sign up",
                          style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: AppColors.Blue,
                              fontFamily: 'Butler'),
                        )),
                    SizedBox(
                      height: 20,
                    ),
                    FadeAnimation(
                        1.2,
                        Text(
                          "Create an account, It's free",
                          style: TextStyle(
                              fontSize: 15,
                              color: AppColors.Blue,
                              fontFamily: 'Poppins'),
                        )),
                  ],
                ),
                Column(
                  children: <Widget>[
                    FadeAnimation(1.1, makeInput(label: "username")),
                    FadeAnimation(1.2, makeInputEmail(label: "Email")),
                    FadeAnimation(1.3,
                        makeInputPassword(label: "Password", obscureText: true)),
                  ],
                ),
                FadeAnimation(
                    1.5,
                    Container(
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
                          await checkUser();
                          if (_globalkey.currentState.validate() && validate) {
                            // we will send the data to rest server
                            Map<String, String> data = {
                              "username": _usernameController.text,
                              "email": _emailController.text,
                              "password": _passwordController.text,
                            };
                            print(data);
                            var responseRegister =
                                await networkHandler.post("/user/register", data);

                            //Login Logic added here
                            if (responseRegister.statusCode == 200 ||
                                responseRegister.statusCode == 201) {
                              Map<String, String> data = {
                                "username": _usernameController.text,
                                "password": _passwordController.text,
                              };
                              var response =
                                  await networkHandler.post("/user/login", data);

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
                                      builder: (context) => ProfileScreen(),
                                    ),
                                    (route) => false);
                              } else {
                                Scaffold.of(context).showSnackBar(
                                    SnackBar(content: Text("Netwok Error")));
                              }
                            }

                            //Login Logic end here

                            setState(() {
                              circular = false;
                            });
                          } else {
                            setState(() {
                              circular = false;
                            });
                          }
                        },
                        color: AppColors.Green,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50)),
                        child: circular
                            ? CircularProgressIndicator(
                                color: AppColors.Grey,
                              )
                            : Text(
                                "Sign up",
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 18,
                                    color: AppColors.Grey,
                                    fontFamily: 'Poppins'),
                              ),
                      ),
                    )),
                FadeAnimation(
                    1.6,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text("Already have an account?",
                            style: TextStyle(
                                color: AppColors.Blue, fontFamily: 'Poppins')),
                        InkWell(
                          onTap: () {
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => LoginPage(),
                                ),
                                (route) => false);
                          },
                          child: Text(
                            " Login",
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: AppColors.Green,
                                fontFamily: 'Poppins'),
                          ),
                        ),
                      ],
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }

  checkUser() async {
    if (_usernameController.text.length == 0) {
      setState(() {
        // circular = false;
        validate = false;
        errorText = "Username Can't be empty";
      });
    } else {
      var response = await networkHandler
          .get("/user/checkUsername/${_usernameController.text}");
      if (response['Status']) {
        setState(() {
          // circular = false;
          validate = false;
          errorText = "Username already taken";
        });
      } else {
        setState(() {
          // circular = false;
          validate = true;
        });
      }
    }
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
        TextFormField(
          controller: _usernameController,
          obscureText: obscureText,
          decoration: InputDecoration(
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
          height: 15,
        ),
      ],
    );
  }

  Widget makeInputEmail({label, obscureText = false}) {
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
        TextFormField(
          obscureText: obscureText,
          controller: _emailController,
          validator:(value){
            String email =
                r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
            RegExp regExp = new RegExp(email);
            if (value.length == 0) {
              return "Email is required";
            } else if (!regExp.hasMatch(value)) {
              return "Invalid address";
            } else {
              return null;
            }
          },

          decoration: InputDecoration(
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
          height: 15,
        ),
      ],
    );
  }

  // String checkEmail(String deger) {
  //   String email =
  //       r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  //   RegExp regExp = new RegExp(email);
  //   if (deger.length == 0) {
  //     return "Email is required";
  //   } else if (!regExp.hasMatch(deger)) {
  //     return "Invalid address";
  //   } else {
  //     return null;
  //   }
  // }

  Widget makeInputPassword({label, obscureText = false}) {
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
        TextFormField(
          controller: _passwordController,
          validator: (value) {
            if (value.isEmpty) return "Password can't be empty";
            if (value.length < 8) return "Password lenght must have >=8";
            return null;
          },
          obscureText: vis,
          decoration: InputDecoration(
            suffixIcon: IconButton(
              color: AppColors.Green,
              icon: Icon(vis ? Icons.visibility_off : Icons.visibility),
              onPressed: () {
                setState(() {
                  vis = !vis;
                });
              },
            ),
            helperText: "Password length should have >=8",
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
          height: 5,
        ),
      ],
    );
  }
}
