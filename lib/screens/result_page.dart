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
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          Container(
            alignment: Alignment.topCenter,
            height: size.height / 3.4,
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
              height: size.height / 3.4,
              decoration: BoxDecoration(
                color: Theme.of(context).backgroundColor,
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(50),
                  topLeft: Radius.circular(50),
                ),
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                "Your Result",
                style: TextStyle(fontSize: 28),
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
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                },
                child: const Text("Done"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
