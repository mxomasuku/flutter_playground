import 'package:flutter/material.dart';
import "package:quiz_app/start_screen.dart";
import "package:quiz_app/questions.dart";

class Quiz extends StatefulWidget {
  const Quiz({super.key});

  @override
  State<Quiz> createState() {
    return _QuizState();
  }
}

class _QuizState extends State<Quiz> {
  //might be null
  var activeScreen = "start-screen";

  @override

  //init state runs only once and doesn't run again, do not call setState in here
  // void initState() {
  //   activeScreen = StartScreen(switchScreen);
  //   super.initState();
  // }

void switchScreen() {
    setState(() {
      activeScreen = "questions-screen";
    });
  }

  @override
  Widget build(context) {

Widget screenWidget = StartScreen(switchScreen);

if(activeScreen == "questions-screen"){
screenWidget = QuestionsScreen();
}



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
          child: screenWidget,
        ),
      ),
    );
  }
}
