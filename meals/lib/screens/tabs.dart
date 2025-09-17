import 'package:flutter/material.dart';
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

  void selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget activeScreen = CategoriesScreen();
    String activeScreenTitle = "Categories";

    if (_selectedPageIndex == 1) {
      activeScreen = MealsScreen(title: 'Favourites', meals: []);
      activeScreenTitle = "Your Favouries";
    }

    return Scaffold(
      appBar: AppBar(title: Text(activeScreenTitle)),
      body: activeScreen,

      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) {
          selectPage(index);
        },
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
