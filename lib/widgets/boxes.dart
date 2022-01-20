import 'package:bmicalculator/models/bmi_model.dart';
import 'package:hive/hive.dart';

class Boxes {
  static Box<BmiModel> getBmi() => Hive.box<BmiModel>("bmi");
}