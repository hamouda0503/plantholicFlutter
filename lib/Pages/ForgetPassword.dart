import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:plantholic/Pages/login.dart';
import 'package:plantholic/Pages/signup.dart';
import '../app_colors.dart';
import './animation/FadeAnimation.dart';
import '../NetworkHandler.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'HomePage.dart';

class EditPassword extends StatefulWidget {
  const EditPassword({Key key,this.name}) : super(key: key);
 final String name ;
  @override
  _EditPasswordState createState() => _EditPasswordState();
}

class _EditPasswordState extends State<EditPassword> {
  bool vis = true;
  final _globalkey = GlobalKey<FormState>();
  NetworkHandler networkHandler = NetworkHandler();
  TextEditingController _usernameController;
  TextEditingController _passwordController = TextEditingController();
  String errorText;
  bool validate = false;
  bool circular = false;
  final storage = new FlutterSecureStorage();
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    _usernameController = TextEditingController(text: widget.name);
  }

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
                              "Change your password",
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
                              1.3, makeInputPassword(label: "New Password")),
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
                                if(_globalkey.currentState.validate()) {
                                  Map<String, String> data = {
                                    "password": _passwordController.text
                                  };
                                  print("/user/update/${_usernameController
                                      .text}");
                                  var response = await networkHandler.patch(
                                      "/user/update/${_usernameController
                                          .text}", data);

                                  if (response.statusCode == 200 ||
                                      response.statusCode == 201) {
                                    print("/user/update/${_usernameController
                                        .text}");
                                    Navigator.pushAndRemoveUntil(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => LoginPage()),
                                            (route) => false);
                                  }
                                }
                                // login logic End here
                              },
                              color: AppColors.Green,
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50)),
                              child: circular
                                  ? CircularProgressIndicator()
                                  : Text(
                                "Update Password",
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
        TextFormField(
          obscureText: obscureText,
          enabled: false,
          style: TextStyle(color: Colors.grey),
          controller: _usernameController,

          decoration: InputDecoration(

            errorText: validate ? null : errorText,
            contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey[400])),
            border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey[400])),
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
        TextFormField(
          controller: _passwordController,
          validator: (value) {
            if (value.isEmpty) return "Password can't be empty";
            if (value.length < 8) return "Password lenght must have >=8";
            return null;
          },
          obscureText: vis,
          decoration: InputDecoration(
            errorText: validate ? null : errorText,
            suffixIcon: IconButton(
              icon: Icon(vis ? Icons.visibility_off : Icons.visibility ,color: AppColors.Green,),
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
          ),
        ),
        SizedBox(
          height: 0,
        ),
      ],
    );
  }
}
