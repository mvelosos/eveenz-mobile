import 'package:flutter/material.dart';

class ForgotPassword1Page extends StatefulWidget {
  @override
  _ForgotPassword1PageState createState() => _ForgotPassword1PageState();
}

class _ForgotPassword1PageState extends State<ForgotPassword1Page> {
  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        iconTheme: IconThemeData(color: Colors.blue),
        brightness: Brightness.light,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Stack(
            children: [
              GestureDetector(
                onTap: () {
                  FocusScope.of(context).unfocus();
                },
                child: Container(
                  height: constraints.maxHeight,
                  padding: EdgeInsets.only(left: 10, right: 10),
                  color: Colors.transparent,
                  child: Column(
                    children: [
                      Text(
                        'Esqueceu sua senha?',
                        style: TextStyle(fontSize: 20),
                      ),
                      SizedBox(
                        height: _size.height * .03,
                      ),
                      TextField(
                        autocorrect: false,
                        enableSuggestions: false,
                        decoration: InputDecoration(
                          icon: Icon(Icons.email),
                          labelText: 'E-mail',
                        ),
                      ),
                      SizedBox(
                        height: _size.height * .03,
                      ),
                      RaisedButton(
                        onPressed: () {},
                        child: Text('Esqueci minha senha'),
                      )
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
