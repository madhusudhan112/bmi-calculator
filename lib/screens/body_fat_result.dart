import 'package:flutter/material.dart';

class BodyFatResultPage extends StatelessWidget {
  final double score;
  final String result;

  const BodyFatResultPage({
    Key? key,
    required this.score,
    required this.result,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin: const EdgeInsets.only(left: 35.0),
            height: size.height / 4,
            width: size.width / 1.2,
            child: Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: ListTile(
                subtitle: Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: CircleAvatar(
                    radius: 70,
                    child: Text(
                      score.toStringAsFixed(1),
                      style: const TextStyle(fontSize: 24),
                    ),
                  ),
                ),
                title: Text(
                  result,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 18),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
