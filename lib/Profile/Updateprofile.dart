import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:plantholic/Model/profileModel.dart';
import 'package:plantholic/Pages/HomePage.dart';
import 'package:plantholic/app_colors.dart';

import '../NetworkHandler.dart';

class UpdateProfile extends StatefulWidget {
  const UpdateProfile({Key key}) : super(key: key);

  @override
  _UpdateProfileState createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {
  PickedFile _imageFile;

  final ImagePicker _picker = ImagePicker();
  final _globalKey = GlobalKey<FormState>();
  TextEditingController _name = TextEditingController();
  TextEditingController _image = TextEditingController();

  TextEditingController _about = TextEditingController();
  final networkHandler = NetworkHandler();
  bool circular = false;
  ProfileModel profileModel = ProfileModel();
  String img64;
  File campimg;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  void fetchData() async {
    var response = await networkHandler.get("/profile/getData");
    setState(() {
      profileModel = ProfileModel.fromJson(response["data"]);
      _name = TextEditingController(text: profileModel.name);
      _image = TextEditingController(text: profileModel.img);
      _about = TextEditingController(text: profileModel.about);
      circular = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          // title: Text(
          //   'Feedback',
          //   style: TextStyle(fontFamily: 'Butler',color: AppColors.Blue),
          // ),
          leading: InkWell(
            onTap: () async {
              Navigator.pop(context);
            },
            child: Icon(
              MdiIcons.arrowLeft,
              color: AppColors.Blue,
            ),
          ),
        ),
        body: Container(
          // decoration: BoxDecoration(
          //   image: DecorationImage(
          //     image: AssetImage("assets/back.jpg"),
          //     fit: BoxFit.cover,
          //   ),
          // ),
          child: profileModel.img == null
              ? CircularProgressIndicator(
                  color: AppColors.Green,
                )
              : Form(
                  key: _globalKey,
                  child: ListView(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 20),
                    children: <Widget>[
                      SizedBox(
                        height: 45,
                      ),
                      imageProfile(),
                      SizedBox(
                        height: 20,
                      ),
                      nameTextField(),
                      SizedBox(
                        height: 20,
                      ),
                      // professionTextField(),
                      // SizedBox(
                      //   height: 20,
                      // ),
                      // dobTextField(),
                      // SizedBox(
                      //   height: 20,
                      // ),
                      // titleTextField(),
                      // SizedBox(
                      //   height: 20,
                      // ),
                      aboutTextField(),
                      SizedBox(
                        height: 20,
                      ),
                      Center(
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: MaterialButton(
                            minWidth: double.infinity,
                            height: 60,
                            onPressed: () async {
                              setState(() {
                                circular:
                                true;
                              });
                              if (_image.text != "" &&
                                  _globalKey.currentState.validate()) {
                                if (_imageFile != null) {
                                  Uint8List bytes = await campimg.readAsBytes();
                                  setState(() {
                                    img64 = base64.encode(bytes);
                                    img64 = base64.normalize(img64);
                                  });
                                }
                                Map<String, String> data = {
                                  "name": _name.text,
                                  "img": img64 == null ? _image.text : img64,
                                  "about": _about.text,
                                };
                                var response = await networkHandler.patch(
                                    "/profile/update", data);
                                if (response.statusCode == 200 ||
                                    response.statusCode == 201) {
                                  if (_imageFile != null) {
                                    // var imageResponse =
                                    //     await networkHandler.patchImage(
                                    //         "/profile/add/image", _imageFile.path);
                                    if (response.statusCode == 200) {
                                      setState(() {
                                        circular = false;
                                      });
                                      Navigator.of(context).pushAndRemoveUntil(
                                          MaterialPageRoute(
                                              builder: (context) => HomePage()),
                                          (route) => false);
                                    }
                                  } else {
                                    setState(() {
                                      circular = false;
                                    });
                                    Navigator.of(context).pushAndRemoveUntil(
                                        MaterialPageRoute(
                                            builder: (context) => HomePage()),
                                        (route) => false);
                                  }
                                }
                              }
                            },
                            color: AppColors.Green,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50)),
                            child: circular
                                ? CircularProgressIndicator()
                                : Text(
                                    "Update",
                                    style: TextStyle(
                                        letterSpacing: 1,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 18,
                                        color: AppColors.Grey,
                                        fontFamily: 'Poppins'),
                                  ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
        ),
      ),
    );
  }

  Widget imageProfile() {
    return Center(
      child: Stack(
        children: [
          CircleAvatar(
            radius: 73,
            backgroundColor: AppColors.Green,
            child: CircleAvatar(
              radius: 70.0,
              backgroundImage: _imageFile == null
                  ? imageFromBase64String(profileModel.img)
                  : FileImage(File(_imageFile.path)),
            ),
          ),
          Positioned(
            right: 0,
            bottom: 0,
            child: SizedBox(
              height: 46,
              width: 46,
              child: TextButton(
                style: TextButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                    side: BorderSide(color: Colors.white),
                  ),
                  primary: Colors.white,
                  backgroundColor: AppColors.Grey,
                ),
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    builder: ((builder) => bottomSheet()),
                  );
                },
                child: FaIcon(
                  FontAwesomeIcons.camera,
                  color: AppColors.Green,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  MemoryImage imageFromBase64String(String base64String) {
    return MemoryImage(base64.decode(base64String));
  }

  Widget bottomSheet() {
    return Container(
      height: 100.0,
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20,
      ),
      child: Column(
        children: <Widget>[
          Text(
            "Choose Profile photo",
            style: TextStyle(
                fontSize: 20.0, color: AppColors.Blue, fontFamily: "Poppins"),
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FlatButton.icon(
                  onPressed: () {
                    takePhoto(ImageSource.camera);
                  },
                  icon: Icon(
                    Icons.camera,
                    color: AppColors.Green,
                  ),
                  label: Text(
                    "Camera",
                    style:
                        TextStyle(color: AppColors.Blue, fontFamily: "Poppins"),
                  )),
              FlatButton.icon(
                  onPressed: () {
                    takePhoto(ImageSource.gallery);
                  },
                  icon: Icon(
                    Icons.image,
                    color: AppColors.Green,
                  ),
                  label: Text(
                    "Gallery",
                    style:
                        TextStyle(color: AppColors.Blue, fontFamily: "Poppins"),
                  ))
            ],
          ),
        ],
      ),
    );
  }

  void takePhoto(ImageSource source) async {
    final pickedFile = await _picker.getImage(
      source: source,
    );
    setState(() async {
      _imageFile = pickedFile;
      campimg = await FlutterNativeImage.compressImage(pickedFile.path,
          quality: 5, percentage: 80);
    });
  }

  Widget nameTextField() {
    return Stack(
      children: [
        Container(
          height: 60,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                spreadRadius: 0.5,
                blurRadius: 6,
                offset: Offset(3, 3), // changes position of shadow
              ),
            ],
            borderRadius: BorderRadius.circular(
              10.0,
            ),
          ),
        ),
        TextFormField(
          controller: _name,
          validator: (value) {
            if (value.isEmpty) return "Name can't be empty";

            return null;
          },
          decoration: InputDecoration(
            fillColor: Colors.white,
            filled: true,
            contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(color: Colors.white)),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(color: Colors.white)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(color: AppColors.Green)),

            prefixIcon: Icon(
              Icons.person,
              color: AppColors.Green,
            ),
            labelText: "Name",
            labelStyle: TextStyle(color: AppColors.Green),
            //helperText: "Name can't be empty",
            hintText: "your name",
          ),
        ),
      ],
    );
  }

  // Widget professionTextField() {
  //   return TextFormField(
  //     controller: _profession,
  //     validator: (value) {
  //       if (value.isEmpty) return "profession can't be empty";
  //
  //       return null;
  //     },
  //     decoration: InputDecoration(
  //       contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
  //       enabledBorder:
  //           OutlineInputBorder(borderSide: BorderSide(color: Colors.grey[400])),
  //       border:
  //           OutlineInputBorder(borderSide: BorderSide(color: Colors.grey[400])),
  //       focusedBorder:
  //           OutlineInputBorder(borderSide: BorderSide(color: AppColors.Green)),
  //       prefixIcon: Icon(
  //         Icons.work,
  //         color: AppColors.Green,
  //       ),
  //       labelText: "Profession",
  //       labelStyle: TextStyle(color: AppColors.Green),
  //       // helperText: "Profession  can't be empty",
  //       hintText: "your Proffession",
  //     ),
  //   );
  // }
  //
  // Widget dobTextField() {
  //   return TextFormField(
  //     controller: _DOB,
  //     validator: (value) {
  //       if (value.isEmpty) return "DOB can't be empty";
  //
  //       return null;
  //     },
  //     decoration: InputDecoration(
  //       contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
  //       enabledBorder:
  //           OutlineInputBorder(borderSide: BorderSide(color: Colors.grey[400])),
  //       border:
  //           OutlineInputBorder(borderSide: BorderSide(color: Colors.grey[400])),
  //       focusedBorder:
  //           OutlineInputBorder(borderSide: BorderSide(color: AppColors.Green)),
  //       prefixIcon: Icon(
  //         Icons.calendar_today,
  //         color: AppColors.Green,
  //       ),
  //       labelText: "Date Of Birth",
  //       labelStyle: TextStyle(color: AppColors.Green),
  //       // helperText: "Provide DOB on dd/mm/yyyy",
  //       hintText: "05/03/2000",
  //     ),
  //   );
  // }
  //
  // Widget titleTextField() {
  //   return TextFormField(
  //     controller: _title,
  //     validator: (value) {
  //       if (value.isEmpty) return "title can't be empty";
  //
  //       return null;
  //     },
  //     decoration: InputDecoration(
  //       contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
  //       enabledBorder:
  //           OutlineInputBorder(borderSide: BorderSide(color: Colors.grey[400])),
  //       border:
  //           OutlineInputBorder(borderSide: BorderSide(color: Colors.grey[400])),
  //       focusedBorder:
  //           OutlineInputBorder(borderSide: BorderSide(color: AppColors.Green)),
  //       prefixIcon: Icon(
  //         Icons.account_box,
  //         color: AppColors.Green,
  //       ),
  //       labelText: "Title",
  //       labelStyle: TextStyle(color: AppColors.Green),
  //       // helperText: "Title can't be empty",
  //       hintText: "work postion",
  //     ),
  //   );
  // }

  Widget aboutTextField() {
    return Stack(
      children: [
        Container(
          height: 130,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                spreadRadius: 0.5,
                blurRadius: 6,
                offset: Offset(3, 3), // changes position of shadow
              ),
            ],
            borderRadius: BorderRadius.circular(
              10.0,
            ),
          ),
        ),
        TextFormField(
          maxLines: 4,
          controller: _about,
          validator: (value) {
            if (value.isEmpty) return "about can't be empty";

            return null;
          },
          decoration: InputDecoration(
            fillColor: Colors.white,
            filled: true,
            contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(color: Colors.white)),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(color: Colors.white)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(color: AppColors.Green)),
            prefixIcon: Icon(
              Icons.description,
              color: AppColors.Green,
            ),
            labelText: "About",
            labelStyle: TextStyle(color: AppColors.Green),
            hintText: "Describe yourself",
          ),
        ),
      ],
    );
  }
}
