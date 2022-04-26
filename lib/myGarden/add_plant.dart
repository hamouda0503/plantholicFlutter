import 'dart:io';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:plantholic/app_colors.dart';
import '../NetworkHandler.dart';
import './Modelo/plant_info.dart';
import 'package:flutter_time_picker_spinner/flutter_time_picker_spinner.dart';
import 'package:day_picker/day_picker.dart';
import 'package:timezone/timezone.dart';
import 'package:direct_select/direct_select.dart';

class AddInfoPlant extends StatefulWidget {

  @override
  _AddInfoPlantState createState() => _AddInfoPlantState();
final String spieces;
final String name;
  AddInfoPlant({this.spieces,this.name});
}

class _AddInfoPlantState extends State<AddInfoPlant> {
  var _dateTime = DateTime.now();
  final networkHandler = NetworkHandler();

  TextEditingController plantnameContorller = TextEditingController();
  TextEditingController specieControlller = TextEditingController();
  TextEditingController nicknameControlller = TextEditingController();
  TextEditingController lastwateredControlller = TextEditingController();
  TextEditingController spotControlller = TextEditingController();
  bool circular = false;
  String img64;

  PickedFile _imageFile;

  final ImagePicker _picker = ImagePicker();
  File campimg ;
  final _globalKey = GlobalKey<FormState>();

  final elements1 = [
    "Bromeliads",
    "Cactus",
    "Ferns",
    "Figs",
    "Ivy",
    "Palms",
    "Other"
  ];
  final elements2 = [
    "InDoor",
    "OutDoor"
  ];

  int selectedIndex1 = 0,
      selectedIndex2 = 0;

  List<Widget> _buildItems1() {
    return elements1
        .map((val) => MySelectionItem(
      title: val,
    ))
        .toList();
  }

  List<Widget> _buildItems2() {
    return elements2
        .map((val) => MySelectionItem(
      title: val,
    ))
        .toList();
  }


  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green[300],
          title: Text(
            "Add a plant",
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        //Save Button
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.white,
          child: SvgPicture.asset(
          'assets/svg/save.svg',
          width: 35,
          height: 35,
        ),
        onPressed: () async {

          try {
            Map<String, String> data = {
              "plant_name":plantnameContorller.text,
              "nickname":nicknameControlller.text,
              "spot":"bouba12345",
              "image":"bouba12345",
              "specie":"",
              "lastWatered":"bouba12345",
              "waterCycle":"bouba12345",
              "nextWater":"",
              "nextWaterDate":"bouba12345"
            };
            print (data);
            var response = await networkHandler.post("/myplant/addPlant", data);
            if (response.statusCode == 200 || response.statusCode == 201) {
              Navigator.pop(context);
            }
          } catch (e) {
            Scaffold.of(context).showSnackBar(
                SnackBar(content: Text("There is missing information")));
          }

        },
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Center(
          child: Form(
            key: _globalKey,
            child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                children: <Widget>[
                  SizedBox(
                    height: 45,
                  ),
                  imageProfile(),
                  SizedBox(
                    height: 20,
                  ),
                  plantnameTextField(),
                  SizedBox(
                    height: 20,
                  ),
                  nickameTextField(),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Text(
                      "Specie :",
                      style: TextStyle(
                          color: Colors.grey, fontWeight: FontWeight.w500,fontFamily: "Poppins"),
                    ),
                  ),
                  DirectSelect(
                      itemExtent: 50.0,
                      selectedIndex: selectedIndex1,
                      backgroundColor: AppColors.Grey,
                      child: MySelectionItem(
                        isForList: false,
                        title: elements1[selectedIndex1],
                      ),
                      onSelectedItemChanged: (index) {
                        setState(() {
                          selectedIndex1 = index;
                        });
                      },
                      items: _buildItems1()),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0, top: 20.0),
                    child: Text(
                      "Spot : ",
                      style: TextStyle(
                          color: Colors.grey, fontWeight: FontWeight.w500,fontFamily: "Poppins"),
                    ),
                  ),
                  DirectSelect(
                      itemExtent: 45.0,
                      selectedIndex: selectedIndex2,
                      backgroundColor: AppColors.Grey,
                      child: MySelectionItem(
                        isForList: false,
                        title: elements2[selectedIndex2],
                      ),
                      onSelectedItemChanged: (index) {
                        setState(() {
                          selectedIndex2 = index;
                        });
                      },
                      items: _buildItems2()),

                ]),
          ),
        ),
      ),
    );
  }

  Padding plantIconButton(String svgAsset) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SvgPicture.asset(
        'assets/svg/$svgAsset',
        width: 50,
        height: 50,
      ),
    );
  }

  Padding textField(
      String hint, String stringTarget, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.all(0.8),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 0.8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.green[900],
              spreadRadius: 1,
              blurRadius: 7,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: TextField(
          decoration: InputDecoration(
            hintText: hint,
          ),
          controller: controller,
          onChanged: (value) => stringTarget = value,
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
                  ? AssetImage("assets/feddbackPlant.jpg")
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
                  icon: Icon(Icons.camera ,color: AppColors.Green,),
                  label: Text(
                    "Camera",
                    style:
                    TextStyle(color: AppColors.Blue, fontFamily: "Poppins"),
                  )),
              FlatButton.icon(
                  onPressed: () {
                    takePhoto(ImageSource.gallery);
                  },
                  icon: Icon(Icons.image,color: AppColors.Green,),
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
      campimg = await FlutterNativeImage.compressImage(pickedFile.path,quality:5, percentage: 80);
    });
  }

  Widget plantnameTextField() {
    return TextFormField(
      controller: plantnameContorller,
      validator: (value) {
        if (value.isEmpty) return "Plant Name can't be empty";

        return null;
      },
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 20),
        enabledBorder:
        OutlineInputBorder(borderSide: BorderSide(color: Colors.grey[400])),
        border:
        OutlineInputBorder(borderSide: BorderSide(color: Colors.grey[400])),
        focusedBorder:
        OutlineInputBorder(borderSide: BorderSide(color: AppColors.Green)),
        prefixIcon: Icon(
          Icons.person,
          color: AppColors.Green,
        ),
        fillColor: Colors.white,
        filled: true,
        labelText: " Plant Name",
        labelStyle: TextStyle(color: AppColors.Green),
        //helperText: "Name can't be empty",
        hintText: "your Plant name",
      ),
    );
  }
    Widget nickameTextField() {
      return TextFormField(
        controller: plantnameContorller,
        validator: (value) {
          if (value.isEmpty) return "nickname can't be empty";
          return null;
        },
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 20),
          enabledBorder:
          OutlineInputBorder(borderSide: BorderSide(color: Colors.grey[400])),
          border:
          OutlineInputBorder(borderSide: BorderSide(color: Colors.grey[400])),
          focusedBorder:
          OutlineInputBorder(borderSide: BorderSide(color: AppColors.Green)),
          prefixIcon: Icon(
            Icons.person,
            color: AppColors.Green,
          ),
          fillColor: Colors.white,
          filled: true,
          labelText: "Nickname",
          labelStyle: TextStyle(color: AppColors.Green),
          //helperText: "Name can't be empty",
          hintText: "Nickname",
        ),
      );
  }


}

class MySelectionItem extends StatelessWidget {
  final String title;
  final bool isForList;
  const MySelectionItem({Key key, this.title, this.isForList = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50.0,
      child: isForList
          ? Padding(
        child: _buildItem(context),
        padding: EdgeInsets.all(10.0),
      )
          : Card(
        margin: EdgeInsets.symmetric(horizontal: 1.0),
        child: Stack(
          children: <Widget>[
            _buildItem(context),
            Align(
              alignment: Alignment.centerRight,
              child: Icon(Icons.arrow_drop_down),
            )
          ],
        ),
      ),
    );
  }

  _buildItem(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      alignment: Alignment.center,
      child: Text(title
      ,style: TextStyle(fontFamily: "Poppins",color: AppColors.Green),),
    );
  }
}
