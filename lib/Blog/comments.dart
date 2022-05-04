import 'dart:convert';

import 'package:comment_box/comment/comment.dart';
import 'package:flutter/material.dart';
import 'package:plantholic/Model/SuperModel.dart';
import 'package:plantholic/Model/addBlogModels.dart';
import 'package:plantholic/Model/profileModel.dart';
import 'package:plantholic/NetworkHandler.dart';
import 'package:plantholic/app_colors.dart';

class Comments extends StatefulWidget {
  const Comments({Key key, this.id}) : super(key: key);
  final String id;

  @override
  _CommentsState createState() => _CommentsState();
}

class _CommentsState extends State<Comments> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController commentController = TextEditingController();
  NetworkHandler networkHandler = NetworkHandler();
  ProfileModel profileModel = ProfileModel();
  ProfileModel prof = ProfileModel();
  List<dynamic> filedata = [];
  AddBlogModel blog = AddBlogModel();
  List<String> comments = [];
  List<String> test = [];
  bool valid = false;

  List<ProfileModel> users = [];

  void fetchData1() async {
    var response = await networkHandler.get("/profile/getData");
    var response1 = await networkHandler.get("/blogpost/getBlog/${widget.id}");
    setState(() {
      profileModel = ProfileModel.fromJson(response["data"]);
      blog = AddBlogModel.fromJson(response1["data"]);
      filedata = blog.comments;
    });
    filedata.forEach((file) async {
      var response2 =
          await networkHandler.get("/blogpost/getComment/${file.toString()}");
      setState(() {
        String com = response2["data"]["content"].toString();
        // String use = response2["data"]["username"].toString();
        comments.add(com);
        // users.add(use);
      });
      var response3 = await networkHandler
          .get("/profile/getData/${response2["data"]["username"].toString()}");
      prof = ProfileModel.fromJson(response3["data"]);
      setState(() {
        users.add(prof);
        print(users);
      });
    });

  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchData1();

  }

  Widget commentChild(List data) {
    return ListView.builder(
        itemCount: data.length,
        itemBuilder: (BuildContext context, int i) {
          return ListTile(
            leading: GestureDetector(
              onTap: () async {
              },
              child: Container(
                height: 50.0,
                width: 50.0,
                decoration: new BoxDecoration(
                    color: Colors.blue,
                    borderRadius: new BorderRadius.all(Radius.circular(50))),
                child: CircleAvatar(
                    radius: 50,
                    backgroundImage: MemoryImage(base64.decode(users[i].img))),
              ),
            ),
            title: Text(
              users[i].username,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(comments[i]),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Comments",
            style: TextStyle(fontFamily: "Butler", color: AppColors.Blue)),
        backgroundColor: AppColors.Grey,
      ),
      body: Container(
        child: CommentBox(
          userImage:
              "https://www.pngall.com/wp-content/uploads/8/Comment-Transparent.png",
          child: commentChild(filedata),
          labelText: 'Write a comment...',
          withBorder: false,
          errorText: 'Comment cannot be blank',
          sendButtonMethod: () async {
            if (formKey.currentState.validate()) {
              print(commentController.text);
              Map<String, String> data = {
                "content": commentController.text,
                "username": profileModel.username,
              };
              print(data);
              var response = await networkHandler.post(
                  "/blogpost/${widget.id}/comments", data);
              print(response);
              if (response.statusCode == 200 || response.statusCode == 201) {
                setState(() {
                  fetchData1();
                });
              }
              commentController.clear();
              FocusScope.of(context).unfocus();
            } else {
              print("Not validated");
            }
          },
          formKey: formKey,
          commentController: commentController,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          sendWidget: Icon(Icons.send_sharp, size: 30, color: Colors.white),
        ),
      ),
    );
  }
}
