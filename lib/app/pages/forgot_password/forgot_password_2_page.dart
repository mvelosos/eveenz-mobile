import 'package:flutter/material.dart';
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
  TextEditingController _textEditingController = TextEditingController();
  PasswordRecoveryVM _passwordRecovery = PasswordRecoveryVM();

  @override
  Widget build(BuildContext context) {
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
                  PinCodeTextField(
                    backgroundColor: Colors.transparent,
                    appContext: context,
                    onChanged: (value) {},
                    length: 6,
                    controller: _textEditingController,
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
