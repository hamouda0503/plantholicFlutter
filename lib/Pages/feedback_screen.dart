import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:plantholic/app_colors.dart';

import '../NetworkHandler.dart';

class FeedbackScreen extends StatefulWidget {
  @override
  _FeedbackScreenState createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  double sliderValue = 5;
  TextEditingController _body = TextEditingController();
  final _globalKey = GlobalKey<FormState>();
  NetworkHandler networkHandler = NetworkHandler();
 String name ="" ;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SafeArea(
        top: false,
        child: Scaffold(
          backgroundColor: AppColors.Grey,
          appBar: AppBar(
            backgroundColor: AppColors.Grey,
            elevation: 0,
            // title: Text(
            //   'Feedback',
            //   style: TextStyle(fontFamily: 'Butler',color: AppColors.Blue),
            // ),
            leading: InkWell(
              onTap: () async {
                Navigator.pop(context);
              },
              child: Icon(MdiIcons.arrowLeft, color: AppColors.Blue,),
            ),
          ),
          body: SingleChildScrollView(
            child: SizedBox(
              height: MediaQuery
                  .of(context)
                  .size
                  .height,
              child: Form(
                key: _globalKey,
                child: Column(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(
                          left: 16,
                          right: 16),
                      child: Image.asset('assets/feddbackPlant.jpg'),
                    ),
                    Container(
                      padding: const EdgeInsets.only(top: 8),
                      child: Text(
                        'Your FeedBack',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(top: 16),
                      child: const Text(
                        'Give your best time for this moment.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ),
                    _buildComposer(),
                    Padding(
                      padding: const EdgeInsets.only(top: 16),
                      child: Center(
                        child: Container(
                          width: 120,
                          height: 40,
                          decoration: BoxDecoration(
                            color: AppColors.Green,
                            borderRadius: BorderRadius.circular(50),
                            boxShadow: <BoxShadow>[
                              BoxShadow(
                                  color: Colors.grey.withOpacity(0.6),
                                  offset: const Offset(4, 4),
                                  blurRadius: 8.0),
                            ],
                          ),
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: () async {
                                if (_globalKey.currentState.validate() ) {
                                  // we will send the data to rest server
                                  var response = await networkHandler.get("/profile/checkProfile");
                                  name =response["username"];
                                  Map<String, String> data = {
                                    "feedback": _body.text,
                                    "username": name
                                  };
                                  print(data);
                                  var responsefeddback = await networkHandler.post1(
                                      "/feedback/feedcreate", data);
                                }
                              },
                              child: Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Text(
                                    'Send',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildComposer() {
    return Padding(
      padding: const EdgeInsets.only(top: 16, left: 32, right: 32),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 0.5,
              blurRadius: 6,
              offset: Offset(3, 5), // changes position of shadow
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(25),
          child: Container(
            padding: const EdgeInsets.all(4.0),
            constraints: const BoxConstraints(minHeight: 80, maxHeight: 160),
            color: Colors.white,
            child: SingleChildScrollView(
              padding:
              const EdgeInsets.only(left: 10, right: 10, top: 0, bottom: 0),
              child: TextFormField(
                controller: _body,
                validator: (value) {
                  if (value.isEmpty) {
                    return "Body can't be empty";
                  }
                  return null;
                },
                maxLines: null,
                // onChanged: (String txt) {},
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black45,
                ),
                cursorColor: Colors.blue,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Enter your feedback...'),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
