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
          Image.asset('assets/images/quiz-logo.png',
              width: 300, color: const Color.fromARGB(150, 255, 254, 254)),
          SizedBox(height: 80),
          Text(
            "Learn Flutter The Fun Way",
            style: TextStyle(color: Colors.white, fontSize: 24),
          ),
          SizedBox(height: 30),
          OutlinedButton.icon(
            onPressed: onOutLinedButtonClicked,
            style: OutlinedButton.styleFrom(foregroundColor: Colors.white),
            icon: const Icon(Icons.arrow_right_alt),
            label: Text("Start Quiz"),
          )
        ],
      ),
    );

    // Image.asset("assets/images/quiz.png");
  }
}
