import 'package:flutter/material.dart';

class ResultPage extends StatelessWidget {
  final String score;
  final String result;
  final String result2;

  const ResultPage({
    Key? key,
    required this.score,
    required this.result,
    required this.result2,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Container(
        color: Theme.of(context).primaryColor,
        height: size.height,
        margin: const EdgeInsets.only(left: 35),
        child: Column(
          children: [
            const SizedBox(
              height: 70,
            ),
            const Text(
              "Your Result",
              style: TextStyle(fontSize: 28),
            ),
            const SizedBox(
              height: 50,
            ),
            Container(
              height: size.height / 3,
              width: size.width / 1.2,
              padding: const EdgeInsets.all(5.0),
              child: Card(
                elevation: 8,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: ListTile(
                  title: const Padding(
                    padding: EdgeInsets.only(top: 15),
                    child: Text(
                      "Your BMI is ",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ),
                  subtitle: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: CircleAvatar(
                          radius: 70,
                          child: Text(
                            score,
                            style: const TextStyle(
                                fontSize: 30, fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        result,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Container(
              height: size.height / 8,
              width: size.width / 1.2,
              padding: const EdgeInsets.all(5.0),
              child: Card(
                elevation: 8,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: ListTile(
                  title: Padding(
                    padding: const EdgeInsets.only(top: 15),
                    child: Text(
                      result2,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                elevation: 4,
                primary: const Color(0xff5086F2),
                fixedSize: const Size(250, 40),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
              ),
              onPressed: () {
                Navigator.of(context).pushNamed("/");
              },
              child: const Text("Done"),
            ),
          ],
        ),
      ),
    );
  }
}
