import 'package:flutter/material.dart';
import 'package:flutter_playground/gradient_container.dart';

void main() {
  runApp(MaterialApp(
    home: Scaffold(
      backgroundColor: Color.fromARGB(255, 159, 138, 194),
      body: GradientContainer(Color.fromARGB(238, 167, 31, 213),
          Color.fromARGB(121, 236, 195, 195)),
    ),
  ));
}
