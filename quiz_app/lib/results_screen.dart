import 'package:flutter/material.dart';

class ResultsScreen extends StatelessWidget {
  const ResultsScreen({super.key, required this.onRestartQuiz});

  final void Function() onRestartQuiz;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Container(
        margin: EdgeInsets.all(40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("You answered 6 answers correctly"),
            SizedBox(height: 30),
            Text("List of answers and questions..."),
            SizedBox(height: 30),
            TextButton(onPressed: onRestartQuiz, child: Text("Restart Quiz"))
          ],
        ),
      ),
    );
  }
}
