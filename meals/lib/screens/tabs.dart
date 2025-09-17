import 'package:flutter/material.dart';
import 'package:meals/models/meal.dart';
import 'package:meals/screens/categories.dart';
import 'package:meals/screens/meals.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _TabsScreenState();
  }
}

class _TabsScreenState extends State<TabsScreen> {
  int _selectedPageIndex = 0;
  final List<Meal> _favouriteMeals = [];

  void selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  void _showInfoMessage(String message) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  void _toggleMealFavouriteStatus(Meal meal) {
    final isExisting = _favouriteMeals.contains(meal);

    if (isExisting) {
      setState(() {
        _favouriteMeals.remove(meal);
        _showInfoMessage(
          '${meal.title} '
          "is removed from favs",
        );
      });
    } else {
      setState(() {
        _favouriteMeals.add(meal);
        _showInfoMessage(
          '${meal.title} '
          "is added to favs",
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget activeScreen = CategoriesScreen(
      onFavouriteMealSelection: _toggleMealFavouriteStatus,
    );
    String activeScreenTitle = "Categories";

    if (_selectedPageIndex == 1) {
      activeScreen = MealsScreen(
        meals: _favouriteMeals,
        onFavouriteMealSelection: _toggleMealFavouriteStatus,
      );
      activeScreenTitle = "Your Favourites";
    }

    return Scaffold(
      appBar: AppBar(title: Text(activeScreenTitle)),
      body: activeScreen,

      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) {
          selectPage(index);
        },
        currentIndex: _selectedPageIndex,
        items: [
          const BottomNavigationBarItem(
            icon: Icon(Icons.set_meal),
            label: "Categories",
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.star),
            label: "Favouries",
          ),
        ],
      ),
    );
  }
}
