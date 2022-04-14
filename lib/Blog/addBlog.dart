import 'dart:convert';
import 'dart:io' as Io;
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:image_picker/image_picker.dart';
import 'package:plantholic/CustomWidget/OverlayCard.dart';
import 'package:plantholic/Model/addBlogModels.dart';
import 'package:plantholic/NetworkHandler.dart';
import 'package:plantholic/Pages/HomePage.dart';

import '../app_colors.dart';

class AddBlog extends StatefulWidget {
  const AddBlog({Key key}) : super(key: key);

  @override
  _AddBlogState createState() => _AddBlogState();
}

class _AddBlogState extends State<AddBlog> {
  TextEditingController _title = TextEditingController();
  TextEditingController _body = TextEditingController();
  TextEditingController _image ;
  final _globalKey = GlobalKey<FormState>();
  ImagePicker _picker = ImagePicker();
  PickedFile _imageFile;
  Io.File image;

  String img64 = "ahmed";
  IconData iconphoto = Icons.image;
  NetworkHandler networkHandler = NetworkHandler();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white54,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.clear,
            color: Colors.green,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          "Add Post",
          style: TextStyle(
              color: AppColors.Green, fontFamily: "Poppins", fontSize: 16),
        ),
      ),
      body: Container(
        child: Form(
          key: _globalKey,
          child: ListView(
            children: [
              titleTextField(),
              bodyTextField(),
              SizedBox(
                height: 20,
              ),
              addButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget titleTextField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
      child: TextFormField(
        controller: _title,
        validator: (value) {
          if (value.isEmpty) {
            return "Title can't be empty";
          } else if (value.length > 100) {
            return "Title length should be <=100";
          }
          return null;
        },
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.green),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: AppColors.Green,
              width: 2,
            ),
          ),
          labelText: "Add Image and title",
          labelStyle: TextStyle(
              color: AppColors.Green, fontFamily: "Poppins", fontSize: 16),
          prefixIcon: IconButton(
              icon: Icon(
                iconphoto,
                color: AppColors.Green,
              ),
              onPressed: takeCoverPhoto),
        ),
        maxLength: 100,
        maxLines: null,
      ),
    );
  }

  Widget bodyTextField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: TextFormField(
        controller: _body,
        validator: (value) {
          if (value.isEmpty) {
            return "Description can't be empty";
          }
          return null;
        },
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.Green),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: AppColors.Green,
              width: 2,
            ),
          ),
          labelText: "Description",
          labelStyle: TextStyle(
              color: AppColors.Green, fontFamily: "Poppins", fontSize: 16),
        ),
        maxLines: null,
      ),
    );
  }

  Widget addButton() {
    return InkWell(
      onTap: () async {
        if (_imageFile != null && _globalKey.currentState.validate()) {
          Uint8List bytes = await image.readAsBytes();
          setState(() {
            img64 = base64.encode(bytes);
            img64=base64.normalize(img64);
          });
          AddBlogModel addBlogModel = AddBlogModel(
              body: _body.text, title: _title.text, coverImage: img64);
          var response = await networkHandler.post1(
              "/blogpost/Add", addBlogModel.toJson());
          print(response.body);
          if (response.statusCode == 200 || response.statusCode == 201) {
            // String id = jsonDecode(response.body)["data"];
            // var imageresponse = await networkHandler.patchImage(
            //     "/blogpost/add/coverImage/$id", _imageFile.path);
            // print(imageresponse.statusCode);
            // if (imageresponse.statusCode == 200 ||
            //     imageresponse.statusCode == 201) {

            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => HomePage()),
                (route) => false);
          }
        }
      },
      child: Center(
        child: Container(
          height: 60,
          width: 200,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: AppColors.Green,
          ),
          child: Center(
            child: Text(
              "Add Post",
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontFamily: "Poppins",
                  fontSize: 16),
            ),
          ),
        ),
      ),
    );
  }

  void takeCoverPhoto() async {
    final coverPhoto = await _picker.getImage(source: ImageSource.gallery);
    setState(() async{
      _imageFile = coverPhoto;
      image =  await FlutterNativeImage.compressImage(_imageFile.path,quality:20, percentage: 50);
      iconphoto = Icons.check_box;
    });
  }
}
