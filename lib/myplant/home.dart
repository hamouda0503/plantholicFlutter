import 'dart:math';

import 'package:flutter/material.dart';
import 'package:plantholic/Model/SuperModel.dart';
import 'package:plantholic/Model/SuperModel1.dart';
import 'package:plantholic/Model/plantModels.dart';
import 'package:plantholic/app_colors.dart';
import 'package:plantholic/myplant/detail.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:plantholic/myplant/plantCard.dart';

import '../NetworkHandler.dart';

class myplant extends StatefulWidget {
  @override
  _myplantState createState() => _myplantState();
}

class _myplantState extends State<myplant> {
  NetworkHandler networkHandler = NetworkHandler();
  SuperModel1 superModel1 = SuperModel1();
  PlantModel plantModel = PlantModel();
  List<PlantModel> data = [];
  List<PlantModel> data1 = [];
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchData();
  }

  void fetchData() async {
    var response = await networkHandler.get("/plant/plantsInfor");
    print(response);
    superModel1 = SuperModel1.fromJson(response);
    setState(() {
      data = superModel1.data;
    });
  }

  void fetchsearchplant(String search) async {
    if (search.isNotEmpty) {
      {
        var response1 = await networkHandler.get("/plant/getPlant/" + search);
        if (response1["data"] != null) {
          plantModel = PlantModel.fromJson(response1["data"]);
          print(plantModel);
          setState(() {
            data = [];
            data.add(plantModel);
          });
        } else {
          fetchData();
        }
      }
    } else {
      fetchData();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(top: 70, left: 14, right: 14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
              'My Plant',
              style: TextStyle(
                  fontSize: 45,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Butler',
                  color: AppColors.Green),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: Row(
                children: [_searchBox(), _sortButton()],
              ),
            ),
            SizedBox(
              height: 0,
            ),
            Expanded(
              child: StaggeredGridView.countBuilder(
                physics: BouncingScrollPhysics(),
                crossAxisCount: 4,
                itemCount: data.length,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => DetailPage(
                            product: data[index],
                          ),
                        ),
                      );
                    },
                    child: PlantCard(
                      networkHandler: networkHandler,
                      plantModel: data[index],
                      isfavorite: true,
                    ),
                  );
                },
                staggeredTileBuilder: (int index) => new StaggeredTile.fit(2),
                mainAxisSpacing: 24,
                crossAxisSpacing: 24,
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _searchBox() {
    return Expanded(
      child: TextFormField(
        controller: searchController,
        decoration: InputDecoration(
          hintText: 'Search',
          hintStyle: TextStyle(fontFamily: 'poppins'),
          prefixIcon: Icon(
            Icons.search,
            color: AppColors.GreenA,
            size: 30,
          ),
          suffixIcon: IconButton(
            icon: Icon(
              Icons.search,
              color: AppColors.GreenA,
              size: 30,
            ),
            onPressed: () {
              fetchsearchplant(searchController.text);
            },
          ),
          filled: true,
          fillColor: Colors.grey.shade200,
          contentPadding: EdgeInsets.symmetric(vertical: 15),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.shade200),
            borderRadius: BorderRadius.circular(15),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.shade200),
            borderRadius: BorderRadius.circular(15),
          ),
        ),
      ),
    );
  }

  Widget _sortButton() {
    return Container(
      margin: EdgeInsets.only(left: 10),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: AppColors.Green,
        borderRadius: BorderRadius.circular(15),
      ),
      child: RotatedBox(
        quarterTurns: 45,
        child: Icon(
          Icons.tune,
          color: AppColors.Grey,
          size: 30,
        ),
      ),
    );
  }

  Widget _productItem({String title, image, bool isFavorited}) {
    return Container(
      padding: EdgeInsets.all(14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.grey.shade200,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Stack(
                children: [
                  Positioned.fill(
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        height: 25,
                        width: 100,
                        decoration: new BoxDecoration(
                          color: Colors.grey.shade300,
                          borderRadius:
                              BorderRadius.all(Radius.elliptical(100, 25)),
                        ),
                      ),
                    ),
                  ),
                  Center(
                    child: Image.asset(
                      'assets/$image',
                      width: 200,
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              ),
              Align(
                alignment: Alignment.topRight,
                child: Container(
                  padding: EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: isFavorited
                        ? Colors.pink.shade100
                        : Colors.grey.shade400,
                  ),
                  child: Icon(Icons.favorite,
                      color: isFavorited ? Colors.pink : Colors.black),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 8,
          ),
          Text(
            '$title',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.all(4),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.grey.shade400,
                ),
                child: Icon(Icons.add, color: Colors.white),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
