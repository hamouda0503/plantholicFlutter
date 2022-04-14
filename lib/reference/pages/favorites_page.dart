import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:plantholic/reference/models/photo_model.dart';
import 'package:plantholic/reference/pages/singleImage.dart';
import 'package:plantholic/reference/services/storage_service.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../app_colors.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({Key key}) : super(key: key);

  @override
  _FavoritesPageState createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.Grey,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: const Text('Favorites'),
        titleTextStyle: const TextStyle(color: Colors.black, fontSize: 24),
        backgroundColor: AppColors.Grey,
        leading: InkWell(
          onTap: () async {
            Navigator.pop(context);
          },
          child: Icon(MdiIcons.arrowLeft,color: AppColors.Blue,),
        ),
      ),
      body: ValueListenableBuilder(
        valueListenable: Favorites.getFavorites().listenable(),
        builder: (BuildContext context, Box<PhotoModel> value, Widget child) {
          final favorites = value.values.toList().cast<PhotoModel>();
          return SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 5, left: 5),
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height * 1,
                    child: GridView.count(
                      crossAxisCount: 2,
                      crossAxisSpacing: 5.0,
                      mainAxisSpacing: 5.0,
                      childAspectRatio: (200 / 400),
                      children: List.generate(
                        favorites.length,
                        (index) {
                          return InkWell(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => SingleImageView(
                                    photoModel: favorites[index],
                                  ),
                                ),
                              );
                            },
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.network(
                                favorites[index].photoSize.medium,
                                fit: BoxFit.cover,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
