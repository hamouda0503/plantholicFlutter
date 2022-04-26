import 'package:flutter/material.dart';

import 'package:plantholic/app_colors.dart';



class TipComponent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.GreenA.withOpacity(0.7),
          borderRadius: BorderRadius.circular(30)
        ),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16,16,80,16),
              child: Row(
                children: [
                  Icon(Icons.wb_sunny,color: Colors.white,size: 40,),
                  SizedBox(width: 8,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Tips & Plant Care", style: TextStyle(color: Colors.white,fontWeight: FontWeight.w600), overflow: TextOverflow.ellipsis, maxLines: 1),
                      Text("Find Tips For Keeping Your Plants Alive", style: TextStyle(color: Colors.white,fontWeight: FontWeight.w200,fontSize: 11), overflow: TextOverflow.ellipsis, maxLines: 2),
                    ],
                  )
                ],
              ),
            ),
            Positioned(
              right: 0,
              top: 0,
              bottom: -10,
              child: Image.asset("assets/plant2.png", height: 180, width: 90),
            )
          ],
        ),
      ),
    );
  }
}
