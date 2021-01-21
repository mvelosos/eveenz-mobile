import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:party_mobile/app/controllers/login_controller.dart';
import 'package:party_mobile/app/locator.dart';
import 'package:party_mobile/app/pages/login/widgets/facebook_login_button.dart';
import 'package:party_mobile/app/services/navigation_service.dart';
import 'package:party_mobile/app/shared/constants/app_colors.dart';
import 'package:party_mobile/app/shared/constants/route_names.dart';
import 'package:party_mobile/app/shared/widgets/loading_indicator.dart';
import 'package:party_mobile/app/stores/login_store.dart';
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
  final _loginStore = locator<LoginStore>();
  NavigationService _navigationService;
  final _formKey = GlobalKey<FormState>();

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
                  style: TextStyle(fontSize: 14),
                  textAlign: TextAlign.center,
                ),
                backgroundColor: AppColors.snackWarning,
                behavior: SnackBarBehavior.floating,
              ),
            )
          },
          (r) => null,
        )
      },
    );
  }

  // Widgets

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
            decoration: InputDecoration(
              icon: Icon(
                Icons.person,
                color: AppColors.purple,
              ),
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
          SizedBox(height: constraints.maxHeight * .04),
          TextFormField(
            obscureText: true,
            decoration: InputDecoration(
              icon: Icon(
                Icons.lock,
                color: AppColors.purple,
              ),
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
    Size size = MediaQuery.of(context).size;

    return RawMaterialButton(
      onPressed: () {
        if (_formKey.currentState.validate()) {
          _requestLoginWithEmail(context);
        }
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.symmetric(vertical: size.height * .007),
        padding: EdgeInsets.symmetric(vertical: size.height * .018),
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
              AppColors.orange,
            ],
          ),
        ),
        child: Text(
          'Entrar',
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
      ),
    );
  }

  Widget _forgotPasswordButton(BoxConstraints constraints) {
    return Container(
      alignment: Alignment.centerRight,
      child: RawMaterialButton(
        onPressed: () {
          _navigationService.pushNamed(RouteNames.forgotPassword1);
        },
        child: Text(
          'Esqueci minha senha',
          style: TextStyle(
            color: AppColors.gray1,
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
            SizedBox(width: 5),
            Text(
              'Cadastre-se',
              style: TextStyle(
                color: AppColors.purple,
                fontSize: 13,
                fontWeight: FontWeight.w800,
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
    _navigationService = NavigationService.currentNavigator(context);
    Size size = MediaQuery.of(context).size;

    return Scaffold(
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
                  child: Stack(
                    children: <Widget>[
                      BezierContainer(),
                      Container(
                        padding: EdgeInsets.only(
                          left: size.width * .08,
                          right: size.width * .08,
                        ),
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              SizedBox(height: constraints.maxHeight * .1),
                              Image(
                                image: AssetImage('assets/images/logo.png'),
                                height: constraints.maxHeight * .13,
                              ),
                              SizedBox(height: constraints.maxHeight * .15),
                              _formInput(constraints),
                              SizedBox(height: size.height * .01),
                              _forgotPasswordButton(constraints),
                              SizedBox(height: size.height * .03),
                              _loginButton(constraints, context),
                              SizedBox(height: size.height * .02),
                              _divider(constraints),
                              SizedBox(height: constraints.maxHeight * .03),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  FacebookLoginButton(
                                    _loginController,
                                    _loginStore,
                                  ),
                                  FacebookLoginButton(
                                    _loginController,
                                    _loginStore,
                                  ),
                                  FacebookLoginButton(
                                    _loginController,
                                    _loginStore,
                                  ),
                                ],
                              ),
                              SizedBox(height: size.height * .015),
                              _signUpButton(),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Observer(
                builder: (_) => _loginStore.loading
                    ? LoadingIndicator(constraints)
                    : SizedBox.shrink(),
              ),
            ],
          );
        },
      ),
    );
  }
}
