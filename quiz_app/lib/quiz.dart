import 'package:flutter/material.dart';
import "package:quiz_app/start_screen.dart";

class Quiz extends StatefulWidget {



  @override
  State<Quiz> createState() {
 
    return _QuizState();
  }
}

class _QuizState extends State<Quiz> {
  @override
  Widget build(context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.deepPurple,
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(colors: [
              Colors.deepPurple,
              Color.fromARGB(31, 229, 219, 219),
            ]),
          ),
          child: StartScreen(),
        ),
      ),
    );
  }
}
