import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:party_mobile/app/controllers/login_controller.dart';
import 'package:party_mobile/app/locator.dart';
import 'package:party_mobile/app/pages/login/widgets/apple_login_button.dart';
import 'package:party_mobile/app/pages/login/widgets/login_bezier_container.dart';
import 'package:party_mobile/app/pages/login/widgets/facebook_login_button.dart';
import 'package:party_mobile/app/pages/login/widgets/google_login_button.dart';
import 'package:party_mobile/app/services/navigation_service.dart';
import 'package:party_mobile/app/shared/constants/app_colors.dart';
import 'package:party_mobile/app/shared/constants/route_names.dart';
import 'package:party_mobile/app/shared/widgets/loading_indicator.dart';
import 'package:party_mobile/app/view_models/user_login_vm.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _userLogin = UserLoginVM();
  final _loginController = locator<LoginController>();
  final _formKey = GlobalKey<FormState>();
  NavigationService _navigationService;
  bool _loading = false;

  // Functions

  _setLoading(value) {
    setState(() {
      _loading = value;
    });
  }

  void _requestLoginWithEmail(BuildContext context) {
    _setLoading(true);
    var result = _loginController.loginWithEmail(_userLogin);
    result
        .then(
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
              (r) => {
                _navigationService
                    .pushReplacementNamedNoAnimation(RouteNames.appContainer)
              },
            ),
          },
        )
        .whenComplete(() => {_setLoading(false)});
  }

  // Widgets

  Widget _subtitle(BoxConstraints constraints) {
    return Text(
      'viva momentos incríveis',
      style: GoogleFonts.poppins(
        fontSize: constraints.maxHeight * .016,
        fontWeight: FontWeight.w400,
        color: AppColors.darkPurple,
      ),
    );
  }

  Widget _formInput(BoxConstraints constraints) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            textInputAction: TextInputAction.next,
            autocorrect: false,
            enableSuggestions: false,
            decoration: InputDecoration(
              icon: FaIcon(
                FontAwesomeIcons.userAlt,
                color: AppColors.darkPurple,
                size: 17,
              ),
              labelText: 'Nome de usuário ou e-mail',
              labelStyle: TextStyle(color: AppColors.darkPurple),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: AppColors.orange),
              ),
            ),
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (value) {
              if (value.isEmpty) return "Campo obrigatório!";
              return null;
            },
            onChanged: (value) {
              _userLogin.login = value;
            },
          ),
          SizedBox(height: constraints.maxHeight * .035),
          TextFormField(
            obscureText: true,
            decoration: InputDecoration(
              icon: FaIcon(
                FontAwesomeIcons.lock,
                color: AppColors.darkPurple,
                size: 17,
              ),
              labelText: 'Senha',
              labelStyle: TextStyle(color: AppColors.darkPurple),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: AppColors.orange),
              ),
            ),
            autovalidateMode: AutovalidateMode.onUserInteraction,
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
          FocusScope.of(context).unfocus();
        }
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.symmetric(vertical: size.height * .007),
        padding: EdgeInsets.symmetric(vertical: size.height * .024),
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
          color: AppColors.orange,
        ),
        child: Text(
          'ENTRAR',
          style: GoogleFonts.roboto(
            fontSize: size.height * .015,
            color: Colors.white,
            letterSpacing: 4,
          ),
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

  Widget _signUpButton(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return RawMaterialButton(
      onPressed: () {
        _navigationService.pushNamed(RouteNames.signUp1);
      },
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          style: GoogleFonts.inter(
            color: AppColors.gray1,
            fontSize: size.height * .015,
            fontWeight: FontWeight.w700,
          ),
          children: <TextSpan>[
            TextSpan(text: 'Não tem uma conta? '),
            TextSpan(
              text: 'Cadastre-se',
              style: TextStyle(
                color: AppColors.purple,
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
                    children: [
                      LoginBezierContainer(),
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
                              SizedBox(height: constraints.maxHeight * .01),
                              _subtitle(constraints),
                              SizedBox(height: constraints.maxHeight * .11),
                              _formInput(constraints),
                              SizedBox(height: size.height * .005),
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
                                    _setLoading,
                                    _navigationService,
                                  ),
                                  GoogleLoginButton(_loginController),
                                  Platform.isIOS
                                      ? AppleLoginButton(_loginController)
                                      : SizedBox.shrink(),
                                ],
                              ),
                              SizedBox(height: size.height * .015),
                              _signUpButton(context),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              _loading ? LoadingIndicator() : SizedBox.shrink()
            ],
          );
        },
      ),
    );
  }
}
