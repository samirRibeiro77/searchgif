import 'package:flutter/material.dart';
import 'package:search_gif/ui/HomePage.dart';

void main(){
  runApp(MaterialApp(
    home: HomePage(),
    theme: ThemeData(
      hintColor: Colors.white
    ),
  ));
}