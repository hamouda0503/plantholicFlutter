import 'package:flutter/material.dart';


class WidgetTitle extends StatefulWidget {
  const WidgetTitle({Key key}) : super(key: key);

  @override
  _WidgetTitleState createState() => _WidgetTitleState();
}

class _WidgetTitleState extends State<WidgetTitle> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(20, 30, 20, 10),
      child: Column(
        children: [
          Text(
            "What are you looking for?",
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.black,
                fontSize: 10,
                fontWeight: FontWeight.bold
            ),
          ),
          SizedBox(height: 10,),
          Text(
            "Here are our best features",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.grey,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
