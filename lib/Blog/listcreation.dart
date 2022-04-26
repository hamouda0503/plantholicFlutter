import 'dart:async';
import 'dart:convert';
import 'package:plantholic/Blog/Details.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../app_colors.dart';

class Listc extends StatefulWidget {
  final String nam;

  @override
  Listc({Key key, @required this.nam}) : super(key: key);

  _MyHomePageState createState() => new _MyHomePageState(name: this.nam);
}

class _MyHomePageState extends State<Listc> {
  String name, nam = "";

  _MyHomePageState({this.name});

  String url = 'https://nagulan23.github.io/plant-database/db.json';
  List data;

  Future<String> makeRequest() async {
    var response = await http.get(url);
    if (response.statusCode == 200) {
      print('ok');
      setState(() {
        var extractdata = json.decode(response.body);
        print(extractdata);
        data = extractdata[name]["det"];
        nam = extractdata[name]["name"];
      });
    } else {
      throw Exception('Failed to load post');
    }
  }

  @override
  void initState() {
    // getData();
    makeRequest();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: AppColors.Grey,
      appBar: new AppBar(
        title: (nam == "")
            ? CircularProgressIndicator(
                backgroundColor: AppColors.Green,
              )
            : Text(nam,style: TextStyle(fontFamily: "Poppins",color: AppColors.Blue,fontWeight: FontWeight.w600),),
        backgroundColor: AppColors.Grey,
        elevation: 0,
      ),
      body: new ListView.separated(
        itemCount: data == null ? 0 : data.length,
        itemBuilder: (BuildContext context, i) {
          return new ListTile(
              leading: new CircleAvatar(
                backgroundImage: NetworkImage(data[i]["img1"]),
              ),
              title: new Text(data[i]["name"],style: TextStyle(fontFamily: "Poppins",color: AppColors.Blue),),
              trailing: Icon(
                Icons.arrow_forward_ios,
              ),
              onTap: () {
                Navigator.push(
                  context,
                  new MaterialPageRoute(
                      builder: (ctxt) => new Details(
                          img: data[i]["img1"],
                          seed: data[i]["seed"],
                          seedl: data[i]["seedlings"],
                          cut: data[i]["cuttings"],
                          bulb: data[i]["bulb"],
                          inw: data[i]["inwater"],
                          crom: data[i]["crom"],
                          crown: data[i]["crown"],
                          soil: data[i]["soil"],
                          water: data[i]["water"],
                          sun: data[i]["sunlight"],
                          sunl: data[i]["sunlink"],
                          care: data[i]["caring"],
                          name: data[i]["name"])),
                );
              });
        },
        separatorBuilder: (context, index) {
          return Divider();
        },
      ),
    );
  }
}
