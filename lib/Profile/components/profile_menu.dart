import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:plantholic/app_colors.dart';


class ProfileMenu extends StatelessWidget {
  const ProfileMenu({
    Key key,
    @required this.text,
    this.icon,
    this.press,
  }) : super(key: key);

  final String text;
 final  Widget icon;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Container(
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 0.5,
            blurRadius: 6,
            offset: Offset(3, 5), // changes position of shadow
          ),
        ],),
        child: TextButton(
          style: TextButton.styleFrom(
            primary: AppColors.Blue,
            padding: EdgeInsets.all(20),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            backgroundColor: Colors.white,
          ),
          onPressed: press,
          child: Row(
            children: [
              icon,
              SizedBox(width: 20),
              Expanded(child: Text(text,style: TextStyle(color: AppColors.Blue,fontFamily: 'Poppins'),)),
              Icon(Icons.arrow_forward_ios,color: AppColors.GreenA,),
            ],
          ),
        ),
      ),
    );
  }
}
