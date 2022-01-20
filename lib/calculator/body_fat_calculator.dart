class BodyFatCalculator {
  int age;
  double bmi;
  double? bf;

  BodyFatCalculator({
    required this.age,
    required this.bmi,
  });

  double bfcalulator() {

    bf =  (1.20 * bmi) + (0.23 * age) - 16.2;
    return bf!;
  }

  String result() {
    return "Your Body Fat Percentage is" + " " + bf!.toStringAsFixed(1);
  }
}
