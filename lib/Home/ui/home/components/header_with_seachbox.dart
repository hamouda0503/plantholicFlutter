import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:plantholic/Model/profileModel.dart';
import 'package:plantholic/Profile/mainprofile/appointment_page.dart';
import 'package:plantholic/Profile/profile_screen.dart';
import 'package:plantholic/Weather/screens/loading_screen.dart';

import '../../../../NetworkHandler.dart';
import '../../../../app_colors.dart';



class HeaderWithSearchBox extends StatefulWidget {
  const HeaderWithSearchBox({
    Key key,
    @required this.size,
  }) : super(key: key);

  final Size size;

  @override
  State<HeaderWithSearchBox> createState() => _HeaderWithSearchBoxState();
}

class _HeaderWithSearchBoxState extends State<HeaderWithSearchBox> {
  NetworkHandler networkHandler = NetworkHandler();
  ProfileModel profileModel = ProfileModel();
  @override
  void initState() {
    super.initState();

    fetchData();
  }

  void fetchData() async {
    var response = await networkHandler.get("/profile/getData");
    setState(() {
      profileModel = ProfileModel.fromJson(response["data"]);
    });
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 0),
      // It will cover 20% of our total height
      height: widget.size.height * 0.3,
      child: Stack(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(
              left: 20,
              right: 20,
              bottom: 56,
              top: 40,
            ),
            height: widget.size.height*0.25,
            decoration: BoxDecoration(
              color: AppColors.Grey,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child:  Row(
                children: [
                  InkWell(
                    child: CircleAvatar(
                      backgroundImage:profileModel.img==null?null: MemoryImage(base64.decode(profileModel.img)),
                      radius: 25.0,
                      backgroundColor: Colors.transparent,
                    ),
                    onTap: (){
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProfileData(),
                          )
                      );
                    },
                  ),
                  SizedBox(
                    width: 15.0,
                  ),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "Hello,\n",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontFamily: "Poppins",
                            fontSize: 14.0,
                            color: Color(0xFFFD9872),
                          ),
                        ),
                        TextSpan(
                          text: profileModel.username,
                          style: TextStyle(
                            fontFamily: "Butler",
                            fontSize: 20.0,
                            fontWeight: FontWeight.w600,
                            color: AppColors.Blue,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Spacer(),
                  IconButton(
                    icon: Icon(
                      MdiIcons.weatherCloudy,
                      color: AppColors.Green,
                    ),
                    onPressed: () {Navigator.push(context, MaterialPageRoute( builder: (context) => LoadingScreen(),));},
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.notifications,
                      color: AppColors.Green,
                    ),
                    onPressed: () {},
                  )
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 40,
            left: 0,
            right: 0,
            child: Container(
              alignment: Alignment.center,
              margin: EdgeInsets.symmetric(horizontal: 20),
              padding: EdgeInsets.symmetric(horizontal: 20),
              height: 54,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(32),
                boxShadow: [
                  BoxShadow(
                    offset: Offset(0, 3),
                    blurRadius: 5,
                    color: AppColors.Green.withOpacity(0.2),
                  ),
                ],
              ),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      onChanged: (value) {},
                      decoration: InputDecoration(
                        hintText: "Search",
                        hintStyle: TextStyle(
                          color: AppColors.Green.withOpacity(0.5),
                        ),
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                         suffixIcon: IconButton(onPressed: null,
                         icon: Icon(Icons.search_rounded,color:AppColors.Green ,)),
                      ),
                    ),
                  ),
                  // SvgPicture.asset("assets/icons/search.svg"),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
