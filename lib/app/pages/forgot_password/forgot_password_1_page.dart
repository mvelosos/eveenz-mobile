import 'package:flutter/material.dart';
import 'package:party_mobile/app/controllers/passwords_controller.dart';
import 'package:party_mobile/app/locator.dart';
import 'package:party_mobile/app/pages/forgot_password/forgot_password_2_page.dart';
import 'package:party_mobile/app/services/navigation_service.dart';
import 'package:party_mobile/app/shared/constants/app_colors.dart';
import 'package:party_mobile/app/shared/constants/route_names.dart';
import 'package:party_mobile/app/view_models/password_forgot_email_vm.dart';

class ForgotPassword1Page extends StatefulWidget {
  @override
  _ForgotPassword1PageState createState() => _ForgotPassword1PageState();
}

class _ForgotPassword1PageState extends State<ForgotPassword1Page> {
  final _passwordsController = locator<PasswordsController>();
  final _passwordForgotEmail = PasswordForgotEmailVM();
  NavigationService _navigationService;
  bool _loading = false;

  // Fuctions

  void _setLoading(bool value) {
    setState(() {
      _loading = value;
    });
  }

  void _requestPasswordForgot(BuildContext context) async {
    _setLoading(true);
    var result =
        await _passwordsController.forgotPassword(_passwordForgotEmail);
    result.fold(
        (l) => {
              Scaffold.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    l.message,
                    style: TextStyle(fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                  backgroundColor: AppColors.snackWarning,
                  behavior: SnackBarBehavior.floating,
                  duration: Duration(seconds: 2),
                ),
              )
            },
        (r) => {
              _navigationService.pushNamed(RouteNames.forgotPassword2,
                  arguments: ForgotPasswordPage2Arguments(email: r['email']))
            });
    _setLoading(false);
  }

  // Widgets

  @override
  Widget build(BuildContext context) {
    _navigationService = NavigationService.currentNavigator(context);
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
                        onChanged: (value) {
                          _passwordForgotEmail.email = value;
                        },
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
                        onPressed: () {
                          return _loading
                              ? null
                              : _requestPasswordForgot(context);
                        },
                        child: _loading
                            ? SizedBox(
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                      Colors.white),
                                ),
                                height: 13,
                                width: 13,
                              )
                            : Text('Esqueci minha senha'),
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
