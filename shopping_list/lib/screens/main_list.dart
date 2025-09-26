import 'package:flutter/material.dart';
import 'package:shopping_list/data/dummy_items.dart';

class MainList extends StatelessWidget {
  const MainList({super.key});

  @override
  Widget build(BuildContext context) {
    final availableGroceryItems = groceryItems;

    return Scaffold(
      appBar: AppBar(title: const Text("Shopping List")),
      body: ListView.builder(
        itemCount: availableGroceryItems.length,

        itemBuilder: (ctx, index) => ListTile(
          title: Text(availableGroceryItems[index].name),
          leading: Container(
            height: 24,
            width: 24,
            color: availableGroceryItems[index].category.color,
          ),
          trailing: Text(availableGroceryItems[index].quantity.toString()),
        ),
      ),
    );
  }
}
