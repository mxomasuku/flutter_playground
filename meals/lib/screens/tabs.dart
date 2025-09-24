import 'package:flutter/material.dart';
import 'package:meals/providers/favourite_meals_provider.dart';
import 'package:meals/screens/categories.dart';
import 'package:meals/screens/filters.dart';
import 'package:meals/screens/meals.dart';
import 'package:meals/widgets/main_drawer.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/providers/filters_provider.dart';

const kInitialFilters = {
  Filter.glutenFree: false,
  Filter.lactoseFree: false,
  Filter.vegan: false,
  Filter.vegetarian: false,
};

class TabsScreen extends ConsumerStatefulWidget {
  const TabsScreen({super.key});

  @override
  ConsumerState<TabsScreen> createState() {
    return _TabsScreenState();
  }
}

class _TabsScreenState extends ConsumerState<TabsScreen> {
  int _selectedPageIndex = 0;

  void selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  void _setScreen(String identifier) async {
    if (identifier == 'filters') {
      Navigator.pop(context);
      await Navigator.push<Map<Filter, bool>>(
        context,
        MaterialPageRoute(builder: (ctx) => FiltersScreen()),
      );
    } else {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final availableMeals = ref.watch(filteredMealsProvider);

    Widget activeScreen = CategoriesScreen(availableMeals: availableMeals);
    String activeScreenTitle = "Categories";

    if (_selectedPageIndex == 1) {
      final favouriteMeals = ref.watch(favouriteMealProvider);
      activeScreen = MealsScreen(meals: favouriteMeals);
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
