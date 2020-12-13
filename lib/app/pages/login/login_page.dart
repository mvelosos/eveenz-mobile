import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:party_mobile/app/controllers/login_controller.dart';
import 'package:party_mobile/app/locator.dart';
import 'package:party_mobile/app/pages/login/widgets/facebook_login_button.dart';
import 'package:party_mobile/app/services/navigation_service.dart';
import 'package:party_mobile/app/shared/constants/route_names.dart';
import 'package:party_mobile/app/view_models/user_login_vm.dart';

import 'widgets/bezier_container.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _userLogin = UserLoginVM();
  final _loginController = locator<LoginController>();
  final _navigationService = locator<NavigationService>();
  final _formKey = GlobalKey<FormState>();

  // Widgets

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

  Widget _formInput(BoxConstraints constraints) {
    return Form(
      key: _formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        children: [
          TextFormField(
            textInputAction: TextInputAction.next,
            autocorrect: false,
            enableSuggestions: false,
            decoration: const InputDecoration(
              icon: Icon(Icons.person),
              labelText: 'Nome de usuário ou e-mail',
            ),
            validator: (value) {
              if (value.isEmpty) return "Campo obrigatório!";
              return null;
            },
            onChanged: (value) {
              _userLogin.login = value;
            },
          ),
          SizedBox(height: constraints.maxHeight * .015),
          TextFormField(
            obscureText: true,
            decoration: const InputDecoration(
              icon: Icon(Icons.lock),
              labelText: 'Senha',
            ),
            validator: (value) {
              if (value.isEmpty) return "Campo obrigatório!";
              return null;
            },
            onChanged: (value) {
              _userLogin.password = value;
            },
          ),
        ],
      ),
    );
  }

  Widget _loginButton(BoxConstraints constraints, BuildContext context) {
    var white = Colors.white;
    return RawMaterialButton(
      onPressed: () {
        if (_formKey.currentState.validate()) {
          _requestLoginWithEmail(context);
        }
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.symmetric(vertical: constraints.maxHeight * .007),
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
        child: Text(
          'Login',
          style: TextStyle(fontSize: 20, color: white),
        ),
      ),
    );
  }

  Widget _forgotPasswordButton(BoxConstraints constraints) {
    return Container(
      alignment: Alignment.centerRight,
      child: RawMaterialButton(
        onPressed: () {
          _navigationService.pushNamed(RouteNames.forgotPassword);
        },
        child: Text(
          'Esqueceu sua senha?',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  Widget _divider(BoxConstraints constraints) {
    return Container(
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

  Widget _signUpButton() {
    return RawMaterialButton(
      onPressed: () {
        _navigationService.pushNamed(RouteNames.signUp);
      },
      child: Container(
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

  // Functions

  void _requestLoginWithEmail(BuildContext context) {
    var result = _loginController.loginWithEmail(_userLogin);
    result.then(
      (value) => {
        value.fold(
          (l) => {
            Scaffold.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  l.message,
                  style: TextStyle(fontSize: 16),
                  textAlign: TextAlign.center,
                ),
                backgroundColor: Colors.red,
              ),
            )
          },
          (r) => null,
        )
      },
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
                        _formInput(constraints),
                        SizedBox(height: constraints.maxHeight * .025),
                        _loginButton(constraints, context),
                        _forgotPasswordButton(constraints),
                        _divider(constraints),
                        SizedBox(height: constraints.maxHeight * .015),
                        FacebookLoginButton(_loginController, constraints),
                        _signUpButton(),
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
