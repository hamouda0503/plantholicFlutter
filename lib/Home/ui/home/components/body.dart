import 'package:flutter/material.dart';


import 'TipComponent.dart';
import 'featurred_plants.dart';
import 'header_with_seachbox.dart';
import 'recomend_plants.dart';
import 'title_with_more_bbtn.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          HeaderWithSearchBox(size: size),
          TipComponent(),
          TitleWithMoreBtn(title: "Recomended Plants", press: () {}),
          RecomendsPlants(),
          TitleWithMoreBtn(title: "Featured Tutos", press: () {}),
          // FeaturedPlants(),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}
