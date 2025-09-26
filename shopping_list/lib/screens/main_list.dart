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
    loadedItems = getGroceryItems();
  }

  List<GroceryItem> groceryItems = [];
  late Future<List<GroceryItem>> loadedItems;

  void removeItem(GroceryItem item) async {
    setState(() {
      groceryItems.remove(item);
    });

    final url = Uri.https(
      'plexiform-plane-395112-default-rtdb.firebaseio.com',
      'shopping-list/${item.id}.json',
    );

    final response = await http.delete(url);
  }

  Future<List<GroceryItem>> getGroceryItems() async {
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
        return [];
      }

      if (response.statusCode >= 400) {
        throw Exception('Failed to fectcj ');
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
      return loadedItems;
    } catch (error) {
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
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
      body: FutureBuilder(
        future: getGroceryItems(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          }
          if (snapshot.data!.isEmpty) {
            return Center(child: Text("No items added yet"));
          }
          if (snapshot.data!.isNotEmpty) {
            return ListView.builder(
              itemCount: snapshot.data!.length,

              itemBuilder: (ctx, index) => Dismissible(
                key: ValueKey(snapshot.data![index].id),
                onDismissed: (direction) {
                  removeItem(snapshot.data![index]);
                },
                child: ListTile(
                  title: Text(snapshot.data![index].name),
                  leading: Container(
                    height: 24,
                    width: 24,
                    color: snapshot.data![index].category.color,
                  ),
                  trailing: Text(groceryItems[index].quantity.toString()),
                ),
              ),
            );
          } else {
            return Center(child: Text("No items added yet"));
          }
        },
      ),
    );
  }
}
