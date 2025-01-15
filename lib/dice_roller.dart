import "dart:math";

import "package:flutter/material.dart";

final randomizer = Random();

class DiceRoller extends StatefulWidget {
  const DiceRoller({super.key});

  @override
  State<DiceRoller> createState() {
    return _DiceRollerState();
  }
}

//underscore class means the class in private
class _DiceRollerState extends State<DiceRoller> {
  var currentDiceRoll = 2;

  void rollDice() {
    //triggers reload
    setState(() {
      currentDiceRoll = randomizer.nextInt(6) + 1;
    });

    print("Changing Image");
  }

  @override
  Widget build(context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset(
          'assets/images/dice-$currentDiceRoll.png',
          width: 200,
        ),
        TextButton(
            onPressed: rollDice,
            style: TextButton.styleFrom(
                padding: EdgeInsets.all(20),
                foregroundColor: Colors.white,
                textStyle: TextStyle(fontSize: 28)),
            child: Text("Roll Dice"))
      ],
    );
  }
}
