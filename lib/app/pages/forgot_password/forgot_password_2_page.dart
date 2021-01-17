import 'package:flutter/material.dart';
import 'package:party_mobile/app/controllers/passwords_controller.dart';
import 'package:party_mobile/app/locator.dart';
import 'package:party_mobile/app/pages/forgot_password/forgot_password_3_page.dart';
import 'package:party_mobile/app/services/navigation_service.dart';
import 'package:party_mobile/app/shared/constants/app_colors.dart';
import 'package:party_mobile/app/shared/constants/route_names.dart';
import 'package:party_mobile/app/view_models/password_recovery_vm.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

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
  final _passwordsController = locator<PasswordsController>();
  NavigationService _navigationService;
  PasswordRecoveryVM _passwordRecovery = PasswordRecoveryVM();
  bool _loading = false;

  // Functions

  _setLoading(value) {
    setState(() {
      _loading = value;
    });
  }

  _requestVerifyCode(BuildContext context) async {
    _setLoading(true);
    var result = await _passwordsController.verifyCode(_passwordRecovery);
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
              _navigationService.pushNamed(RouteNames.forgotPassword3,
                  arguments: ForgotPasswordPage3Arguments(token: r['token']))
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
          'Forgot Password 2',
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
              child: Column(
                children: [
                  SizedBox(
                    height: size.height * .03,
                  ),
                  Text(
                    'Um e-mail foi enviado para ${widget.args.email} com seu código de recuperação',
                    style: TextStyle(fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: size.height * .1,
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 10, right: 10),
                    child: PinCodeTextField(
                      onChanged: (value) {
                        _passwordRecovery.code = value;
                      },
                      pastedTextStyle: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                      backgroundColor: Colors.transparent,
                      appContext: context,
                      length: 6,
                      // animationDuration: Duration(seconds: 0),
                      animationType: AnimationType.scale,
                      keyboardType: TextInputType.number,
                      pinTheme: PinTheme(
                        shape: PinCodeFieldShape.underline,
                        borderRadius: BorderRadius.circular(50),
                        fieldHeight: 50,
                        fieldWidth: 40,
                        inactiveColor: Colors.blue,
                        activeColor: Colors.blue,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: size.height * .07,
                  ),
                  RaisedButton(
                    onPressed: () {
                      return _loading ? null : _requestVerifyCode(context);
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
                        : Text('Continuar'),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
