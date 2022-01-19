import './screens/app_home.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(BmiCalculator());
}

class BmiCalculator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Bmi Calculator",
      theme: ThemeData(
        primaryColor: Colors.grey[400],
        backgroundColor: Colors.white,
      ),
      home : AppHome(),
    );
  }
}