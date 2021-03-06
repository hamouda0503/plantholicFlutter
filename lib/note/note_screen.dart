import 'package:flutter/material.dart';

import 'screens/note_list.dart';


class NoteScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NoteKeeper',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.black,
        primaryColorDark: Colors.black,
        primaryColorLight: Colors.white,
      ),
      home: NoteList(),
    );
  }
}
