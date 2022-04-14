import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:plantholic/app_colors.dart';
import './constants.dart';

class CategoryCard extends StatelessWidget {
  final String svgSrc;
  final String title;
  final Function press;
  const CategoryCard({
    Key key,
    this.svgSrc,
    this.title,
    this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(13),
      child: Container(
        // padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(13),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 0.5,
              blurRadius: 6,
              offset: Offset(3, 5), // changes position of shadow
            ),
          ],
        ),
        child: Material(
          color: Colors.white,
          child: InkWell(
            onTap: press,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: <Widget>[
                  Spacer(),
                  Image.asset(svgSrc),
                  Spacer(),
                  Text(
                    title,
                    style: TextStyle(fontSize:16,fontFamily: 'Poppins',color: AppColors.Blue),
                    textAlign: TextAlign.center,

                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
