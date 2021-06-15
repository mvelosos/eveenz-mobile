import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:party_mobile/app/controllers/passwords_controller.dart';
import 'package:party_mobile/app/locator.dart';
import 'package:party_mobile/app/services/navigation_service.dart';
import 'package:party_mobile/app/shared/constants/app_colors.dart';
import 'package:party_mobile/app/shared/constants/route_names.dart';
import 'package:party_mobile/app/view_models/password_recovery_vm.dart';

// Page Arguments
class ForgotPasswordPage3Arguments {
  final String token;

  ForgotPasswordPage3Arguments({required this.token});
}

// Page
class ForgotPassword3Page extends StatefulWidget {
  final ForgotPasswordPage3Arguments args;

  ForgotPassword3Page({required this.args});

  @override
  _ForgotPassword3PageState createState() => _ForgotPassword3PageState();
}

class _ForgotPassword3PageState extends State<ForgotPassword3Page> {
  final _passwordsController = locator<PasswordsController>();
  final _formKey = GlobalKey<FormState>();
  NavigationService? _navigationService;
  PasswordRecoveryVM _passwordRecovery = PasswordRecoveryVM();
  bool _loading = false;
  bool _hidePassword = true;
  bool _hidePasswordConfirmation = true;

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
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              l.message!,
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
        _navigationService?.pushReplacementNamed(
          RouteNames.forgotPassword4,
        )
      },
    );
    _setLoading(false);
  }

  // Widgets

  _formInput(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            onChanged: (value) {
              _passwordRecovery.password = value;
            },
            textInputAction: TextInputAction.next,
            autocorrect: false,
            enableSuggestions: false,
            obscureText: _hidePassword,
            decoration: InputDecoration(
              icon: FaIcon(
                FontAwesomeIcons.lock,
                color: AppColors.darkPurple,
                size: 17,
              ),
              labelText: 'Nova senha',
              labelStyle: TextStyle(color: AppColors.darkPurple),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: AppColors.orange),
              ),
              suffixIcon: IconButton(
                onPressed: () {
                  setState(() {
                    _hidePassword = !_hidePassword;
                  });
                },
                icon: Icon(
                  _hidePassword ? Icons.visibility_off : Icons.visibility,
                ),
                color: Colors.grey,
              ),
            ),
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (value) {
              if (value!.isEmpty) return "Campo obrigatório!";
              if (value.length < 6)
                return "Senha deve ter no mínimo 6 caracteres";
              return null;
            },
          ),
          SizedBox(
            height: size.height * .03,
          ),
          TextFormField(
            onChanged: (value) {
              _passwordRecovery.passwordConfirmation = value;
            },
            autocorrect: false,
            enableSuggestions: false,
            obscureText: _hidePasswordConfirmation,
            decoration: InputDecoration(
              icon: FaIcon(
                FontAwesomeIcons.lock,
                color: AppColors.darkPurple,
                size: 17,
              ),
              labelText: 'Confirmação da nova senha',
              labelStyle: TextStyle(color: AppColors.darkPurple),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: AppColors.orange),
              ),
              suffixIcon: IconButton(
                onPressed: () {
                  setState(() {
                    _hidePasswordConfirmation = !_hidePasswordConfirmation;
                  });
                },
                icon: Icon(
                  _hidePasswordConfirmation
                      ? Icons.visibility_off
                      : Icons.visibility,
                ),
                color: Colors.grey,
              ),
            ),
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (value) {
              if (value!.isEmpty) return "Campo obrigatório!";
              if (value != _passwordRecovery.password)
                return "As senhas devem ser iguais";
              return null;
            },
          ),
        ],
      ),
    );
  }

  Widget _submitButton(BuildContext context) {
    final _size = MediaQuery.of(context).size;

    return RawMaterialButton(
      onPressed: () {
        if (_formKey.currentState!.validate()) {
          _requestPasswordRecover(context);
        }
      },
      child: Container(
        width: _size.width,
        margin: EdgeInsets.symmetric(vertical: _size.height * .007),
        padding: EdgeInsets.symmetric(vertical: _size.height * .024),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(5)),
          color: _loading ? Colors.grey[400] : AppColors.orange,
        ),
        child: _loading
            ? SizedBox(
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
                height: _size.height * .019,
                width: _size.height * .019,
              )
            : Text(
                'ALTERAR SENHA',
                style: GoogleFonts.roboto(
                    fontSize: _size.height * .015,
                    color: Colors.white,
                    letterSpacing: 4),
              ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    _navigationService = NavigationService.currentNavigator(context);
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        iconTheme: IconThemeData(color: AppColors.orange),
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
              padding: EdgeInsets.only(
                left: size.width * .08,
                right: size.width * .08,
              ),
              color: Colors.transparent,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: size.height * .025),
                    Text(
                      'Nova senha',
                      style: GoogleFonts.inter(
                        fontSize: size.height * .04,
                        color: AppColors.darkPurple,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    SizedBox(height: size.height * .005),
                    Text(
                      'Preencha abaixo com a sua nova senha',
                      style: GoogleFonts.poppins(
                        fontSize: size.height * .016,
                        color: AppColors.darkPurple,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    SizedBox(height: size.height * .06),
                    _formInput(context),
                    SizedBox(
                      height: size.height * .08,
                    ),
                    _submitButton(context)
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
