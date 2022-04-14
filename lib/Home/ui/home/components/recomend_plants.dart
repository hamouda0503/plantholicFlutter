import 'package:flutter/material.dart';
import 'package:plantholic/Model/SuperModel1.dart';
import 'package:plantholic/Model/plantModels.dart';
import '../../../../NetworkHandler.dart';
import '../../../../app_colors.dart';
import '../details/details_screen.dart';

class RecomendPlantCard extends StatefulWidget {
  const RecomendPlantCard({
    Key key,
    this.image,
    this.title,
    this.des,
    this.press,
  }) : super(key: key);

  final String image, title, des;

  final Function press;

  @override
  State<RecomendPlantCard> createState() => _RecomendPlantCardState();
}

class _RecomendPlantCardState extends State<RecomendPlantCard> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.only(
        left: 20,
        top: 5,
        bottom: 5,

      ),
      width: size.width * 0.4,
      child: Column(
        children: <Widget>[
          Image.asset("assets/"+widget.image,height: 150,),
          GestureDetector(
            onTap: widget.press,
            child: Container(
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
              child: Row(
                children: <Widget>[
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                            text: "${widget.title}\n".toUpperCase(),
                            style: Theme.of(context).textTheme.button),
                        TextSpan(
                          text: "${widget.des}".toUpperCase(),
                          style: TextStyle(
                            color: AppColors.Green.withOpacity(0.5),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Spacer(),
                ],
              ),
            ),
          )
        ],
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

  Widget getTextWidgets() {
    List<Widget> list = List<Widget>();
    for (var i = 0; i < data.length; i++) {
      list.add(
        RecomendPlantCard(
          image: data[i].plantImageUrl,
          title: data[i].plantName,
          des: "plant",
          press: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DetailsScreen(product: data[i],),
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
