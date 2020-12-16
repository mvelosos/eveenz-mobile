import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Home',
          style: TextStyle(color: Colors.blue),
        ),
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        brightness: Brightness.light,
      ),
      body: Center(child: Text('This is the home page!')),
    );
  }
}
