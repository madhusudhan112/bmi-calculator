import 'package:bmicalculator/box_hive/boxes.dart';
import 'package:bmicalculator/models/bf_model/bf_model.dart';
import 'package:bmicalculator/models/bmi_model/bmi_model.dart';
import 'package:intl/intl.dart';
import '../screens/body_fat_page.dart';
import '../screens/bmi_page.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final _scafoldKey = GlobalKey<ScaffoldState>();

  final _refreshKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final bmibox = Boxes.getBmi();
    final bfbox = Boxes.getBf();

    return Scaffold(
      key: _scafoldKey,
      backgroundColor: Theme.of(context).primaryColor,
      body: RefreshIndicator(
        key: _refreshKey,
        child: ListView(
          children: [
            Container(
              color: Theme.of(context).primaryColor,
              height: size.height,
              width: size.width,
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    color: Theme.of(context).primaryColor,
                    height: size.height / 2.2,
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
                              ...bmibox.values,
                            ],
                            xValueMapper: (Bmimodel bmiData, _) =>
                                DateFormat.Hm().format(bmiData.createdDate),
                            yValueMapper: (Bmimodel bmiData, _) =>
                                double.parse(bmiData.bmi),
                          ),
                          LineSeries<Bfmodel, dynamic>(
                            dataSource: [
                              ...bfbox.values,
                            ],
                            xValueMapper: (Bfmodel bfdata, _) =>
                                DateFormat.Hm().format(bfdata.createdDate),
                            yValueMapper: (Bfmodel bfdata, _) =>
                                double.parse(bfdata.bf),
                          )
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 100,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: const Color(0xff5086F2),
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            fixedSize: const Size(180, 150)),
                        onPressed: () {
                          Navigator.of(context).pushNamed(BmiPage.routeName);
                        },
                        child: const Text(
                          "Body Mass Index",
                          textAlign: TextAlign.center,
                        ),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: const Color(0xff5086F2),
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          fixedSize: const Size(180, 150),
                        ),
                        onPressed: () {
                          Navigator.of(context)
                              .pushNamed(BodyFatPage.routeName);
                        },
                        child: const Text(
                          "Body Fat Percentage",
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
        onRefresh: () {
          return Future.delayed(const Duration(seconds: 2), () {
            setState(() {
              Navigator.of(context).popAndPushNamed("/");
            });
          });
        },
      ),
    );
  }
}
