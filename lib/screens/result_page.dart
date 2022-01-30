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
    double bmiscore = double.parse(score);
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: Theme.of(context).primaryColor,
        centerTitle: true,
        title: const Text(
          "Your Result",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w500,
            fontSize: 25,
          ),
        ),
      ),
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          Align(
            alignment: Alignment.bottomRight,
            child: Image.asset("assets/images/dec.png"),
          ),
          Column(
            children: [
              Container(
                height: size.height / 2.7,
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
                            backgroundColor: const Color(0xff025949),
                            radius: 70,
                            child: bmiscore > 60
                                ? const Text(
                                    "Error",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 30,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  )
                                : bmiscore.isNegative
                                    ? const Text(
                                        "Error",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 30,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      )
                                    : Text(
                                        bmiscore.toString(),
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 30,
                                          fontWeight: FontWeight.w500,
                                        ),
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
              const SizedBox(
                height: 35,
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
                height: 35,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  elevation: 4,
                  primary: const Color(0xff025949),
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
