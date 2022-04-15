import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:plantholic/Blog/comments.dart';
import 'package:plantholic/Model/addBlogModels.dart';
import 'package:plantholic/Model/profileModel.dart';
import 'package:plantholic/NetworkHandler.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:plantholic/app_colors.dart';
import 'package:unicons/unicons.dart';

class BlogCard extends StatefulWidget {
  const BlogCard({Key key, this.addBlogModel, this.networkHandler})
      : super(key: key);

  final AddBlogModel addBlogModel;
  final NetworkHandler networkHandler;

  @override
  State<BlogCard> createState() => _BlogCardState();
}

class _BlogCardState extends State<BlogCard> {
  ProfileModel profileModel = ProfileModel();
  Uint8List bytes;
  AddBlogModel blog;

  String like = "";

  void fetchData() async {
    var response = await widget.networkHandler.get("/profile/getData");
    setState(() {
      profileModel = ProfileModel.fromJson(response["data"]);
      like = widget.addBlogModel.like.toString();
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchData();
    bytes = base64.decode(widget.addBlogModel.coverImage);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 0),
      width: MediaQuery.of(context).size.width,
      child: Card(
        elevation: 0,
        color: Colors.white,
        margin: const EdgeInsets.all(10),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                contentPadding: const EdgeInsets.all(0),
                leading: profileModel.img == null
                    ? null
                    : CircleAvatar(
                        radius: 30,
                        backgroundColor: AppColors.Green,
                        backgroundImage:
                            imageFromBase64String(profileModel.img),
                      ),
                title: Text(widget.addBlogModel.username,
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
                subtitle: Text(widget.addBlogModel.title,
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.normal,
                        color: Colors.grey)),
                trailing: IconButton(
                    onPressed: null,
                    icon: Icon(
                      Icons.more_horiz,
                      color: Theme.of(context).iconTheme.color,
                    )),
              ),
              Row(
                children: [
                  SizedBox(
                    width: 5,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: widget.addBlogModel.title.isEmpty
                        ? const SizedBox.shrink()
                        : Text(
                            widget.addBlogModel.body,
                            textAlign: TextAlign.left,
                          ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image(
                  //image: NetworkHandler().getImage(widget.addBlogModel.id),
                  image: imageFromBase64String(widget.addBlogModel.coverImage),
                  height: 200,
                  width: MediaQuery.of(context).size.width,
                  fit: BoxFit.cover,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        like == "" ? "" : like,
                        style: TextStyle(
                            color: AppColors.Green,
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.bold),
                      ),
                      IconButton(
                          onPressed: () async {
                            Map<String, String> data = {
                              "userId": profileModel.username,
                            };
                            var response = await widget.networkHandler.post(
                                "/blogpost/likes/${widget.addBlogModel.id}",
                                data);
                            if (response.statusCode == 200 ||
                                response.statusCode == 201) {
                              Map<String, dynamic> output =
                                  json.decode(response.body);
                              print(output["like"]);
                              setState(() {
                                like = output["like"].toString();
                              });
                            }
                          },
                          icon: Icon(
                            UniconsLine.thumbs_up,
                            color: AppColors.Green,
                          )),
                      SizedBox(
                        width: 10,
                      ),
                      IconButton(
                          onPressed: () async{
                            Navigator.push(context, MaterialPageRoute(builder:(context)=>Comments(model:widget.addBlogModel)));
                          },
                          icon: Icon(
                            UniconsLine.comment_lines,
                            color: AppColors.Green,
                          )),
                    ],
                  ),
                  // IconButton(
                  //     onPressed: null,
                  //     icon: Icon(
                  //       UniconsLine.comment_lines,
                  //       color: AppColors.Green,
                  //     )),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  MemoryImage imageFromBase64String(String base64String) {
    return MemoryImage(base64.decode(base64String));
  }
}
