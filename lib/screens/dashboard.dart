import 'package:bmicalculator/box_hive/boxes.dart';
import 'package:bmicalculator/models/bmi_model/bmi_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../screens/body_fat_page.dart';
import '../widgets/border_box.dart';
import '../screens/bmi_page.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class Dashboard extends StatelessWidget {
  Dashboard({Key? key}) : super(key: key);
  final _scafoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final box = Boxes.getBmi();

    return Scaffold(
      drawer: const Drawer(
        child: DrawerHeader(
          child: Text(""),
        ),
      ),
      key: _scafoldKey,
      backgroundColor: Theme.of(context).primaryColor,
      body: Container(
        height: size.height,
        width: size.width,
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          shrinkWrap: true,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                BorderBox(
                  height: 50,
                  width: 50,
                  child: IconButton(
                    icon: const Icon(Icons.menu),
                    onPressed: () => _scafoldKey.currentState!.openDrawer(),
                  ),
                ),
                BorderBox(
                  height: 50,
                  width: 50,
                  child: IconButton(
                    icon: const Icon(Icons.settings),
                    onPressed: () {},
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              color: Theme.of(context).primaryColor,
              height: size.height / 6,
              width: size.width / 0.2,
              child: Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.0)),
                child: ListTile(
                  onTap: () {
                    Navigator.of(context).pushNamed(BmiPage.routeName);
                  },
                  leading: const Padding(
                    padding: EdgeInsets.only(top: 30),
                    child: Icon(
                      Icons.health_and_safety,
                      size: 40,
                    ),
                  ),
                  trailing: const Padding(
                    padding: EdgeInsets.only(top: 30),
                    child: Icon(Icons.arrow_forward_ios),
                  ),
                  title: const Padding(
                    padding: EdgeInsets.only(top: 30),
                    child: Text(
                      "Body Mass Index",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 22),
                    ),
                  ),
                  subtitle: const Padding(
                    padding: EdgeInsets.only(top: 10),
                    child: Text(
                      "Calculate Your BMI",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ),
              ),
            ),
            Container(
              color: Theme.of(context).primaryColor,
              height: size.height / 6,
              width: size.width / 0.2,
              child: Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.0)),
                child: ListTile(
                  onTap: () {
                    Navigator.of(context).pushNamed(BodyFatPage.routeName);
                  },
                  leading: const Padding(
                    padding: EdgeInsets.only(top: 30),
                    child: Icon(
                      Icons.ac_unit,
                      size: 40,
                    ),
                  ),
                  trailing: const Padding(
                    padding: EdgeInsets.only(top: 30),
                    child: Icon(Icons.arrow_forward_ios),
                  ),
                  title: const Padding(
                    padding: EdgeInsets.only(top: 30),
                    child: Text(
                      "Body Fat Percentage",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 22),
                    ),
                  ),
                  subtitle: const Padding(
                    padding: EdgeInsets.only(top: 10),
                    child: Text(
                      "Calculate Your BFP",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ),
              ),
            ),
            Container(
              height: size.height / 3.2,
              width: size.width / 0.2,
              margin: const EdgeInsets.only(top: 20),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: SfCartesianChart(
                  primaryXAxis: CategoryAxis(),
                  series: <ChartSeries>[
                    LineSeries<Bmimodel, dynamic>(
                      dataSource: [
                        ...box.values,
                      ],
                      xValueMapper: (Bmimodel bmiData, _) =>
                          bmiData.createdDate,
                      yValueMapper: (Bmimodel bmiData, _) =>
                          double.parse(bmiData.bmi),
                    )
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
