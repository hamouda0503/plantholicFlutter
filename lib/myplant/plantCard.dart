import 'dart:io';

//import 'package:cached_network_image/cached_network_image.dart';
import 'package:plantholic/Model/addBlogModels.dart';
import 'package:plantholic/Model/plantModels.dart';
import 'package:plantholic/Model/plants.dart';
import 'package:plantholic/NetworkHandler.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:plantholic/myGarden/add_plant.dart';
import 'package:plantholic/myGarden/main_screen.dart';

import '../app_colors.dart';

class PlantCard extends StatelessWidget {
  const PlantCard({Key key, this.plantModel, this.networkHandler,this.isfavorite})
      : super(key: key);

  final Plant plantModel;
  final NetworkHandler networkHandler;
  final bool isfavorite ;

  @override
  Widget build(BuildContext context) {
    return Container(

      padding: EdgeInsets.all(14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 0.5,
            blurRadius: 6,
            offset: Offset(3, 5), // changes position of shadow
          ),
        ],
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Stack(
                children: [
                  // Positioned.fill(
                  //   child: Align(
                  //     alignment: Alignment.bottomCenter,
                  //     child: Container(
                  //       height: 25,
                  //       width: 100,
                  //       decoration: new BoxDecoration(
                  //         color: Colors.grey.shade300,
                  //         borderRadius:
                  //         BorderRadius.all(Radius.elliptical(100, 25)),
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  Center(
                    child: Image.network(
                      plantModel.image,
                      width: 200,
                      fit: BoxFit.cover,
                    ),
                  ),
                  // Center(
                  //   child: CachedNetworkImage(
                  //     placeholder: (context, url) =>
                  //         CircularProgressIndicator(color: AppColors.Green,),
                  //     imageUrl: plantModel.image,
                  //     errorWidget: (context, url, error) =>
                  //         Icon(Icons.error),
                  //     height: 100,
                  //     width: 90,
                  //     fit: BoxFit.fill,
                  //   ),
                  // ),
                ],
              ),
              Align(
                alignment: Alignment.topRight,
                child: Container(
                  padding: EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: isfavorite
                        ? Colors.pink.shade100
                        : Colors.grey.shade400,
                  ),
                  child: Icon(Icons.favorite,
                      color: isfavorite ? Colors.pink : Colors.black),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 8,
          ),
          Text(
            plantModel.name,
            style: TextStyle(fontWeight: FontWeight.bold,fontFamily: 'poppins'),
          ),
          SizedBox(
            height: 6,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                plantModel.category,
                style: TextStyle(fontWeight: FontWeight.bold,fontFamily: 'poppins',color: AppColors.Green, fontSize: 10),
              ),
              SizedBox(width: 30,),
              Container(
                padding: EdgeInsets.all(4),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color:AppColors.Green,
                ),
                child: InkWell(onTap:(){
                  Navigator.of(context).push(
                    MaterialPageRoute(
                       builder: (context) => AddInfoPlant(spieces: plantModel.category,name: plantModel.name)
                      // builder: (context) => MainScreen()
                      ),
                  );
                },child: Icon(Icons.add, color: AppColors.Grey,)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
