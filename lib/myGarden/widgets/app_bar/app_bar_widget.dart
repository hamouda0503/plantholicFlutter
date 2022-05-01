import 'package:flutter/material.dart';

import 'package:plantholic/myGarden/core/core.dart';


class AppBarWidget extends PreferredSize {
  AppBarWidget({Key key})
      : super(
          key: key,
          preferredSize: Size.fromHeight(300.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(
                  left: 32.0,
                  right: 32.0,
                  bottom: 24.0,
                ),
                child: Text.rich(
                  TextSpan(
                    text: 'Em qual ambiente\n',
                    style: AppTextStyles.bodyDark,
                    children: [
                      TextSpan(
                        text: 'você quer colocar sua planta?',
                        style: AppTextStyles.bodyDark,
                      )
                    ],
                  ),
                ),
              ),

            ],
          ),
        );
}
