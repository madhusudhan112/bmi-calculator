import '../screens/body_fat_page.dart';
import '../widgets/border_box.dart';
import '../screens/bmi_page.dart';
import 'package:flutter/material.dart';

class Dashboard extends StatelessWidget {
  Dashboard({Key? key}) : super(key: key);
  final _scafoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      drawer: const Drawer(
        child: DrawerHeader(
          child: Text(""),
        ),
      ),
      key: _scafoldKey,
      backgroundColor: Theme.of(context).primaryColor.withOpacity(0.99),
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
            Container(
              height: size.height / 6,
              width: size.width / 0.2,
              margin: const EdgeInsets.symmetric(vertical: 10),
              child: Card(
                child: ListTile(
                  onTap: () {
                    Navigator.of(context).pushNamed(BmiPage.routeName);
                  },
                  leading: const Icon(Icons.health_and_safety),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  title: const Text("Body Mass Index (BMI)"),
                  subtitle: const Text("Calculate Your BMI"),
                ),
              ),
            ),
            Container(
              height: size.height / 6,
              width: size.width / 0.2,
              margin: const EdgeInsets.symmetric(vertical: 10),
              child: Card(
                child: ListTile(
                  onTap: () {
                    Navigator.of(context).pushNamed(BodyFatPage.routeName);
                  },
                  leading: const Icon(Icons.male),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  title: const Text("Body Fat Index (BFI)"),
                  subtitle: const Text("Calculate Your BFI"),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
