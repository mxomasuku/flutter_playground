import 'package:flutter/material.dart';
import 'package:meals/data/dummy_data.dart';
import 'package:meals/models/meal.dart';

class MealsScreen extends StatelessWidget {
  const MealsScreen({super.key, required this.title, required this.meals});

  final String title;
  final List<Meal> meals;

  @override
  Widget build(BuildContext context) {
    Widget content = ListView.builder(
      itemCount: meals.length,
      itemBuilder: ((context, index) {
        return Text(
          meals[index].title,
          style: TextStyle(color: Colors.white38),
        );
      }),
    );

    if (meals.isEmpty) {
      content = Center(
        child: Column(
          children: [
            Text("No meals to show", style: TextStyle(color: Colors.red)),

            SizedBox(height: 16),
            Text(
              "Try selecting a different category",
              style: TextStyle(color: Colors.red),
            ),
          ],
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: content,
    );
  }
}
