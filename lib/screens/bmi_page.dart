import 'package:bmicalculator/box_hive/boxes.dart';
import 'package:bmicalculator/models/bmi_model/bmi_model.dart';
import 'package:hive/hive.dart';
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
      weight = int.parse(_weightController.text);
      weight++;
      _weightController.text = weight.toString();
    });
  }

  minusWeight() {
    setState(() {
      if (weight > 0) {
        weight = int.parse(_weightController.text);
        weight--;
        _weightController.text = weight.toString();
      }
    });
  }

  addAge() {
    setState(() {
      age = int.parse(_ageController.text);
      age++;
      _ageController.text = age.toString();
    });
  }

  minusAge() {
    setState(() {
      if (age > 0) {
        age = int.parse(_ageController.text);
        age--;
        _ageController.text = age.toString();
      }
    });
  }

  @override
  void dispose() {
    Hive.box('bmimodel').close();
    super.dispose();
  }

  Future addBmi(String bmi) async {
    final _bmi = Bmimodel()
      ..bmi = bmi
      ..createdDate = DateTime.now();

    final box = Boxes.getBmi();
    box.add(_bmi);
    print(_bmi.bmi);
  }

  final _ageController = TextEditingController(text: "10");
  final _weightController = TextEditingController(text: "10");
  final _heightController = TextEditingController(text: "150");

  bool male_tapped = false;
  bool female_tapped = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        FocusScopeNode cf = FocusScope.of(context);
        if (!cf.hasPrimaryFocus) {
          cf.unfocus();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
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
          color: Theme.of(context).primaryColor,
          padding: const EdgeInsets.symmetric(
            horizontal: 10.0,
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Text(
                  "BMI Calculator",
                  style: TextStyle(fontSize: 30),
                ),
                const SizedBox(
                  height: 10,
                ),
                Wrap(
                  children: [
                    GridTile(
                      child: Container(
                        height: 180,
                        width: 160,
                        margin: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 2),
                        child: Card(
                          color: Theme.of(context).primaryColor,
                          elevation: 4,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25.0)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              const Text(
                                "Age (In Year)",
                                style: TextStyle(fontSize: 18),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: Column(
                                  children: [
                                    TextFormField(
                                      keyboardType: TextInputType.number,
                                      style: const TextStyle(fontSize: 28),
                                      controller: _ageController,
                                      decoration: const InputDecoration(
                                        contentPadding: EdgeInsets.symmetric(
                                            horizontal: 40),
                                        border: InputBorder.none,
                                      ),
                                    ),
                                    const Divider(
                                      thickness: 1.5,
                                      color: Color(0xff5086F2),
                                    )
                                  ],
                                ),
                              ),
                              Wrap(
                                children: [
                                  CircleAvatar(
                                    backgroundColor:
                                        Theme.of(context).backgroundColor,
                                    child: IconButton(
                                      onPressed: () {
                                        minusAge();
                                      },
                                      icon: const Icon(
                                          Icons.exposure_minus_1_outlined),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 35,
                                  ),
                                  CircleAvatar(
                                    backgroundColor:
                                        Theme.of(context).backgroundColor,
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
                        width: 160,
                        margin: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 5),
                        child: Card(
                          color: Theme.of(context).primaryColor,
                          elevation: 4,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25.0)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              const Text(
                                "Weight (In Kg)",
                                style: TextStyle(fontSize: 18),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: Column(
                                  children: [
                                    TextFormField(
                                      keyboardType: TextInputType.number,
                                      style: const TextStyle(fontSize: 28),
                                      controller: _weightController,
                                      decoration: const InputDecoration(
                                          contentPadding: EdgeInsets.symmetric(
                                              horizontal: 40),
                                          border: InputBorder.none),
                                    ),
                                    const Divider(
                                      thickness: 1.5,
                                      color: Color(0xff5086F2),
                                    )
                                  ],
                                ),
                              ),
                              Wrap(
                                children: [
                                  CircleAvatar(
                                    backgroundColor:
                                        Theme.of(context).backgroundColor,
                                    child: IconButton(
                                      onPressed: () {
                                        minusWeight();
                                      },
                                      icon: const Icon(
                                          Icons.exposure_minus_1_outlined),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 35,
                                  ),
                                  CircleAvatar(
                                    backgroundColor:
                                        Theme.of(context).backgroundColor,
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
                const SizedBox(
                  height: 10,
                ),
                Container(
                  height: size.height / 4,
                  width: size.width / 0.2,
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: Card(
                    color: Theme.of(context).primaryColor,
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25.0)),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        const Padding(
                          padding: EdgeInsets.only(left: 10),
                          child: Text(
                            "Height",
                            style: TextStyle(
                              fontSize: 30,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        const Text("CM"),
                        Wrap(
                          children: <Widget>[
                            Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 130),
                                  child: TextFormField(
                                    controller: _heightController,
                                    decoration: const InputDecoration(
                                      border: InputBorder.none,
                                      contentPadding: EdgeInsets.only(left: 20),
                                    ),
                                    style: const TextStyle(
                                      fontSize: 28,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 100,
                                  child: Padding(
                                    padding: EdgeInsets.only(left: 10.0),
                                    child: Divider(
                                      height: 20,
                                      thickness: 1.5,
                                      color: Color(0xff5086F2),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Flexible(
                            child: SliderTheme(
                          data: SliderTheme.of(context).copyWith(
                            thumbColor: const Color(0xff5E7EBF),
                            thumbShape: const RoundSliderThumbShape(
                                enabledThumbRadius: 15.0),
                            overlayShape: const RoundSliderOverlayShape(
                                overlayRadius: 30.0),
                            activeTrackColor: const Color(0xff4E7CD9),
                            overlayColor: const Color(0xff5E7EBF),
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
                                  _heightController.text =
                                      height.toStringAsFixed(2);
                                },
                              );
                            },
                          ),
                        ))
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Wrap(
                  children: [
                    Container(
                      height: size.height / 6,
                      width: size.width / 2.5,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 5, vertical: 3),
                      child: Card(
                        color: male_tapped
                            ? const Color(0xffC4D4F2)
                            : Theme.of(context).primaryColor,
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25.0)),
                        child: ListTile(
                          onTap: () {
                            setState(() {
                              male_tapped = !male_tapped;
                              female_tapped = false;
                            });
                          },
                          title: const Padding(
                            padding: EdgeInsets.symmetric(vertical: 15),
                            child: Text(
                              "Male",
                              textAlign: TextAlign.center,
                            ),
                          ),
                          subtitle: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 2),
                            child: Image.asset(
                              "assets/images/male.png",
                              width: 30,
                              height: 30,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      height: size.height / 6,
                      width: size.width / 2.5,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 5, vertical: 3),
                      child: Card(
                        color: female_tapped
                            ? const Color(0xffC4D4F2)
                            : Theme.of(context).primaryColor,
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25.0),
                          side: BorderSide.none,
                        ),
                        child: ListTile(
                          title: const Padding(
                            padding: EdgeInsets.symmetric(vertical: 15),
                            child: Text(
                              "Female",
                              textAlign: TextAlign.center,
                            ),
                          ),
                          subtitle: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 2),
                            child: Image.asset(
                              "assets/images/female.png",
                              width: 30,
                              height: 30,
                            ),
                          ),
                          onTap: () {
                            setState(() {
                              female_tapped = !female_tapped;
                              male_tapped = false;
                            });
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: const Color(0xff5086F2),
                    fixedSize: const Size(250, 50),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25.0)),
                    elevation: 8,
                  ),
                  onPressed: () {
                    weight = int.parse(_weightController.text);
                    age = int.parse(_ageController.text);
                    Calculate_bmi calc = Calculate_bmi(
                      height: height,
                      weight: weight,
                      age: age,
                    );
                    addBmi(calc.bmi_calculator());
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => ResultPage(
                          score: calc.bmi_calculator(),
                          result: calc.result1(),
                          result2: calc.result2(),
                        ),
                      ),
                    );
                  },
                  child: const Text("Calculate"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
