import 'package:flutter/material.dart';

class FavouritesScreen extends StatefulWidget {
  const FavouritesScreen({super.key});
  @override
  State<StatefulWidget> createState() {
    return _FavouritesScreenState();
  }
}

class _FavouritesScreenState extends State<FavouritesScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      child: Text("FAVS", style: TextStyle(color: Colors.white)),
    );
  }
}
