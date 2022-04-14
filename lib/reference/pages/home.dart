import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:plantholic/reference/models/photo_model.dart';
import 'package:plantholic/reference/pages/favorites_page.dart';
import 'package:plantholic/reference/pages/singleImage.dart';
import 'package:plantholic/reference/services/network_service.dart';

import '../../app_colors.dart';

class HomePhoto extends StatefulWidget {
  const HomePhoto({Key key}) : super(key: key);

  @override
  _HomePhotoState createState() => _HomePhotoState();
}

class _HomePhotoState extends State<HomePhoto> {
  TextEditingController textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();

    NetworkService().fetchPhotos("plants");
  }

  @override
  void dispose() {
    Hive.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.Grey,
      appBar: AppBar(
        backgroundColor: AppColors.Grey,
        elevation: 0,
        // title: Text(
        //   'Feedback',
        //   style: TextStyle(fontFamily: 'Butler',color: AppColors.Blue),
        // ),
        leading: InkWell(
          onTap: () async {
            Navigator.pop(context);
          },
          child: Icon(MdiIcons.arrowLeft,color: AppColors.Blue,),
        ),
      ),
      body: Stack(
        alignment: Alignment.topCenter,
        children: <Widget>[
          //body images
          FutureBuilder<List<PhotoModel>>(
            future: NetworkService().fetchPhotos("plants"),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return const Center(
                  child: Text('An error has occurred!'),
                );
              } else if (snapshot.hasData) {
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      // const SizedBox(
                      //   height: 10,
                      // ),
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
                              snapshot.data.length,
                              (index) {
                                return InkWell(
                                  onTap: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) => SingleImageView(
                                          photoModel: snapshot.data[index],
                                        ),
                                      ),
                                    );
                                  },
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.network(
                                      snapshot.data[index].photoSize.medium,
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
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
          Padding(
            padding: const EdgeInsets.only(right: 15, left: 15, bottom: 5, top: 45),
            child: Row(
              children: [
                // Expanded(
                //   child: TextField(
                //     onSubmitted: (query) => NetworkService().fetchPhotos(textEditingController.text),
                //     controller: textEditingController,
                //     onChanged: ((e) => {debugPrint(e)}),
                //     decoration: InputDecoration(
                //       filled: true,
                //       fillColor: Colors.white,
                //       prefixIcon: const Icon(
                //         Icons.search_rounded,
                //         color: Colors.grey,
                //       ),
                //       border: OutlineInputBorder(
                //         borderRadius: BorderRadius.circular(55.0),
                //         borderSide: const BorderSide(
                //           width: 0,
                //           style: BorderStyle.none,
                //         ),
                //       ),
                //       hintText: 'Search Wallpapers here',
                //     ),
                //   ),
                // ),
                SizedBox(width: 260,),
                Padding(
                  padding: const EdgeInsets.only(left: 5),
                  child: SizedBox(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 1),
                      child: TextButton(
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.white,
                          shape: const CircleBorder(),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.symmetric(vertical: 8),
                          child: Icon(
                            Icons.favorite_rounded,
                            color: Colors.red,
                            size: 25,
                          ),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return const FavoritesPage();
                              },
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
