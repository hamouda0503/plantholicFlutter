// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:wallpaper_manager_flutter/wallpaper_manager_flutter.dart';
import 'package:plantholic/reference/models/photo_model.dart';
import 'package:plantholic/reference/services/storage_service.dart';

class SingleImageView extends StatefulWidget {
  final PhotoModel photoModel;
  const SingleImageView({Key key, @required this.photoModel}) : super(key: key);

  @override
  _SingleImageViewState createState() => _SingleImageViewState();
}

class _SingleImageViewState extends State<SingleImageView> {
  var isWallpaperSetting = false;
  final box = Favorites.getFavorites();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Image.network(
              widget.photoModel.photoSize.original,
              fit: BoxFit.cover,
              loadingBuilder: (BuildContext context, Widget child,
                  ImageChunkEvent loadingProgress) {
                if (loadingProgress == null) return child;
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded /
                                loadingProgress.expectedTotalBytes
                            : null,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text("Loading wallpaper..."),
                    ],
                  ),
                );
              },
            ),
          ),
          Row(
            children: [
              Expanded(
                child: SizedBox(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 10),
                    child: TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.white,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                        ),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.symmetric(vertical: 8),
                        child: Text(
                          'Set as Wallpaper',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      onPressed: () async {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text('Set As Home Screen'),
                              actions: [
                                TextButton(
                                  style: TextButton.styleFrom(
                                    backgroundColor: Colors.white,
                                    shape: const RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(5)),
                                    ),
                                  ),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text('CANCEL'),
                                ),
                                TextButton(
                                  style: TextButton.styleFrom(
                                    backgroundColor: Colors.blue,
                                    shape: const RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(5)),
                                    ),
                                  ),
                                  onPressed: () {
                                    setWallpaper();
                                    Navigator.pop(context);
                                  },
                                  child: const Text(
                                    'OK',
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                        );
                      },
                    ),
                  ),
                ),
              ),
              Expanded(
                child: SizedBox(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 10),
                    child: TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.white,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: Text(
                          box.containsKey(widget.photoModel.id)
                              ? 'Remove'
                              : 'Add to favorites',
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      onPressed: () async {
                        if (box.containsKey(widget.photoModel.id)) {
                          final favoritePhoto = PhotoModel(
                            id: widget.photoModel.id,
                            url: widget.photoModel.url,
                            photoSize: widget.photoModel.photoSize,
                            isFavorite: false,
                          );
                          box.delete(favoritePhoto.id);
                        } else {
                          final favoritePhoto = PhotoModel(
                            id: widget.photoModel.id,
                            url: widget.photoModel.url,
                            photoSize: widget.photoModel.photoSize,
                            isFavorite: true,
                          );
                          box.put(favoritePhoto.id, favoritePhoto);
                        }
                        setState(() {});
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<bool> setWallpaper() async {
    try {
      var finalFile =
          await getFileFromUrl(widget.photoModel.photoSize.original);
      var croppedImage = await ImageCropper().cropImage(
          sourcePath: finalFile.path,
          aspectRatio: CropAspectRatio(
              ratioX: MediaQuery.of(context).size.width,
              ratioY: MediaQuery.of(context).size.height),
          androidUiSettings: AndroidUiSettings(
            toolbarTitle: 'Crop Image',
            toolbarColor: Colors.blue,
            hideBottomControls: true,
          ));
      if (croppedImage != null) {
        int location = WallpaperManagerFlutter.HOME_SCREEN;
        WallpaperManagerFlutter().setwallpaperfromFile(croppedImage, location);
        debugPrint("wallpaper set successfully");
      }
      return true;
    } catch (e) {
      debugPrint("error Occurred");
      return false;
    }
  }

  dynamic getFileFromUrl(url) async {
    debugPrint("calling url to file buffer");
    var cachedImage = await DefaultCacheManager().getSingleFile(url);
    return cachedImage;
  }
}
