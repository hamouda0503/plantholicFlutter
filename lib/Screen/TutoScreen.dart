import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:plantholic/Blog/Blogs.dart';
import 'package:plantholic/Blog/ShowData.dart';
import 'package:plantholic/Blog/addBlog.dart';
import 'package:plantholic/Pages/main.dart';
import 'package:plantholic/Pages/old/WelcomePage.dart';
import 'package:plantholic/app_colors.dart';
import 'package:unicons/unicons.dart';

import '../NetworkHandler.dart';

class TutoScreen extends StatefulWidget {
  const TutoScreen({Key key,this.url}) : super(key: key);
  final String url ;
  @override
  _TutoScreenState createState() => _TutoScreenState();
}

class _TutoScreenState extends State<TutoScreen> {
  final storage = FlutterSecureStorage();

  Widget profilePhoto = Container(
    height: 100,
    width: 100,
    child: CircleAvatar(
      radius: 50,
      backgroundImage: NetworkHandler().getImage("ahmed"),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // drawer: Drawer(
      //   backgroundColor: AppColors.Grey,
      //   child: ListView(
      //     children: <Widget>[
      //       DrawerHeader(
      //         child: Column(
      //           children: <Widget>[
      //             profilePhoto,
      //             SizedBox(
      //               height: 10,
      //             ),
      //             Text("Ahmed"),
      //           ],
      //         ),
      //       ),
      //       ListTile(
      //         title: Text("All Tips"),
      //         trailing: Icon(Icons.launch),
      //         onTap: () {
      //           Navigator.of(context).push(MaterialPageRoute(
      //               builder: (context) => ShowData(
      //                     page: 0,
      //                   )));
      //         },
      //       ),
      //       ListTile(
      //         title: Text("Soilpedia"),
      //         trailing: Icon(Icons.place_rounded),
      //         onTap: () {
      //           Navigator.of(context).push(MaterialPageRoute(
      //               builder: (context) => ShowData(
      //                     page: 1,
      //                   )));
      //         },
      //       ),
      //       ListTile(
      //         title: Text("plantopedia"),
      //         trailing: Icon(Icons.cloud),
      //         onTap: () {
      //           Navigator.of(context).push(MaterialPageRoute(
      //               builder: (context) => ShowData(
      //                     page: 2,
      //                   )));
      //         },
      //       ),
      //       ListTile(
      //         title: Text("Feedback"),
      //         trailing: Icon(Icons.feedback),
      //         onTap: () {
      //           Navigator.of(context).push(MaterialPageRoute(
      //               builder: (context) => ShowData(
      //                 page: 3,
      //               )));
      //         },
      //       ),
      //       ListTile(
      //         title: Text("Logout"),
      //         trailing: Icon(Icons.power_settings_new),
      //         onTap: logout,
      //       ),
      //     ],
      //   ),
      // ),
      appBar: AppBar(
        backgroundColor: AppColors.Grey,
        title: Text(
          "Community",
          style: TextStyle(fontFamily: "Poppins", color: AppColors.Blue),
        ),

        centerTitle: true,
        // actions: <Widget>[
        //   IconButton(onPressed: () {}, icon: Icon(Icons.notifications)),
        // ],
        actions: [
          IconButton(
              onPressed: () =>
                  showModalBottomSheet(
                    context: context,
                    builder: ((builder) => AddBlog()),
                  ),
              icon: Icon(
                UniconsLine.plus_circle,
                color: AppColors.Blue,
                size: 30,
              ))
        ],
        leading: InkWell(
          onTap: () async {
            Navigator.pop(context);
          },
          child: Icon(
            MdiIcons.arrowLeft,
            color: AppColors.Blue,
          ),
        ),
        elevation: 0,
      ),
      backgroundColor: AppColors.Grey,
      body: SingleChildScrollView(
        child: Blogs(
          url: widget.url,
        ),
      ),
    );
  }

  void logout() async {
    await storage.delete(key: "token");
    Navigator.pushAndRemoveUntil(context,
        MaterialPageRoute(builder: (context) => HomePage()), (route) => false);
  }
}
