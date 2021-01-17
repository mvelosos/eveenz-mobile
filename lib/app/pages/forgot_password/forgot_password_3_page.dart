import 'package:flutter/material.dart';
import 'package:party_mobile/app/controllers/passwords_controller.dart';
import 'package:party_mobile/app/locator.dart';
import 'package:party_mobile/app/services/navigation_service.dart';
import 'package:party_mobile/app/shared/constants/app_colors.dart';
import 'package:party_mobile/app/shared/constants/route_names.dart';
import 'package:party_mobile/app/view_models/password_recovery_vm.dart';

// Page Arguments
class ForgotPasswordPage3Arguments {
  final String token;

  ForgotPasswordPage3Arguments({@required this.token});
}

// Page
class ForgotPassword3Page extends StatefulWidget {
  final ForgotPasswordPage3Arguments args;

  ForgotPassword3Page({@required this.args});

  @override
  _ForgotPassword3PageState createState() => _ForgotPassword3PageState();
}

class _ForgotPassword3PageState extends State<ForgotPassword3Page> {
  NavigationService _navigationService;
  final _passwordsController = locator<PasswordsController>();
  PasswordRecoveryVM _passwordRecovery = PasswordRecoveryVM();
  final _formKey = GlobalKey<FormState>();
  bool _loading = false;

  //Function

  @override
  void initState() {
    super.initState();
    _passwordRecovery.token = widget.args.token;
  }

  _setLoading(value) {
    setState(() {
      _loading = value;
    });
  }

  _requestPasswordRecover(BuildContext context) async {
    _setLoading(true);
    var result = await _passwordsController.recoverPassword(_passwordRecovery);
    result.fold(
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
                  duration: Duration(seconds: 2),
                ),
              )
            },
        (r) => {
              _navigationService.pushReplacementNamed(
                RouteNames.forgotPassword4,
              )
            });
    _setLoading(false);
  }

  // Widgets

  @override
  Widget build(BuildContext context) {
    _navigationService = NavigationService.currentNavigator(context);
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Forgot Password 3',
          style: TextStyle(color: Colors.blue),
        ),
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        iconTheme: IconThemeData(color: Colors.blue),
        brightness: Brightness.light,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: Container(
              height: constraints.maxHeight,
              padding: EdgeInsets.only(left: 10, right: 10),
              color: Colors.transparent,
              child: Form(
                key: _formKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Column(
                  children: [
                    SizedBox(
                      height: size.height * .07,
                    ),
                    TextFormField(
                      onChanged: (value) {
                        _passwordRecovery.password = value;
                      },
                      textInputAction: TextInputAction.next,
                      autocorrect: false,
                      enableSuggestions: false,
                      obscureText: true,
                      decoration: InputDecoration(
                        icon: Icon(Icons.lock),
                        labelText: 'Nova senha',
                      ),
                      validator: (value) {
                        if (value.isEmpty) return "Campo obrigatório!";
                        return null;
                      },
                    ),
                    SizedBox(
                      height: size.height * .02,
                    ),
                    TextFormField(
                      onChanged: (value) {
                        _passwordRecovery.passwordConfirmation = value;
                      },
                      autocorrect: false,
                      enableSuggestions: false,
                      obscureText: true,
                      decoration: InputDecoration(
                        icon: Icon(Icons.lock),
                        labelText: 'Confirmação da nova senha',
                      ),
                      validator: (value) {
                        if (value.isEmpty) return "Campo obrigatório!";
                        if (value != _passwordRecovery.password)
                          return "As senhas devem ser iguais";
                        return null;
                      },
                    ),
                    SizedBox(
                      height: size.height * .04,
                    ),
                    RaisedButton(
                      onPressed: () {
                        if (_formKey.currentState.validate()) {
                          _requestPasswordRecover(context);
                        }
                      },
                      child: _loading
                          ? SizedBox(
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                valueColor:
                                    AlwaysStoppedAnimation<Color>(Colors.white),
                              ),
                              height: 13,
                              width: 13,
                            )
                          : Text('Confirmar'),
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
