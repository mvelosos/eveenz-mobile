import 'package:flutter/material.dart';

class ForgotPassword4Page extends StatefulWidget {
  @override
  _ForgotPassword4PageState createState() => _ForgotPassword4PageState();
}

class _ForgotPassword4PageState extends State<ForgotPassword4Page> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Forgot Password 4',
          style: TextStyle(color: Colors.blue),
        ),
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        iconTheme: IconThemeData(color: Colors.blue),
        brightness: Brightness.light,
      ),
      body: Center(
        child: Text('Forgot password 4'),
      ),
    );
  }
}
