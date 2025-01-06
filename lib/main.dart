import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Scaffold(
      backgroundColor: Color.fromARGB(255, 159, 138, 194),
      body: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(colors: [
           Color.fromARGB(31, 155, 149, 149),
          Colors.deepPurple
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight )),
        child: Center(child: Text("Hello Flutter")),
      ),
    ),
  ));
}
