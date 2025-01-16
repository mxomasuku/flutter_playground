import 'package:flutter/material.dart';
import "package:flutter_playground/start_screen.dart";

void main() {
  runApp(
    MaterialApp(
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
    ),
  );
}
