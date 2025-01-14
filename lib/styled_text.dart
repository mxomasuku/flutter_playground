import "package:flutter/material.dart";

class StyledText extends StatelessWidget {
  //text as a positional argument
  StyledText(this.text, {super.key});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(text, style: TextStyle(color: Colors.black38, fontSize: 32.0));
  }
}
