import '../models/bmi_model.dart';
import '../screens/body_fat_page.dart';
import '../screens/dashboard.dart';
import './screens/bmi_page.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter/material.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(BmiModelAdapter());
  await Hive.openBox<BmiModel>("bmi");
  runApp(const BmiCalculator());
}

class BmiCalculator extends StatelessWidget {
  const BmiCalculator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Bmi Calculator",
      theme: ThemeData(
        primaryColor: Colors.grey[300],
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      home : Dashboard(),
      routes : {
         BmiPage.routeName : (ctx) => const BmiPage(),
        BodyFatPage.routeName : (ctx) => const BodyFatPage(),
      },
    );
  }
}