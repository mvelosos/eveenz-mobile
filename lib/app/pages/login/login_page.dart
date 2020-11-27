import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:party_mobile/app/controllers/login_controller.dart';
import 'package:party_mobile/app/locator.dart';
import 'package:party_mobile/app/view_models/user_login_vm.dart';

import 'components/bezier_container.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var userLogin = UserLoginVM();
  var loginController = locator<LoginController>();

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

  Widget _loginInput() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
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
          SizedBox(height: 10),
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

  Widget _passwordInput() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
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
          SizedBox(height: 10),
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

  Widget _submitButton() {
    var white = Colors.white;
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.symmetric(vertical: 15),
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
          loginController.loginWithEmail(userLogin);
        },
        child: Text(
          'Login',
          style: TextStyle(fontSize: 20, color: white),
        ),
      ),
    );
  }

  Widget _divider() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: <Widget>[
          SizedBox(width: 20),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Divider(thickness: 1),
            ),
          ),
          Text('ou'),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Divider(thickness: 1),
            ),
          ),
          SizedBox(width: 20),
        ],
      ),
    );
  }

  Widget _facebookButton() {
    return Container(
      height: 50,
      margin: EdgeInsets.symmetric(vertical: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Container(
              decoration: BoxDecoration(
                color: Color(0xff1959a9),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(5),
                  topLeft: Radius.circular(5),
                ),
              ),
              alignment: Alignment.center,
              child: Text(
                'f',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 5,
            child: Container(
              decoration: BoxDecoration(
                color: Color(0xff2872ba),
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(5),
                  topRight: Radius.circular(5),
                ),
              ),
              alignment: Alignment.center,
              child: Text(
                'Log in with Facebook',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
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
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(height: constraints.maxHeight * .2),
                        _title(),
                        SizedBox(height: 50),
                        _loginInput(),
                        _passwordInput(),
                        SizedBox(height: 20),
                        _submitButton(),
                        Container(
                          padding: EdgeInsets.symmetric(vertical: 10),
                          alignment: Alignment.centerRight,
                          child: Text(
                            'Esqueceu sua senha?',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        _divider(),
                        _facebookButton(),
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
