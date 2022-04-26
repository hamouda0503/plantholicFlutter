// import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
// import 'package:plantholic/Model/SuperModel1.dart';
// import 'package:plantholic/Model/plantModels.dart';
// import 'package:plantholic/Profile/components/profile_menu.dart';
// import 'package:plantholic/app_colors.dart';
// import 'package:plantholic/myplant/arViewScreen.dart';
// import 'package:plantholic/myplant/arplant.dart';
//
// import 'home.dart';
//
// class DetailPage extends StatefulWidget {
//   final PlantModel product;
//   DetailPage({@required this.product});
//
//   @override
//   State<DetailPage> createState() => _DetailPageState();
// }
//
// class _DetailPageState extends State<DetailPage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.Grey,
//       body: SafeArea(
//         child: Column(
//           children: [
//             Padding(
//               padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 14),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   GestureDetector(
//                     onTap: () => Navigator.pop(context),
//                     child: Icon(
//                       Icons.arrow_back,
//                       size: 30,
//                       color: AppColors.Blue,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             _productImage(),
//             SizedBox(
//               height: 10,
//             ),
//             Expanded(
//               child: Container(
//                   padding: EdgeInsets.only(left: 18, top: 15),
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.only(
//                       topLeft: Radius.circular(30),
//                       topRight: Radius.circular(30),
//                     ),
//                     color: Colors.grey.shade200,
//                   ),
//                   child: _productDescription()),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _productImage() {
//     return Stack(
//       children: [
//         Positioned.fill(
//           child: Align(
//             alignment: Alignment.bottomCenter,
//             child: Container(
//               height: 50,
//               width: 300,
//               decoration: new BoxDecoration(
//                 color: Colors.grey.shade200,
//                 borderRadius: BorderRadius.all(Radius.elliptical(300, 50)),
//               ),
//             ),
//           ),
//         ),
//         Center(
//           child: Image.asset(
//             'assets/${widget.product.plantImageUrl}',
//             height: 350,
//             fit: BoxFit.cover,
//           ),
//         ),
//       ],
//     );
//   }
//
//   Widget _productDescription() {
//     return ListView(
//       physics: BouncingScrollPhysics(),
//       children: [
//         Row(
//           children: [
//             SizedBox(
//               width: 48,
//               child: Divider(
//                 thickness: 5,
//                 color: AppColors.Blue,
//               ),
//             ),
//             SizedBox(
//               width: 8,
//             ),
//             Text('Best choice',
//                 style: TextStyle(
//                     fontWeight: FontWeight.bold, color: AppColors.Blue)),
//             SizedBox(
//               width: 130,
//             ),
//             ElevatedButton(
//               onPressed: () {
//                 Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                         builder: (context) => ARViewScreen(
//                               pic: 'assets/${widget.product.plantImageUrl}',
//                             )));
//               },
//               child: Icon(MdiIcons.cubeScan,
//                 size: 30,
//                 color: AppColors.Green,
//               ),
//               style: ElevatedButton.styleFrom(
//                   shape: CircleBorder(),
//                   padding: EdgeInsets.all(18),
//                   primary: AppColors.GreenA),
//             ),
//           ],
//         ),
//         SizedBox(height: 24),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Text(
//               '${widget.product.plantName}',
//               style: TextStyle(
//                   fontWeight: FontWeight.bold,
//                   fontSize: 30,
//                   color: AppColors.Green),
//             ),
//           ],
//         ),
//         SizedBox(
//           height: 32,
//         ),
//         Text(
//           'About',
//           style: TextStyle(
//               color: AppColors.Green,
//               fontWeight: FontWeight.bold,
//               fontSize: 24),
//         ),
//         SizedBox(
//           height: 14,
//         ),
//         Padding(
//           padding: const EdgeInsets.only(right: 14),
//           child: Text(
//             '${widget.product.plantDescription}',
//             style: TextStyle(fontFamily: 'Poppins', color: AppColors.Blue),
//           ),
//         ),
//         SizedBox(
//           height: 14,
//         ),
//         SizedBox(
//           height: 48,
//         ),
//       ],
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:plantholic/Model/plants.dart';
//import 'package:cached_network_image/cached_network_image.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:plantholic/app_colors.dart';
import 'package:url_launcher/url_launcher.dart';

class PlantDetails extends StatefulWidget {
  final Plant plant;

  PlantDetails({Key key, this.plant}) : super(key: key);

  @override
  State<PlantDetails> createState() => _PlantDetailsState();
}

class _PlantDetailsState extends State<PlantDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          // Box decoration takes a gradient
          gradient: LinearGradient(
            // Where the linear gradient begins and ends
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            // Add one stop for each color. Stops should increase from 0 to 1
            stops: [0.1, 0.9],
            colors: [
              // Colors are easy thanks to Flutter's Colors class.
              AppColors.GreenA,
              AppColors.Green,
            ],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            SafeArea(
                child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 10, 0, 10),
                    child: Text(
                      "Details: ",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 40,
                          fontWeight: FontWeight.w700),
                    ))),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10, 0, 0, 10),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              SizedBox(
                                width: 50,
                                child: Icon(
                                  FontAwesomeIcons.thermometerQuarter,
                                  color: Colors.white,
                                  size: 40,
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                widget.plant.temperature["min"].toString(),
                                style:
                                TextStyle(color: Colors.white, fontSize: 30),
                              ),
                              Text(
                                "°C",
                                style:
                                TextStyle(color: Colors.white, fontSize: 16),
                              ),
                              Text(
                                " | " + widget.plant.temperature["max"].toString(),
                                style:
                                TextStyle(color: Colors.white, fontSize: 30),
                              ),
                              Text(
                                "°C",
                                style:
                                TextStyle(color: Colors.white, fontSize: 16),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: <Widget>[
                              SizedBox(
                                width: 50,
                                child: Icon(
                                  FontAwesomeIcons.tint,
                                  color: Colors.white,
                                  size: 35,
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                widget.plant.airHumidity["min"].toString(),
                                style:
                                TextStyle(color: Colors.white, fontSize: 30),
                              ),
                              Text(
                                "%",
                                style:
                                TextStyle(color: Colors.white, fontSize: 16),
                              ),
                              Text(
                                " | " + widget.plant.airHumidity["max"].toString(),
                                style:
                                TextStyle(color: Colors.white, fontSize: 30),
                              ),
                              Text(
                                "%",
                                style:
                                TextStyle(color: Colors.white, fontSize: 16),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: <Widget>[
                              SizedBox(
                                width: 50,
                                child: Icon(
                                  Icons.wb_sunny,
                                  color: Colors.white,
                                  size: 35,
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                widget.plant.light["min"].toString(),
                                style:
                                TextStyle(color: Colors.white, fontSize: 30),
                              ),
                              Text(
                                "m",
                                style:
                                TextStyle(color: Colors.white, fontSize: 16),
                              ),
                              Text(
                                " | " + widget.plant.light["max"].toString(),
                                style:
                                TextStyle(color: Colors.white, fontSize: 30),
                              ),
                              Text(
                                "m",
                                style:
                                TextStyle(color: Colors.white, fontSize: 16),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: <Widget>[
                              SizedBox(
                                width: 50,
                                child: Icon(
                                  FontAwesomeIcons.stopwatch,
                                  color: Colors.white,
                                  size: 35,
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                widget.plant.watering.toString(),
                                style:
                                TextStyle(color: Colors.white, fontSize: 30),
                              ),
                              Text(
                                " hours",
                                style:
                                TextStyle(color: Colors.white, fontSize: 16),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: <Widget>[
                              SizedBox(
                                width: 50,
                                child: Icon(
                                  FontAwesomeIcons.leaf,
                                  color: Colors.white,
                                  size: 30,
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                widget.plant.lifespan.toString(),
                                style:
                                TextStyle(color: Colors.white, fontSize: 30),
                              ),
                              Text(
                                " years",
                                style:
                                TextStyle(color: Colors.white, fontSize: 16),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: <Widget>[
                              SizedBox(
                                width: 50,
                                child: Icon(
                                  FontAwesomeIcons.paw,
                                  color: Colors.white,
                                  size: 30,
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                (widget.plant.toxic ? "Non-p" : "P") + "et-friendly",
                                style:
                                TextStyle(color: Colors.white, fontSize: 26),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              SizedBox(
                                width: 50,
                                child: Icon(
                                  FontAwesomeIcons.arrowsAltV,
                                  color: Colors.white,
                                  size: 30,
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                widget.plant.maxGrowth["height"].toString(),
                                style:
                                TextStyle(color: Colors.white, fontSize: 30),
                              ),
                              Text(
                                " cm",
                                style:
                                TextStyle(color: Colors.white, fontSize: 16),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: <Widget>[
                              SizedBox(
                                width: 50,
                                child: Icon(
                                  FontAwesomeIcons.arrowsAltH,
                                  color: Colors.white,
                                  size: 30,
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                widget.plant.maxGrowth["diameter"].toString(),
                                style:
                                TextStyle(color: Colors.white, fontSize: 30),
                              ),
                              Text(
                                " cm",
                                style:
                                TextStyle(color: Colors.white, fontSize: 16),
                              ),
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    width: 50,
                    child: Icon(
                      Icons.texture,
                      color: Colors.white,
                      size: 35,
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    widget.plant.soil.toString(),
                    style: TextStyle(color: Colors.white, fontSize: 30),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              decoration: new BoxDecoration(
                  color: Colors.white,
                  borderRadius: new BorderRadius.only(
                      topLeft: const Radius.circular(40.0),
                      topRight: const Radius.circular(40.0))),
              height: 200,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10, 10, 0, 10),
                child: Row(
                  children: [
                    // CachedNetworkImage(
                    //   placeholder: (context, url) =>
                    //       CircularProgressIndicator(),
                    //   imageUrl: widget.plant.image,
                    //   errorWidget: (context, url, error) => Icon(Icons.error),
                    //   height: 150,
                    //   width: 150,
                    //   fit: BoxFit.fill,
                    // ),
                    Container(
                      child: Image.network(widget.plant.image,height: 150,
      width: 150,
      fit: BoxFit.fill,),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(widget.plant.name,
                              style:
                              TextStyle(fontSize: 24, color: Colors.black)),
                          Text(widget.plant.category,
                              style: TextStyle(
                                  fontSize: 16, color: Colors.black54))
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

