import 'package:flutter/material.dart';
import 'package:shopping_list/models/grocery_item.dart';

class GroceryItemCard extends StatelessWidget {
  const GroceryItemCard({super.key, required this.groceryItem});

  final GroceryItem groceryItem;

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      
      Text(groceryItem.name)]);
  }
}
