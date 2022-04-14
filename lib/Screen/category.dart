import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:plantholic/Blog/ShowData.dart';
import 'package:plantholic/Blog/soil.dart';
import 'package:plantholic/Blog/tips.dart';
import 'package:plantholic/Explore/category_card.dart';
import 'package:plantholic/Explore/search_bar.dart';
import 'package:plantholic/app_colors.dart';
import 'package:plantholic/reference/pages/home.dart';

import 'TutoScreen.dart';

class ExploreMenu extends StatefulWidget {
  const ExploreMenu({Key key}) : super(key: key);

  @override
  _ExploreMenuState createState() => _ExploreMenuState();
}

class _ExploreMenuState extends State<ExploreMenu> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: AppColors.Grey,
      body: Stack(
        children: <Widget>[
          Container(
            // Here the height of the container is 45% of our total height
            height: 300,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(13),
              color: AppColors.GreenA,

            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Welcome to',
                        style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Butler',
                            color: AppColors.Blue),
                      ),
                    ],
                  ),
                  Text(
                    'Explore',
                    style: TextStyle(
                        fontSize: 45,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Butler',
                        color: AppColors.Grey),
                  ),
                  SearchBar(),
                  Expanded(
                    child: GridView.count(
                      crossAxisCount: 2,
                      childAspectRatio: .85,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 20,
                      children: <Widget>[
                        CategoryCard(
                          title: "Tutos",
                          svgSrc: "assets/cours.jpg",
                          press: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => TutoScreen(url: "/blogpost/getOtherBlog",)));
                          },
                        ),
                        CategoryCard(
                          title: "Tips",
                          svgSrc: "assets/tips.jpg",
                          press: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => ShowData(page:0,)));
                          },
                        ),
                        CategoryCard(
                          title: "Plantopedia",
                          svgSrc: "assets/plantopidia.jpg",
                          press: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => ShowData(page:2,)));
                          },
                        ),
                        CategoryCard(
                          title: "Inspiration",
                          svgSrc: "assets/inspiration.jpg",
                          press: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => HomePhoto()));
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
