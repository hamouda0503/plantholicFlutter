import 'package:flutter/material.dart';

import '../../../../../app_colors.dart';


class TitleAndPrice extends StatelessWidget {
  const TitleAndPrice({
    Key key,
    this.title,

    this.price,
  }) : super(key: key);

  final String title;
  final int price;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: <Widget>[
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: "$title\n",
                  style: Theme.of(context)
                      .textTheme
                      .headline4
                      .copyWith(color: AppColors.Green, fontWeight: FontWeight.bold),
                ),
                // TextSpan(
                //   text: country,
                //   style: TextStyle(
                //     fontSize: 20,
                //     color: AppColors.Green,
                //     fontWeight: FontWeight.w300,
                //   ),
                // ),
              ],
            ),
          ),
          Spacer(),
          // Text(
          //   "\$$price",
          //   style: Theme.of(context)
          //       .textTheme
          //       .headline5
          //       .copyWith(color: AppColors.Green),
          // )
        ],
      ),
    );
  }
}
