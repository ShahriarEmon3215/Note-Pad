import 'package:flutter/material.dart';
import 'package:sqflit_database/Views/Home/Home.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      primaryColor: Colors.amber,
    ),
    home: Home(),
  ));
}


