import 'package:hive/hive.dart';

part 'bmi_model.g.dart';

@HiveType(typeId: 0)
class BmiModel extends HiveObject{

  @HiveField(0)
  late String bmi;

  @HiveField(1)
  late String result;

}