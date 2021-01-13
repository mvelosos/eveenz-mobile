import 'package:flutter/material.dart';

// Page Arguments
class ForgotPasswordPage2Arguments {
  final String email;

  ForgotPasswordPage2Arguments({@required this.email});
}

// Page
class ForgotPassword2Page extends StatefulWidget {
  final ForgotPasswordPage2Arguments args;

  ForgotPassword2Page({@required this.args});

  @override
  _ForgotPassword2PageState createState() => _ForgotPassword2PageState();
}

class _ForgotPassword2PageState extends State<ForgotPassword2Page> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Forgot Password 2',
          style: TextStyle(color: Colors.blue),
        ),
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        iconTheme: IconThemeData(color: Colors.blue),
        brightness: Brightness.light,
      ),
      body: Center(
        child: Text(widget.args.email),
      ),
    );
  }
}
