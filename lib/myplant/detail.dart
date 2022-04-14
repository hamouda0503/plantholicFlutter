import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:plantholic/Model/SuperModel1.dart';
import 'package:plantholic/Model/plantModels.dart';
import 'package:plantholic/Profile/components/profile_menu.dart';
import 'package:plantholic/app_colors.dart';
import 'package:plantholic/myplant/arViewScreen.dart';
import 'package:plantholic/myplant/arplant.dart';

import 'home.dart';

class DetailPage extends StatefulWidget {
  final PlantModel product;
  DetailPage({@required this.product});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.Grey,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 14),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Icon(
                      Icons.arrow_back,
                      size: 30,
                      color: AppColors.Blue,
                    ),
                  ),
                ],
              ),
            ),
            _productImage(),
            SizedBox(
              height: 10,
            ),
            Expanded(
              child: Container(
                  padding: EdgeInsets.only(left: 18, top: 15),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                    color: Colors.grey.shade200,
                  ),
                  child: _productDescription()),
            ),
          ],
        ),
      ),
    );
  }

  Widget _productImage() {
    return Stack(
      children: [
        Positioned.fill(
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 50,
              width: 300,
              decoration: new BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.all(Radius.elliptical(300, 50)),
              ),
            ),
          ),
        ),
        Center(
          child: Image.asset(
            'assets/${widget.product.plantImageUrl}',
            height: 350,
            fit: BoxFit.cover,
          ),
        ),
      ],
    );
  }

  Widget _productDescription() {
    return ListView(
      physics: BouncingScrollPhysics(),
      children: [
        Row(
          children: [
            SizedBox(
              width: 48,
              child: Divider(
                thickness: 5,
                color: AppColors.Blue,
              ),
            ),
            SizedBox(
              width: 8,
            ),
            Text('Best choice',
                style: TextStyle(
                    fontWeight: FontWeight.bold, color: AppColors.Blue)),
            SizedBox(
              width: 130,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => RemoteObject(
                              pic: '${widget.product.plantImageUrl}',
                            )));
              },
              child: Icon(MdiIcons.cubeScan,
                size: 30,
                color: AppColors.Green,
              ),
              style: ElevatedButton.styleFrom(
                  shape: CircleBorder(),
                  padding: EdgeInsets.all(18),
                  primary: AppColors.GreenA),
            ),
          ],
        ),
        SizedBox(height: 24),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '${widget.product.plantName}',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                  color: AppColors.Green),
            ),
          ],
        ),
        SizedBox(
          height: 32,
        ),
        Text(
          'About',
          style: TextStyle(
              color: AppColors.Green,
              fontWeight: FontWeight.bold,
              fontSize: 24),
        ),
        SizedBox(
          height: 14,
        ),
        Padding(
          padding: const EdgeInsets.only(right: 14),
          child: Text(
            '${widget.product.plantDescription}',
            style: TextStyle(fontFamily: 'Poppins', color: AppColors.Blue),
          ),
        ),
        SizedBox(
          height: 14,
        ),
        SizedBox(
          height: 48,
        ),
      ],
    );
  }
}
