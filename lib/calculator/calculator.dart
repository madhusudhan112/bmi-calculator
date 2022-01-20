import 'dart:math';

class Calculate_bmi {
  double height;
  int age;
  int weight;
  double? bmi;
  double? bf;

  Calculate_bmi({required this.height, required this.weight, required this.age});

  String bmi_calculator() {
    bmi = weight / pow(height / 100, 2);
    return bmi!.toStringAsFixed(1);
  }


  String result1() {
    if (bmi! >= 25) {
      return "OVERWEIGHT";
    } else if (bmi! > 18.5) {
      return "NORMAL WEIGHT";
    } else {
      return "UNDERWEIGHT";
    }
  }

  String result2() {
    if (bmi! >= 25) {
      return 'YOU HAVE OVERWEIGHT BODY NEED HEAVY EXCERCISE';
    } else if (bmi! > 18.5) {
      return 'YOU HAVE NORMAL BODY NEED LEAST EXCERCISE';
    } else {
      return 'YOU HAVE UNDERWEIGHED BODY NEED TO EAT A BIT MORE';
    }
  }
}