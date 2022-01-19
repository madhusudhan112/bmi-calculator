import 'package:flutter/material.dart';

class ResultPage extends StatelessWidget {
  final String score;
  final String result;

 const  ResultPage({
    Key? key,
    required this.score,
    required this.result,
  }) : super(key:key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child: ListTile(
              leading: CircleAvatar(
                child: Text(score),
              ),
              title: Text(
                result,
                textAlign: TextAlign.center,
              ),
            ),
          )
        ],
      ),
    );
  }
}
