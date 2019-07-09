import 'package:flutter/material.dart';
import './screens/home_screen.dart';
void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Earthquake',
      theme: ThemeData(
        brightness: Brightness.light,
        accentColor: Colors.greenAccent,
        primarySwatch: Colors.red
      ),
      home: HomeScreen(),
    );
  }
}