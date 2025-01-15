import 'package:flutter/material.dart';
// import 'package:flutter_playground/styled_text.dart';
import 'package:flutter_playground/dice_roller.dart';

const startAlignment = Alignment.topLeft;
// Alignment? startAlignment;
const endAlignment = Alignment.bottomRight;

class GradientContainer extends StatelessWidget {
  //color as a named argument
  const GradientContainer(this.color1, this.color2, {super.key});

  final Color color1;
  final Color color2;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
        colors: [color1, color2],
        begin: startAlignment,
        end: endAlignment,
      )),
      child: Center(
        child: DiceRoller(),
      ),
    );
  }
}
