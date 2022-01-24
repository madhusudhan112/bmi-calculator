import 'package:bmicalculator/box_hive/boxes.dart';
import 'package:bmicalculator/models/bf_model/bf_model.dart';
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
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _bmiController = TextEditingController();

  @override
  void dispose() {
    Hive.box('bfmodel').close();
    super.dispose();
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
        body: Container(
          height: size.height,
          padding: const EdgeInsets.symmetric(
            horizontal: 20.0,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Text(
                "Calculate Your Body Fat Percentage",
                style: TextStyle(fontSize: 30),
              ),
              GridTile(
                child: Container(
                  height: 180,
                  width: 250,
                  margin:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 2),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextFormField(
                          controller: _ageController,
                          keyboardType: const TextInputType.numberWithOptions(
                            signed: false,
                            decimal: false,
                          ),
                          decoration: InputDecoration(
                            labelText: "Your Age",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            errorStyle: const TextStyle(color: Colors.red),
                          ),
                          validator: (val) {
                            if (val == "" || val == null) {
                              return "Age Shall not be Empty";
                            } else if (val.length >= 4) {
                              return "Please Provide Valid Bmi";
                            } else if (int.parse(val).isNegative) {
                              return "Bmi cant be Negative";
                            } else if (int.parse(val) == 0) {
                              return "Age cant be 0";
                            }
                          },
                        ),
                        TextFormField(
                          controller: _bmiController,
                          keyboardType: const TextInputType.numberWithOptions(
                              signed: false),
                          decoration: InputDecoration(
                            labelText: "Your Body Mass Index",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            errorStyle: const TextStyle(color: Colors.red),
                          ),
                          validator: (val) {
                            if (val == "" || val == null) {
                              return "Bmi Shall not be Empty";
                            } else if (val.length >= 4) {
                              return "Please Provide Valid Bmi";
                            } else if (int.parse(val).isNegative) {
                              return "Bmi cant be Negative";
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: Colors.purpleAccent,
                    fixedSize: const Size(250, 50)),
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
    );
  }
}
