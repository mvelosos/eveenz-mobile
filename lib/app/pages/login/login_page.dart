import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:party_mobile/app/controllers/login_controller.dart';
import 'package:party_mobile/app/locator.dart';
import 'package:party_mobile/app/pages/login/widgets/facebook_login_button.dart';
import 'package:party_mobile/app/view_models/user_login_vm.dart';

import 'widgets/bezier_container.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var userLogin = UserLoginVM();
  var _loginController = locator<LoginController>();

  Widget _title() {
    return Text(
      'hango',
      style: TextStyle(
        fontSize: 40,
        fontWeight: FontWeight.bold,
        color: Color.fromRGBO(114, 120, 239, 1),
        shadows: [
          Shadow(
            // bottomLeft
            offset: Offset(-1.5, -1.5),
            color: Colors.white,
          ),
          Shadow(
            // bottomRight
            offset: Offset(1.5, -1.5),
            color: Colors.white,
          ),
          Shadow(
            // topRight
            offset: Offset(1.5, 1.5),
            color: Colors.white,
          ),
          Shadow(
            // topLeft
            offset: Offset(-1.5, 1.5),
            color: Colors.white,
          ),
        ],
      ),
    );
  }

  Widget _loginInput(BoxConstraints constraints) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: constraints.maxHeight * .01),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Nome de usuário ou e-mail',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
          ),
          SizedBox(height: constraints.maxHeight * .01),
          TextField(
            autocorrect: false,
            enableSuggestions: false,
            decoration: InputDecoration(
              border: InputBorder.none,
              fillColor: Color(0xfff3f3f4),
              filled: true,
            ),
            onChanged: (value) {
              userLogin.login = value;
            },
          )
        ],
      ),
    );
  }

  Widget _passwordInput(BoxConstraints constraints) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: constraints.maxHeight * .01),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Senha',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
          ),
          SizedBox(height: constraints.maxHeight * .01),
          TextField(
            obscureText: true,
            enableSuggestions: false,
            decoration: InputDecoration(
              border: InputBorder.none,
              fillColor: Color(0xfff3f3f4),
              filled: true,
            ),
            onChanged: (value) {
              userLogin.password = value;
            },
          )
        ],
      ),
    );
  }

  Widget _submitButton(BoxConstraints constraints) {
    var white = Colors.white;
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.symmetric(vertical: constraints.maxHeight * .017),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(5),
        ),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.grey.shade200,
            offset: Offset(2, 4),
            blurRadius: 5,
            spreadRadius: 2,
          ),
        ],
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [
            Color(0xfffbb448),
            Color(0xfff7892b),
          ],
        ),
      ),
      child: InkWell(
        onTap: () {
          _loginController.loginWithEmail(userLogin);
        },
        child: Text(
          'Login',
          style: TextStyle(fontSize: 20, color: white),
        ),
      ),
    );
  }

  Widget _divider(BoxConstraints constraints) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: constraints.maxHeight * .012),
      child: Row(
        children: <Widget>[
          SizedBox(width: 20),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: constraints.maxWidth * .02,
              ),
              child: Divider(thickness: 1),
            ),
          ),
          Text('ou'),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: constraints.maxWidth * .02,
              ),
              child: Divider(thickness: 1),
            ),
          ),
          SizedBox(width: 20),
        ],
      ),
    );
  }

  Widget _createAccountLabel() {
    return InkWell(
      onTap: () {},
      child: Container(
        padding: EdgeInsets.all(15),
        alignment: Alignment.bottomCenter,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Não tem uma conta?',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(width: 10),
            Text(
              'Registrar',
              style: TextStyle(
                color: Color(0xfff79c4f),
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);

    return Scaffold(
      body: LayoutBuilder(builder: (context, constraints) {
        return GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Container(
            height: constraints.maxHeight,
            child: Stack(
              children: <Widget>[
                Positioned(
                  top: -constraints.maxHeight * .15,
                  right: -constraints.maxWidth * .4,
                  child: BezierContainer(),
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: constraints.maxWidth * .05,
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(height: constraints.maxHeight * .2),
                        _title(),
                        SizedBox(height: constraints.maxHeight * .06),
                        _loginInput(constraints),
                        _passwordInput(constraints),
                        SizedBox(height: constraints.maxHeight * .025),
                        _submitButton(constraints),
                        Container(
                          padding: EdgeInsets.symmetric(
                            vertical: constraints.maxHeight * .015,
                          ),
                          alignment: Alignment.centerRight,
                          child: Text(
                            'Esqueceu sua senha?',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        _divider(constraints),
                        SizedBox(height: constraints.maxHeight * .03),
                        FacebookLoginButton(loginController: _loginController),
                        SizedBox(height: constraints.maxHeight * .055),
                        _createAccountLabel(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
