import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Search',
          style: TextStyle(color: Colors.blue),
        ),
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        brightness: Brightness.light,
        automaticallyImplyLeading: false,
      ),
      body: Center(child: Text('This is the search page!')),
    );
  }
}
