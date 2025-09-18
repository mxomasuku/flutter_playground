import 'package:flutter/material.dart';
import 'package:meals/data/dummy_data.dart';
import 'package:meals/models/meal.dart';
import 'package:meals/screens/categories.dart';
import 'package:meals/screens/filters.dart';
import 'package:meals/screens/meals.dart';
import 'package:meals/widgets/main_drawer.dart';

const kInitialFiters = {
  Filter.glutenFree: false,
  Filter.lactoseFree: false,
  Filter.vegan: false,
  Filter.vegetarian: false,
};

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
  Map<Filter, bool> _selectedFilters = kInitialFiters;

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

  void _setScreen(String identifier) async {
    if (identifier == 'filters') {
      Navigator.pop(context);
      final result = await Navigator.push<Map<Filter, bool>>(
        context,
        MaterialPageRoute(
          builder: (ctx) => FiltersScreen(currentFilters: _selectedFilters),
        ),
      );

      setState(() {
        _selectedFilters = result ?? kInitialFiters;
      });
    } else {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final availableMeals = dummyMeals.where((meal) {
      if (_selectedFilters[Filter.glutenFree]! && !meal.isGlutenFree) {
        return false;
      }
      if (_selectedFilters[Filter.lactoseFree]! && !meal.isLactoseFree) {
        return false;
      }
      if (_selectedFilters[Filter.vegan]! && !meal.isVegan) {
        return false;
      }
      if (_selectedFilters[Filter.vegetarian]! && !meal.isVegetarian) {
        return false;
      }
      return true;
    }).toList();

    Widget activeScreen = CategoriesScreen(
      onFavouriteMealSelection: _toggleMealFavouriteStatus,
      availableMeals: availableMeals,
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
      drawer: MainDrawer(onSelectScreen: _setScreen),
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
