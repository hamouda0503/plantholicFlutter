//import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:plantholic/Model/SuperModel1.dart';
import 'package:plantholic/Model/plantModels.dart';
import 'package:plantholic/Model/plants.dart';
import 'package:plantholic/myplant/detail.dart';
import '../../../../NetworkHandler.dart';
import '../../../../app_colors.dart';
import '../details/details_screen.dart';

class RecomendPlantCard extends StatefulWidget {
  const RecomendPlantCard({
    Key key,
    this.image,
    this.title,
    this.category,
    this.press,
  }) : super(key: key);

  final String image, title, category;

  final Function press;

  @override
  State<RecomendPlantCard> createState() => _RecomendPlantCardState();
}

class _RecomendPlantCardState extends State<RecomendPlantCard> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return   GestureDetector(
      onTap: widget.press,
      child: Container(
        margin: EdgeInsets.only(
          left: 20,
          top: 5,
          bottom: 5,
        ),
        color: Colors.white,
        width: size.width * 0.4,
        child: Column(
          children: <Widget>[
            Center(
              // child: CachedNetworkImage(
              //   placeholder: (context, url) =>
              //       CircularProgressIndicator(color: AppColors.Green,),
              //   imageUrl: widget.image,
              //   errorWidget: (context, url, error) =>
              //       Icon(Icons.error),
              //   height: 100,
              //   width: 90,
              //   fit: BoxFit.fill,
              // ),
              child: Image.network(
                widget.image,
                width: 90,
                height: 100,
              ),
            ),
            Container(
              padding: EdgeInsets.all(20 / 2),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
                boxShadow: [
                  BoxShadow(
                    offset: Offset(0, 10),
                    blurRadius: 10,
                    color: AppColors.Green.withOpacity(0.1),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: <Widget>[
                    // RichText(
                    //   overflow: TextOverflow.ellipsis,
                    //   text: TextSpan(
                    //     children: [
                    //       TextSpan(
                    //           text: "${widget.title}\n".toUpperCase(),
                    //           style: Theme.of(context).textTheme.button),
                    //       TextSpan(
                    //         text: "${widget.category}".toUpperCase(),
                    //         style: TextStyle(
                    //           color: AppColors.Green.withOpacity(0.5),
                    //         ),
                    //       ),
                    //     ],
                    //   ),
                    // ),
                    Expanded(
                      child: Container(
                          child: Column(
                              // mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                            Text(
                              widget.title.toUpperCase(),
                              overflow: TextOverflow.ellipsis,

                            ),
                            Text(
                              widget.category.toUpperCase(),
                              style: TextStyle(
                                  color: AppColors.Green.withOpacity(0.5),
                                  overflow: TextOverflow.ellipsis),
                            ),
                          ])),
                    ),
                    Spacer(),
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

class RecomendsPlants extends StatefulWidget {
  const RecomendsPlants({
    Key key,
  }) : super(key: key);

  @override
  State<RecomendsPlants> createState() => _RecomendsPlantsState();
}

class _RecomendsPlantsState extends State<RecomendsPlants> {
  NetworkHandler networkHandler = NetworkHandler();
  SuperModel1 superModel1 = SuperModel1();
  Plant plant = Plant();

  // List<PlantModel> data = [];
  // List<PlantModel> data1 = [];
  List<dynamic> data = [];
  List<dynamic> data1 = [];
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchData();
  }

  void fetchData() async {
    var response = await networkHandler.get("/plant/plantrecom");
    //print(response);
    List<dynamic> plantsMapped =
        response["data"].map((a) => Plant.fromJson(a)).toList();
    setState(() {
      data = plantsMapped;
      print(data.length);
    });
  }

  void fetchsearchplant(String search) async {
    if (search.isNotEmpty) {
      {
        var response1 = await networkHandler.get("/plant/getPlantl/" + search);
        if (response1["data"] != null) {
          List<dynamic> plantsMapped =
              response1["data"].map((a) => Plant.fromJson(a)).toList();
          setState(() {
            data = [];
            data = plantsMapped;
            print(data.length);
          });
        } else {
          fetchData();
        }
      }
    } else {
      fetchData();
    }
  }

  Widget getTextWidgets() {
    List<Widget> list = List<Widget>();
    for (var i = 0; i < data.length; i++) {
      list.add(
        RecomendPlantCard(
          image: data[i].image,
          title: data[i].name,
          category: data[i].category,
          press: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PlantDetails(
                  plant: data[i],
                ),
              ),
            );
          },
        ),
      );
    }
    return Row(children: list);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: getTextWidgets(),
      // child: Row(
      //   children: [
      //     for(int i = 0; i < data.length; i++)
      //       RecomendPlantCard(
      //         image: data[i].plantImageUrl,
      //         title: data[i].plantName,
      //         des: "plant",
      //         press: () {
      //           Navigator.push(
      //             context,
      //             MaterialPageRoute(
      //               builder: (context) => DetailsScreen(),
      //             ),
      //           );
      //         },
      //       ),
      //   ],
      // ),
    );
  }
}
