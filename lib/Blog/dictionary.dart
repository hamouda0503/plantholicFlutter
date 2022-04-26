import 'package:plantholic/Blog/listcreation.dart';
import 'package:plantholic/app_colors.dart';
import 'package:plantholic/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'dart:async';

class Dictionary extends StatelessWidget {
  //.................................Dictionary

  @override
  Widget build(BuildContext context) {
    debugShowCheckedModeBanner: false;
    // const green = const Color(0xff00cf00);
    return Scaffold(
        backgroundColor: AppColors.Grey,
        appBar: AppBar(
          title: Text('Plantopedia',style: TextStyle(fontFamily: "Butler",color: AppColors.Blue,fontWeight: FontWeight.bold),),
          backgroundColor: AppColors.Grey,
          elevation: 0,
        ),
        body: Card(
            elevation: 0,
            color: AppColors.Grey ,
            child: ListView(
              scrollDirection: Axis.vertical,
              children: <Widget>[
                Container(
                  color: AppColors.Grey,
                  padding: EdgeInsets.all(20),
                  child: new SizedBox(
                    height: 100,
                    child: RaisedButton(
                      elevation: 0,
                      color: Colors.white,
                      child: Row(
                        children: <Widget>[
                          Image.asset(
                            'assets/medicinal.jpg',
                            height: 50,
                            fit: BoxFit.contain,
                          ),
                          Text("  Medicinal Plants",
                              style: TextStyle(fontSize: 20)),
                          Icon(Icons.arrow_right, size: 30, )
                        ],
                      ),
                      highlightColor: AppColors.Grey,
                      onPressed: () {
                        Navigator.push(
                            context,
                            new MaterialPageRoute(
                                builder: (ctxt) => new Listc(nam:"medicinal_Plants")),
                          );
                      },
                    ),
                  ),
                ),
                Container(
                  color: AppColors.Grey,
                  padding: EdgeInsets.all(20),
                  child: new SizedBox(
                    height: 100,
                    child: RaisedButton(
                      color: Colors.white,
                      elevation: 0,
                      child: Row(
                        children: <Widget>[
                          Image.asset(
                            'assets/flower.jpg',
                            height: 50,
                            fit: BoxFit.fitHeight,
                          ),
                          Text("  Flowering Plants",
                              style: TextStyle(fontSize: 20)),
                          Icon(Icons.arrow_right, size: 30)
                        ],
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            new MaterialPageRoute(
                                builder: (ctxt) => new Listc(nam:"flowering_Plants")),
                          );
                      },
                    ),
                  ),
                ),
                Container(
                  color: AppColors.Grey,
                  padding: EdgeInsets.all(20),
                  child: new SizedBox(
                    height: 100,
                    child: RaisedButton(
                      elevation: 0,
                      color: Colors.white,
                      child: Row(
                        children: <Widget>[
                          Image.asset(
                            'assets/aromatic.jpg',
                            height: 50,
                            fit: BoxFit.contain,
                          ),
                          Text("  Aromatic Plants",
                              style: TextStyle(fontSize: 20)),
                          Icon(Icons.arrow_right, size: 30)
                        ],
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            new MaterialPageRoute(
                                builder: (ctxt) => new Listc(nam:"aromatic")),
                          );
                      },
                    ),
                  ),
                ),
                Container(

                  color: AppColors.Grey,
                  padding: EdgeInsets.all(20),
                  child: new SizedBox(
                    height: 100,
                    child: RaisedButton(
                      color: Colors.white,
                      elevation: 0,
                      child: Row(
                        children: <Widget>[
                          Image.asset(
                            'assets/fruits.jpg',
                            height: 50,
                            fit: BoxFit.contain,
                          ),
                          Text("  Fruit crops        ",
                              style: TextStyle(fontSize: 20)),
                          Icon(Icons.arrow_right, size: 30,)
                        ],
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            new MaterialPageRoute(
                                builder: (ctxt) => new Listc(nam:"fruits")),
                          );
                      },
                    ),
                  ),
                ),
                Container(
                  color: AppColors.Grey,
                  padding: EdgeInsets.all(20),
                  child: new SizedBox(
                    height: 100,
                    child: RaisedButton(
                      elevation: 0,
                      color: Colors.white,
                      child: Row(
                        children: <Widget>[
                          Image.asset(
                            'assets/vegetables.jpg',
                            height: 50,
                            fit: BoxFit.contain,
                          ),
                          Text("  Vegetable crops",
                              style: TextStyle(fontSize: 20)),
                          Icon(Icons.arrow_right, size: 30)
                        ],
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            new MaterialPageRoute(
                                builder: (ctxt) => new Listc(nam:"vegetables")),
                          );
                      },
                    ),
                  ),
                ),
              ],
            )));
  }
}
