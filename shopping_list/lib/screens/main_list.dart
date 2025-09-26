import 'package:flutter/material.dart';
import 'package:shopping_list/models/grocery_item.dart';
import 'package:shopping_list/screens/new_item_screen.dart';

class MainList extends StatefulWidget {
  const MainList({super.key});

  @override
  State<MainList> createState() => _MainListState();
}

class _MainListState extends State<MainList> {
  final List<GroceryItem> groceryItems = [];

  void removeItem(GroceryItem item) {
    setState(() {
      groceryItems.remove(item);
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget content = Center(child: Text("No items added yet"));

    if (groceryItems.isNotEmpty) {
      content = ListView.builder(
        itemCount: groceryItems.length,

        itemBuilder: (ctx, index) => Dismissible(
          key: ValueKey(groceryItems[index].id),
          onDismissed: (direction) {
            removeItem(groceryItems[index]);
          },
          child: ListTile(
            title: Text(groceryItems[index].name),
            leading: Container(
              height: 24,
              width: 24,
              color: groceryItems[index].category.color,
            ),
            trailing: Text(groceryItems[index].quantity.toString()),
          ),
        ),
      );
    }

    void addItem() async {
      final newItem = await Navigator.push<GroceryItem>(
        context,
        MaterialPageRoute(builder: (context) => NewItemScreen()),
      );

      if (newItem == null) {
        return;
      }

      setState(() {
        groceryItems.add(newItem);
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Shopping List"),
        actions: [IconButton(onPressed: addItem, icon: Icon(Icons.add))],
      ),
      body: content,
    );
  }
}
