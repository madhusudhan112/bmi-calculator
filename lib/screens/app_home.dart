import 'package:bmicalculator/calculator/calculator.dart';
import 'package:bmicalculator/screens/result_page.dart';
import 'package:flutter/material.dart';

class AppHome extends StatefulWidget {
  @override
  State<AppHome> createState() => _AppHome();
}

class _AppHome extends State<AppHome> {
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
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        height: size.height,
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              children: [
                GridTile(
                  child: Container(
                    height: 180,
                    width: 180,
                    margin:
                        const EdgeInsets.symmetric(vertical: 10, horizontal: 2),
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
                        const EdgeInsets.symmetric(vertical: 10, horizontal: 3),
                    child: Card(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          const Text(
                            "Weight (In Kg)",
                            style: TextStyle(fontSize: 18),
                          ),
                          Text(
                            "$weight",
                            style: const TextStyle(fontSize: 28),
                          ),
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
                   const  Text(
                      "Height",
                      style: TextStyle(
                        fontSize: 30,
                      ),
                    ),
                  const   SizedBox(
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
                       const  Text(
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
                Calculate_bmi calc =
                    Calculate_bmi(height: height, weight: weight);
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
