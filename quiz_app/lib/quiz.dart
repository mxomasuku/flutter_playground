import 'package:flutter/material.dart';
import "package:quiz_app/start_screen.dart";
import "package:quiz_app/questions.dart";

class Quiz extends StatefulWidget {
  @override
  State<Quiz> createState() {
    return _QuizState();
  }
}

class _QuizState extends State<Quiz> {

  //might be null 
  Widget? activeScreen;

  @override

  //init state runs only once and doesn't run again, do not call setState in here
  void initState() {
    activeScreen = StartScreen(switchScreen);
    super.initState();
  }

  void switchScreen() {
    setState(() {
      activeScreen = QuestionsScreen();
    });
  }

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
          child: activeScreen,
        ),
      ),
    );
  }
}
