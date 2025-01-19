import "package:flutter/material.dart";

class StartScreen extends StatelessWidget {
  const StartScreen({super.key});

  void onOutLinedButtonClicked() {
    print("button clicked");
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset('assets/images/quiz-logo.png', width: 300),
          SizedBox(height: 80),
          Text(
            "Learn Flutter The Fun Way",
            style: TextStyle(color: Colors.white, fontSize: 24),
          ),
          SizedBox(height: 30),
          OutlinedButton(
            onPressed: onOutLinedButtonClicked,
            style: OutlinedButton.styleFrom(foregroundColor: Colors.white),
            child: Text("Click"),
          )
        ],
      ),
    );

    // Image.asset("assets/images/quiz.png");
  }
}
