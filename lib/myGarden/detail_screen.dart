import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DetailScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[

              //CONTAINER DETAIL+CLOSE
              Container(
                padding: EdgeInsets.only(top: 37.0, left: 21.0, right: 7.0),
                color: Colors.lightGreen.shade100,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'Detail',
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black54),
                    ),
                    Container(
                      margin: EdgeInsets.only(right: 15.0),
                      height: 40,
                      decoration: ShapeDecoration(
                          color: Colors.lightGreen.shade200,
                          shape: CircleBorder()
                      ),
                      child: IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: new Icon(Icons.clear_rounded, color: Colors.black38),
                      ),
                    ),
                  ],
                ),
              ),

              //CONTAINER FOTO
              Container(
                padding: EdgeInsets.only(top: 30, right: 30, bottom: 10, left: 30),
                height: 250,
                width: MediaQuery.of(context).size.width,
                color: Colors.lightGreen.shade100,
                child: Image.asset(
                    'images/Filodendro-Atom.png'
                ),
              ),

              //CONTAINER CARD PLANT INFORMATION
              Container(
                width: MediaQuery.of(context).size.width,
                color: Colors.lightGreen.shade100,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: Card(
                    child: Column(
                      children: <Widget>[

                        //CONTAINER NAMA TUMBUHAN
                        Container(
                          padding: EdgeInsets.only(top: 30.0, bottom: 15.0, right: 21.0, left: 21.0),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Filodendro Atom',
                              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),

                        //CONTAINER STATUS TUMBUHAN
                        Container(
                          height: 75,
                          margin: EdgeInsets.only(top: 5.0, bottom: 5.0, left: 16.0, right: 16.0),
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            children: <Widget>[

                              //CLIPRRECT FREQUENCY - STATUS
                              ClipRRect(
                                borderRadius: BorderRadius.circular(28),
                                child: Container(
                                  margin: EdgeInsets.only(top: 3.0, bottom: 3.0, left: 7.0, right: 7.0),
                                  width: 165,
                                  color: Colors.grey.shade200,
                                  child: Padding(
                                    padding: EdgeInsets.only(top: 5.0, right: 2.0, bottom: 5.0, left: 13.0),
                                    child: Row(
                                      children: <Widget>[
                                        Container(
                                          padding: EdgeInsets.only(right: 5.0),
                                          child: IconButton(
                                            onPressed: () {},
                                            icon: new Icon(Icons.calendar_today_outlined, color: Colors.black45),
                                          ),
                                        ),
                                        Column(
                                          children: <Widget>[
                                            Expanded(
                                              flex: 1,
                                              child: Align(
                                                alignment: Alignment.bottomLeft,
                                                child: Text(
                                                  'FREQUENCY',
                                                  style: TextStyle(fontSize: 12, color: Colors.black45),
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 1,
                                              child: Align(
                                                alignment: Alignment.topLeft,
                                                child: Text(
                                                  '1 / week',
                                                  style: TextStyle(fontSize: 14, color: Colors.black45),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),

                              //CLIPRRECT WATER - STATUS
                              ClipRRect(
                                borderRadius: BorderRadius.circular(28),
                                child: Container(
                                  margin: EdgeInsets.only(top: 3.0, bottom: 3.0, left: 7.0, right: 7.0),
                                  width: 165,
                                  color: Colors.grey.shade200,
                                  child: Padding(
                                    padding: EdgeInsets.only(top: 5.0, right: 2.0, bottom: 5.0, left: 13.0),
                                    child: Row(
                                      children: <Widget>[
                                        Container(
                                          padding: EdgeInsets.only(right: 5.0),
                                          child: IconButton(
                                            onPressed: () {},
                                            icon: new Icon(Icons.water_rounded, color: Colors.black45),
                                          ),
                                        ),
                                        Column(
                                          children: <Widget>[
                                            Expanded(
                                              flex: 1,
                                              child: Align(
                                                alignment: Alignment.bottomLeft,
                                                child: Text(
                                                  'WATER',
                                                  style: TextStyle(fontSize: 12, color: Colors.black45),
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 1,
                                              child: Align(
                                                alignment: Alignment.topLeft,
                                                child: Text(
                                                  '250 ml',
                                                  style: TextStyle(fontSize: 14, color: Colors.black45),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),

                              //CLIPRRECT TEMP - STATUS
                              ClipRRect(
                                borderRadius: BorderRadius.circular(28),
                                child: Container(
                                  margin: EdgeInsets.only(top: 3.0, bottom: 3.0, left: 7.0, right: 7.0),
                                  width: 165,
                                  color: Colors.grey.shade200,
                                  child: Padding(
                                    padding: EdgeInsets.only(top: 5.0, right: 2.0, bottom: 5.0, left: 13.0),
                                    child: Row(
                                      children: <Widget>[
                                        Container(
                                          padding: EdgeInsets.only(right: 5.0),
                                          child: IconButton(
                                            onPressed: () {},
                                            icon: new Icon(Icons.thermostat_rounded, color: Colors.black45),
                                          ),
                                        ),
                                        Column(
                                          children: <Widget>[
                                            Expanded(
                                              flex: 1,
                                              child: Align(
                                                alignment: Alignment.bottomLeft,
                                                child: Text(
                                                  'TEMP',
                                                  style: TextStyle(fontSize: 12, color: Colors.black45),
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 1,
                                              child: Align(
                                                alignment: Alignment.topLeft,
                                                child: Text(
                                                  '15-24 C',
                                                  style: TextStyle(fontSize: 14, color: Colors.black45),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),

                              //CLIPRRECT LIGHT - STATUS
                              ClipRRect(
                                borderRadius: BorderRadius.circular(28),
                                child: Container(
                                  margin: EdgeInsets.only(top: 3.0, bottom: 3.0, left: 7.0, right: 7.0),
                                  width: 165,
                                  color: Colors.grey.shade200,
                                  child: Padding(
                                    padding: EdgeInsets.only(top: 5.0, right: 2.0, bottom: 5.0, left: 13.0),
                                    child: Row(
                                      children: <Widget>[
                                        Container(
                                          padding: EdgeInsets.only(right: 5.0),
                                          child: IconButton(
                                            onPressed: () {},
                                            icon: new Icon(Icons.wb_sunny_outlined, color: Colors.black45),
                                          ),
                                        ),
                                        Column(
                                          children: <Widget>[
                                            Expanded(
                                              flex: 1,
                                              child: Align(
                                                alignment: Alignment.bottomCenter,
                                                child: Text(
                                                  'LIGHT',
                                                  style: TextStyle(fontSize: 12, color: Colors.black45),
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 1,
                                              child: Align(
                                                alignment: Alignment.topCenter,
                                                child: Text(
                                                  'Low',
                                                  style: TextStyle(fontSize: 14, color: Colors.black45),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        //CONTAINER DESKRIPSI TUMBUHAN
                        //buat bisa scroll ke bawah | read more batal
                        Container(
                          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 21.0),
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              'Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. ',
                              style: TextStyle(fontSize: 14, color: Colors.black45),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}