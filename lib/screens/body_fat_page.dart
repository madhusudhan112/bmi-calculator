import 'package:bmicalculator/box_hive/boxes.dart';
import 'package:bmicalculator/models/bf_model/bf_model.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hive/hive.dart';

import '../calculator/body_fat_calculator.dart';
import 'package:flutter/material.dart';

import 'body_fat_result.dart';

class BodyFatPage extends StatefulWidget {
  static const routeName = "body_fat-page";

  const BodyFatPage({Key? key}) : super(key: key);

  @override
  _BodyFatPageState createState() => _BodyFatPageState();
}

class _BodyFatPageState extends State<BodyFatPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _ageController =
      TextEditingController(text: "10");
  final TextEditingController _bmiController =
      TextEditingController(text: "10");

  @override
  void dispose() {
    Hive.box('bfmodel').close();
    super.dispose();
  }

  double bmi = 10;
  int age = 10;

  addWeight() {
    setState(() {
      bmi = double.parse(_bmiController.text);
      bmi++;
      _bmiController.text = bmi.toString();
    });
  }

  minusWeight() {
    setState(() {
      if (bmi > 0) {
        bmi = double.parse(_bmiController.text);
        bmi--;
        _bmiController.text = bmi.toString();
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

  Future addBf(String bf) async {
    final _bf = Bfmodel()
      ..bf = bf
      ..createdDate = DateTime.now();
    final box = Boxes.getBf();
    box.add(_bf);
  }

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
          backgroundColor: Theme.of(context).backgroundColor,
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
        backgroundColor: Theme.of(context).primaryColor,
        body: Stack(
          alignment: Alignment.topCenter,
          children: [
            Container(
              height: size.height / 3.5,
              decoration: BoxDecoration(
                color: Theme.of(context).backgroundColor,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(50),
                  bottomRight: Radius.circular(50),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: size.height / 3.5,
                decoration: BoxDecoration(
                  color: Theme.of(context).backgroundColor,
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(50),
                    topLeft: Radius.circular(50),
                  ),
                ),
              ),
            ),
            SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Container(
                  alignment: Alignment.topCenter,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20.0,
                  ),
                  child: Column(
                    children: [
                      const Text(
                        "Body Fat Percentage",
                        style: TextStyle(fontSize: 30),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Column(
                        children: [
                          const SizedBox(
                            height: 20,
                          ),
                          GridTile(
                            child: Container(
                              height: size.height / 3.2,
                              width: size.width / 1.8,
                              margin: const EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 2),
                              child: Card(
                                color: Theme.of(context).primaryColor,
                                elevation: 4,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25.0)),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    const Text(
                                      "Age (In Year)",
                                      style: TextStyle(fontSize: 18),
                                    ),
                                    Column(
                                      children: [
                                        TextFormField(
                                          textAlign: TextAlign.center,
                                          keyboardType: const TextInputType
                                              .numberWithOptions(
                                            signed: false,
                                            decimal: false,
                                          ),
                                          style: const TextStyle(fontSize: 35),
                                          controller: _ageController,
                                          decoration: const InputDecoration(
                                            border: InputBorder.none,
                                            errorStyle: TextStyle(
                                              color: Colors.red,
                                            ),
                                          ),
                                          validator: (val) {
                                            if (val == "" || val == null) {
                                              return "Age Shall not be Empty";
                                            } else if (val.length > 3) {
                                              return "Please Provide Valid Age";
                                            } else if (int.parse(val)
                                                .isNegative) {
                                              return "Age cant be Negative";
                                            } else if (int.parse(val) == 0) {
                                              return "Age cant be 0";
                                            }
                                          },
                                        ),
                                        const Divider(
                                          thickness: 1,
                                          color: Colors.grey,
                                        )
                                      ],
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
                                              FontAwesomeIcons.minus,
                                              size: 15,
                                            ),
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
                          const SizedBox(height: 10),
                          GridTile(
                            child: Container(
                              height: size.height / 3.2,
                              width: size.width / 1.8,
                              margin: const EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 5),
                              child: Card(
                                color: Theme.of(context).primaryColor,
                                elevation: 4,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25.0)),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    const Text(
                                      "Body Mass Index (BMI)",
                                      style: TextStyle(fontSize: 18),
                                    ),
                                    Column(
                                      children: [
                                        TextFormField(
                                          textAlign: TextAlign.center,
                                          keyboardType: const TextInputType
                                                  .numberWithOptions(
                                              signed: false, decimal: true),
                                          style: const TextStyle(fontSize: 35),
                                          controller: _bmiController,
                                          decoration: const InputDecoration(
                                            border: InputBorder.none,
                                            errorStyle:
                                                TextStyle(color: Colors.red),
                                          ),
                                          validator: (val) {
                                            if (val == "" || val == null) {
                                              return "Bmi Shall not be Empty";
                                            } else if (double.parse(val)
                                                .isNegative) {
                                              return "Bmi cant be Negative";
                                            } else if (double.parse(val) == 0) {
                                              return "Bmi cant be 0";
                                            } else if (double.parse(val) > 50) {
                                              return "Please Provide Valid Bmi";
                                            }
                                          },
                                        ),
                                        const Divider(
                                          thickness: 1,
                                          color: Colors.grey,
                                        )
                                      ],
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
                                              FontAwesomeIcons.minus,
                                              size: 15,
                                            ),
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
                      const SizedBox(height: 20),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: const Color(0xff5086F2),
                            fixedSize: const Size(250, 50),
                            elevation: 4,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20))),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            BodyFatCalculator calc = BodyFatCalculator(
                              age: int.parse(_ageController.text),
                              bmi: double.parse(_bmiController.text),
                            );
                            addBf(calc.bfcalulator().toString());
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (_) => BodyFatResultPage(
                                  score: calc.bfcalulator(),
                                  result: calc.result(),
                                  result2: calc.result2(),
                                ),
                              ),
                            );
                          }
                        },
                        child: const Text("Calculate"),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
