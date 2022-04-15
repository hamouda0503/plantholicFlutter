import 'package:comment_box/comment/comment.dart';
import 'package:flutter/material.dart';
import 'package:plantholic/Model/SuperModel.dart';
import 'package:plantholic/Model/addBlogModels.dart';
import 'package:plantholic/Model/profileModel.dart';
import 'package:plantholic/NetworkHandler.dart';

class Comments extends StatefulWidget {
  const Comments({Key key, this.model})
      : super(key: key);
  final AddBlogModel model;
  @override
  _CommentsState createState() => _CommentsState();
}

class _CommentsState extends State<Comments> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController commentController = TextEditingController();
  NetworkHandler networkHandler =NetworkHandler();
  ProfileModel profileModel=ProfileModel();
  List<dynamic> filedata = [];






  void fetchData1() async {
    var response = await networkHandler.get("/profile/getData");

    setState(() {
      profileModel = ProfileModel.fromJson(response["data"]);

    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchData1();
     widget.model.comments==[]?filedata=[]:filedata=widget.model.comments;
    print(filedata[0]);
  }


  Widget commentChild(data) {
    return ListView(
      children: [
        for (var i = 0; i < data.length; i++)
          Padding(
            padding: const EdgeInsets.fromLTRB(2.0, 8.0, 2.0, 0.0),
            child: ListTile(
              leading: GestureDetector(
                onTap: () async {
                  // Display the image in large form.
                  print("Comment Clicked");
                },
                child: Container(
                  height: 50.0,
                  width: 50.0,
                  decoration: new BoxDecoration(
                      color: Colors.blue,
                      borderRadius: new BorderRadius.all(Radius.circular(50))),
                  child: CircleAvatar(
                      radius: 50,
                      backgroundImage: NetworkImage(data[i]['coverImage'] + "$i")),
                ),
              ),
              title: Text(
                data[i]['username'],
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(data[i]['comments']),
            ),
          )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("Comment Page"),
        backgroundColor: Colors.pink,
      ),
      // body: Container(
      //   child: CommentBox(
      //     userImage:
      //         profileModel.img,
      //     // child: commentChild(data),
      //     labelText: 'Write a comment...',
      //     withBorder: false,
      //     errorText: 'Comment cannot be blank',
      //     sendButtonMethod: () {
      //       if (formKey.currentState.validate()) {
      //         print(commentController.text);
      //         setState(() {
      //           var value = {
      //             'name': profileModel.username,
      //             'pic':
      //                 profileModel.img,
      //             'message': commentController.text
      //           };
      //           filedata.insert(0, value);
      //         });
      //         commentController.clear();
      //         FocusScope.of(context).unfocus();
      //       } else {
      //         print("Not validated");
      //       }
      //     },
      //     formKey: formKey,
      //     commentController: commentController,
      //     backgroundColor: Colors.black,
      //     textColor: Colors.white,
      //     sendWidget: Icon(Icons.send_sharp, size: 30, color: Colors.white),
      //   ),
      // ),
    );
  }
}
