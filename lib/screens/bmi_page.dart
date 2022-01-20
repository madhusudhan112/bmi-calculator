import '../models/bmi_model.dart';
import '../widgets/boxes.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../calculator/calculator.dart';
import '../screens/result_page.dart';
import 'package:flutter/material.dart';

class BmiPage extends StatefulWidget {
  static const routeName = "bmi-page";

  const BmiPage({Key? key}) : super(key: key);

  @override
  State<BmiPage> createState() => _BmiPageState();
}

class _BmiPageState extends State<BmiPage> {
  double height = 150.0;
  int weight = 10;
  int age = 10;

  addWeight() {
    setState(() {
      weight++;
    });
  }

  minusWeight() {
    setState(() {
      if (weight > 0) {
        weight--;
      }
    });
  }

  addAge() {
    setState(() {
      age++;
    });
  }

  minusAge() {
    setState(() {
      if (age > 0) {
        age--;
      }
    });
  }

  @override
  void dispose() {
    Hive.box('bmi').close();
    super.dispose();
  }

  Future addBmi(String bmi, String result) async {
    BmiModel _bmi_model = BmiModel();
    _bmi_model.bmi = bmi;
    _bmi_model.result = result;

    final box = Boxes.getBmi();
    box.add(_bmi_model);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        backgroundColor: Colors.grey[300],
        elevation: 0,
        automaticallyImplyLeading: false,
        title: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: Colors.black,
          ),
        ),
      ),
      body: Container(
        height: size.height,
        padding: const EdgeInsets.symmetric(
          horizontal: 20.0,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const Text(
              "Calculate Your BMI",
              style: TextStyle(fontSize: 30),
            ),
            Row(
              children: [
                GridTile(
                  child: Container(
                    height: 180,
                    width: 180,
                    margin:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 2),
                    child: Card(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          const Text(
                            "Age (In Year)",
                            style: TextStyle(fontSize: 18),
                          ),
                          Text("$age", style: const TextStyle(fontSize: 28)),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              CircleAvatar(
                                child: IconButton(
                                  onPressed: () {
                                    minusAge();
                                  },
                                  icon: const Icon(
                                      Icons.exposure_minus_1_outlined),
                                ),
                              ),
                              CircleAvatar(
                                child: IconButton(
                                  onPressed: () {
                                    addAge();
                                  },
                                  icon: const Icon(Icons.add),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                GridTile(
                  child: Container(
                    height: 180,
                    width: 180,
                    margin:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 3),
                    child: Card(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          const Text(
                            "Weight (In Kg)",
                            style: TextStyle(fontSize: 18),
                          ),
                          Text("$weight", style: const TextStyle(fontSize: 28)),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              CircleAvatar(
                                child: IconButton(
                                  onPressed: () {
                                    minusWeight();
                                  },
                                  icon: const Icon(
                                      Icons.exposure_minus_1_outlined),
                                ),
                              ),
                              CircleAvatar(
                                child: IconButton(
                                  onPressed: () {
                                    addWeight();
                                  },
                                  icon: const Icon(Icons.add),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Container(
              height: size.height / 4,
              width: size.width / 0.2,
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: Card(
                child: Column(
                  children: [
                    const Text(
                      "Height",
                      style: TextStyle(
                        fontSize: 30,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.alphabetic,
                      children: <Widget>[
                        Text(height.toStringAsFixed(2),
                            style: const TextStyle(
                              fontSize: 28,
                            )),
                        const Text(
                          'CM',
                        )
                      ],
                    ),
                    Flexible(
                        child: SliderTheme(
                      data: SliderTheme.of(context).copyWith(
                        thumbColor: Colors.pink,
                        thumbShape: const RoundSliderThumbShape(
                            enabledThumbRadius: 15.0),
                        overlayShape:
                            const RoundSliderOverlayShape(overlayRadius: 30.0),
                        activeTrackColor: Colors.blueGrey,
                        overlayColor: Colors.pink[50],
                      ),
                      child: Slider(
                        value: height,
                        min: 120.0,
                        max: 220.0,
                        inactiveColor: Colors.grey,
                        onChanged: (double value) {
                          setState(
                            () {
                              height = value;
                            },
                          );
                        },
                      ),
                    ))
                  ],
                ),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  primary: Colors.purpleAccent, fixedSize: const Size(250, 50)),
              onPressed: () {
                Calculate_bmi calc = Calculate_bmi(
                  height: height,
                  weight: weight,
                  age: age,
                );
                addBmi(calc.bmi_calculator(), calc.result1());
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => ResultPage(
                      score: calc.bmi_calculator(),
                      result: calc.result1(),
                    ),
                  ),
                );
              },
              child: const Text("Calculate"),
            ),

          ],
        ),
      ),
    );
  }
}
