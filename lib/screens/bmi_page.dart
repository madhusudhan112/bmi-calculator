import 'package:bmicalculator/box_hive/boxes.dart';
import 'package:bmicalculator/models/bmi_model/bmi_model.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
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
  final _formKey = GlobalKey<FormState>();

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
        backgroundColor: Theme.of(context).primaryColor,
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          elevation: 0,
          automaticallyImplyLeading: false,
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios_new,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          title: RichText(
            text: const TextSpan(
              children: [
                TextSpan(
                  text: "BMI ",
                  style: TextStyle(
                    fontSize: 25,
                    color: Color(0xff025949),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                TextSpan(
                  text: "Calculator",
                  style: TextStyle(
                    fontSize: 25,
                    color: Colors.black,
                    fontWeight: FontWeight.w300,
                  ),
                )
              ],
            ),
          ),
        ),
        body: Stack(
          alignment: Alignment.topCenter,
          children: [
            Align(
              alignment: Alignment.bottomRight,
              child: Image.asset(
                "assets/images/dec.png",
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 35, bottom: 25),
              child: Align(
                alignment: Alignment.bottomRight,
                child: CircleAvatar(
                  backgroundColor: Theme.of(context).primaryColor,
                  child: IconButton(
                    icon: const Icon(
                      FontAwesomeIcons.arrowRight,
                      color: Color(0xff025949),
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        weight = int.parse(_weightController.text);
                        age = int.parse(_ageController.text);
                        Calculate_bmi calc = Calculate_bmi(
                          height: double.parse(_heightController.text),
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
                      }
                    },
                  ),
                ),
              ),
            ),
            SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 25.0),
                      child: Text(
                          "Body mass index (BMI) is a measure of body fat based on height and weight that applies to adult men and women. Use the tool below to compute yours"),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 45, vertical: 5),
                      child: const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Gender",
                          style: TextStyle(
                              color: Color(0xff025949),
                              fontSize: 16,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                    Wrap(
                      children: [
                        Container(
                          height: size.height / 13,
                          width: size.width / 2.3,
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(.5),
                                blurRadius: 62.0, // soften the shadow
                              )
                            ],
                          ),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 5, vertical: 3),
                          child: Card(
                            color: male_tapped
                                ? const Color(0xff025949)
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
                              title: Text(
                                "Male",
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  color: male_tapped
                                      ? Colors.white
                                      : const Color(0xff025949),
                                ),
                              ),
                              leading: Icon(
                                Icons.male,
                                size: 25,
                                color: male_tapped
                                    ? Colors.white
                                    : const Color(0xff025949),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          height: size.height / 13,
                          width: size.width / 2.3,
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(.5),
                                blurRadius: 62.0, // soften the shadow
                              )
                            ],
                          ),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 5, vertical: 3),
                          child: Card(
                            color: female_tapped
                                ? const Color(0xff025949)
                                : Theme.of(context).primaryColor,
                            elevation: 4,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25.0),
                              side: BorderSide.none,
                            ),
                            child: ListTile(
                              title: Text(
                                "Female",
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  color: female_tapped
                                      ? Colors.white
                                      : const Color(0xff025949),
                                ),
                              ),
                              leading: Icon(
                                Icons.female,
                                size: 25,
                                color: female_tapped
                                    ? Colors.white
                                    : const Color(0xff025949),
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
                      height: 10,
                    ),
                    Wrap(
                      children: [
                        Container(
                          height: size.height / 2.3,
                          width: size.width / 3.6,
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(.5),
                                blurRadius: 52.0, // soften the shadow
                              )
                            ],
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: Card(
                            color: Theme.of(context).primaryColor,
                            elevation: 4,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25.0)),
                            child: Column(
                              children: [
                                const SizedBox(
                                  height: 10,
                                ),
                                const Text(
                                  "Height(cm)",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xff025949),
                                  ),
                                ),
                                Flexible(
                                  child: SliderTheme(
                                    data: SliderTheme.of(context).copyWith(
                                      thumbColor: const Color(0xff025949),
                                      overlayShape:
                                          const RoundSliderOverlayShape(
                                              overlayRadius: 30.0),
                                      activeTrackColor: const Color(0xff025949),
                                      overlayColor: const Color(0xff025949),
                                    ),
                                    child: SfSlider.vertical(
                                      activeColor: const Color(0xff025949),
                                      value: height,
                                      min: 120.0,
                                      max: 220.0,
                                      inactiveColor: Colors.grey,
                                      onChanged: (value) {
                                        setState(
                                          () {
                                            height = double.parse(
                                                _heightController.text);
                                            height = value;
                                            _heightController.text =
                                                height.toStringAsFixed(2);
                                          },
                                        );
                                      },
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(bottom: 20),
                                  decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(.5),
                                        blurRadius: 52.0, // soften the shadow
                                      )
                                    ],
                                  ),
                                  width: size.width / 4.8,
                                  height: size.height / 24,
                                  child: Card(
                                    color: Theme.of(context)
                                        .primaryColor
                                        .withOpacity(0.99),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    elevation: 4,
                                    child: TextFormField(
                                      style: const TextStyle(
                                          color: Color(0xff025949),
                                          fontWeight: FontWeight.w600),
                                      textAlign: TextAlign.center,
                                      keyboardType:
                                          const TextInputType.numberWithOptions(
                                        signed: false,
                                        decimal: false,
                                      ),
                                      controller: _heightController,
                                      decoration: const InputDecoration(
                                        border: InputBorder.none,
                                        errorStyle:
                                            TextStyle(color: Colors.red),
                                      ),
                                      validator: (val) {
                                        if (val == "" || val == null) {
                                          return "Height Shall not be Empty";
                                        } else if (double.parse(val)
                                            .isNegative) {
                                          return "Height cant be Negative";
                                        } else if (double.parse(val) == 0) {
                                          return "Height cant be 0";
                                        }
                                      },
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 25,
                        ),
                        Column(
                          children: [
                            GridTile(
                              child: Container(
                                height: size.height / 4.8,
                                width: size.width / 2.6,
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(.5),
                                      blurRadius: 52.0, // soften the shadow
                                    )
                                  ],
                                ),
                                margin: const EdgeInsets.symmetric(
                                    vertical: 5, horizontal: 2),
                                child: Card(
                                  color: Theme.of(context).primaryColor,
                                  elevation: 4,
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(25.0)),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      const Text(
                                        "Age (In Year)",
                                        style: TextStyle(
                                          fontSize: 18,
                                          color: Color(0xff025949),
                                          fontWeight: FontWeight.w500,
                                        ),
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
                                            style: const TextStyle(
                                              fontSize: 28,
                                              color: Color(0xff025949),
                                              fontWeight: FontWeight.w700,
                                            ),
                                            controller: _ageController,
                                            decoration: const InputDecoration(
                                              border: InputBorder.none,
                                              errorStyle:
                                                  TextStyle(color: Colors.red),
                                            ),
                                            validator: (val) {
                                              if (val == "" || val == null) {
                                                return "Age Shall not be Empty";
                                              } else if (val.length >= 4) {
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
                                            thickness: 1.5,
                                            color: Color(0xff025949),
                                          )
                                        ],
                                      ),
                                      Wrap(
                                        children: [
                                          CircleAvatar(
                                            backgroundColor:
                                                const Color(0xff025949),
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
                                                const Color(0xff025949),
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
                                height: size.height / 4.8,
                                width: size.width / 2.6,
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(.5),
                                      blurRadius: 62.0, // soften the shadow
                                      //extend the shadow
                                    )
                                  ],
                                ),
                                margin: const EdgeInsets.symmetric(
                                    vertical: 5, horizontal: 5),
                                child: Card(
                                  color: Theme.of(context).primaryColor,
                                  elevation: 4,
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(25.0)),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      const Text(
                                        "Weight (In Kg)",
                                        style: TextStyle(
                                          fontSize: 18,
                                          color: Color(0xff025949),
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      Column(
                                        children: [
                                          TextFormField(
                                            textAlign: TextAlign.center,
                                            keyboardType: TextInputType.number,
                                            style: const TextStyle(
                                              fontSize: 28,
                                              color: Color(0xff025949),
                                              fontWeight: FontWeight.w700,
                                            ),
                                            controller: _weightController,
                                            decoration: const InputDecoration(
                                              border: InputBorder.none,
                                              errorStyle:
                                                  TextStyle(color: Colors.red),
                                            ),
                                            validator: (val) {
                                              if (val == "" || val == null) {
                                                return "Weight Shall not be Empty";
                                              } else if (val.length >= 4) {
                                                return "Please Provide Valid Weight";
                                              } else if (int.parse(val)
                                                  .isNegative) {
                                                return "Weight cant be Negative";
                                              } else if (int.parse(val) == 0) {
                                                return "Weight cant be 0";
                                              } else if (int.parse(val) > 250) {
                                                return "Please Provide Valid Weight";
                                              }
                                            },
                                          ),
                                          const Divider(
                                            thickness: 1.5,
                                            color: Color(0xff025949),
                                          )
                                        ],
                                      ),
                                      Wrap(
                                        children: [
                                          CircleAvatar(
                                            backgroundColor:
                                                const Color(0xff025949),
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
                                                const Color(0xff025949),
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
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
