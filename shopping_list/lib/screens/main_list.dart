import 'package:flutter/material.dart';
import 'package:shopping_list/models/grocery_item.dart';
import 'package:shopping_list/screens/new_item_screen.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shopping_list/data/categories.dart';

class MainList extends StatefulWidget {
  const MainList({super.key});

  @override
  State<MainList> createState() => _MainListState();
}

class _MainListState extends State<MainList> {
  @override
  void initState() {
    getGroceryItems();
    super.initState();
  }

  List<GroceryItem> groceryItems = [];
  var _isLoading = true;
  String? _error;

  void removeItem(GroceryItem item) async {
    setState(() {
      groceryItems.remove(item);
    });

    final url = Uri.https(
      'plexiform-plane-395112-default-rtdb.firebaseio.com',
      'shopping-list/${item.id}.json',
    );

    final response = await http.delete(url);

    if (response.statusCode >= 400) {
      setState(() {
        groceryItems.add(item);
      });
    }
  }

  getGroceryItems() async {
    final url = Uri.https(
      'plexiform-plane-395112-default-rtdb.firebaseio.com',
      'shopping-list.json',
    );

    try {
      final response = await http.get(
        url,
        headers: {'Content-Type': 'application/json'},
      );

      if (response.body == 'null') {
        setState(() {
          _isLoading = false;
        });
        return;
      }

      if (response.statusCode >= 400) {
        setState(() {
          _error = "Failed to get data. An error occured";
        });
      }

      final Map<String, dynamic> listData = json.decode(response.body);

      final List<GroceryItem> loadedItems = [];
      for (final item in listData.entries) {
        final category = categories.entries
            .firstWhere(
              (catItem) => catItem.value.title == item.value['category'],
            )
            .value;
        loadedItems.add(
          GroceryItem(
            id: item.key,
            name: item.value['name'],
            quantity: item.value['quantity'],
            category: category,
          ),
        );
      }
      setState(() {
        groceryItems = loadedItems;
        _isLoading = false;
      });
    } catch (error) {
      setState(() {
        _error = "An unexpected error occured";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget content = Center(child: Text("No items added yet"));

    if (_isLoading) {
      content = Center(child: CircularProgressIndicator());
    }

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

    if (_error != null) {
      content = Center(child: Text(_error!));
    }

    void addItem() async {
      final newItem = await Navigator.push<GroceryItem>(
        context,
        MaterialPageRoute(builder: (context) => NewItemScreen()),
      );

      if (newItem == null) {
        return;
      }

      getGroceryItems();

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
