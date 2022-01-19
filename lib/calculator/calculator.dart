import 'dart:math';

class Calculate_bmi {
  double height;
  int weight;
  double? _bmi;

  Calculate_bmi({required this.height, required this.weight});

  String bmi_calculator() {
    _bmi = weight / pow(height / 100, 2);
    return _bmi!.toStringAsFixed(1);
  }

  String result1() {
    if (_bmi! >= 25) {
      return "OVERWEIGHT";
    } else if (_bmi! > 18.5) {
      return "NORMAL WEIGHT";
    } else {
      return "UNDERWEIGHT";
    }
  }

  String result2() {
    if (_bmi! >= 25) {
      return 'YOU HAVE OVERWEIGHT BODY NEED HEAVY EXCERCISE';
    } else if (_bmi! > 18.5) {
      return 'YOU HAVE NORMAL BODY NEED LEAST EXCERCISE';
    } else {
      return 'YOU HAVE UNDERWEIGHED BODY NEED TO EAT A BIT MORE';
    }
  }
}
