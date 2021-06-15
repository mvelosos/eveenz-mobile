import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
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
  final _formKey = GlobalKey<FormState>();
  NavigationService? _navigationService;
  bool _loading = false;

  // Fuctions

  void _setLoading(bool value) {
    setState(() {
      _loading = value;
    });
  }

  void _requestPasswordForgot(BuildContext context) async {
    Size _size = MediaQuery.of(context).size;
    _setLoading(true);

    _passwordsController
        .forgotPassword(_passwordForgotEmail)
        .then((value) => {
              value.fold(
                (l) => {
                  print(l),
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        l.message!,
                        style: TextStyle(fontSize: _size.height * .018),
                        textAlign: TextAlign.center,
                      ),
                      backgroundColor: AppColors.snackWarning,
                      behavior: SnackBarBehavior.floating,
                      duration: Duration(seconds: 3),
                    ),
                  )
                },
                (r) => {
                  _navigationService?.pushNamed(
                    RouteNames.forgotPassword2,
                    arguments: ForgotPasswordPage2Arguments(email: r['email']),
                  )
                },
              )
            })
        .whenComplete(() => _setLoading(false));
  }

  // Widgets

  Widget _formInput(BuildContext context) {
    return Form(
      key: _formKey,
      child: TextFormField(
        onChanged: (value) {
          _passwordForgotEmail.login = value;
        },
        autocorrect: false,
        enableSuggestions: false,
        decoration: InputDecoration(
          labelText: 'Nome de usuário ou e-mail',
          labelStyle: TextStyle(color: AppColors.darkPurple),
          icon: FaIcon(
            FontAwesomeIcons.userAlt,
            color: AppColors.darkPurple,
            size: 17,
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: AppColors.orange),
          ),
        ),
        validator: (value) {
          if (value!.isEmpty) return "Campo obrigatório!";
          return null;
        },
      ),
    );
  }

  Widget _passwordForgotButton(BuildContext context) {
    final _size = MediaQuery.of(context).size;

    return RawMaterialButton(
      onPressed: () {
        if (_formKey.currentState!.validate()) {
          FocusScope.of(context).unfocus();
          return _loading ? null : _requestPasswordForgot(context);
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
                height: _size.height * .026,
                width: _size.height * .026,
              )
            : Text(
                'ENVIAR',
                style: GoogleFonts.roboto(
                  fontSize: _size.height * .015,
                  color: Colors.white,
                  letterSpacing: 4,
                ),
              ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    _navigationService = NavigationService.currentNavigator(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        iconTheme: IconThemeData(color: AppColors.orange),
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
                child: Stack(
                  children: [
                    Container(
                      height: constraints.maxHeight,
                      padding: EdgeInsets.only(
                        left: size.width * .08,
                        right: size.width * .08,
                      ),
                      color: Colors.transparent,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: size.height * .025),
                          Text(
                            'Esqueceu sua senha?',
                            style: GoogleFonts.inter(
                              fontSize: size.height * .030,
                              color: AppColors.darkPurple,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          SizedBox(height: size.height * .005),
                          Text(
                            'Insira seu nome de usuário ou e-mail para receber as instruções de alteração de senha',
                            style: GoogleFonts.poppins(
                              fontSize: size.height * .016,
                              color: AppColors.darkPurple,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          SizedBox(height: size.height * .1),
                          _formInput(context),
                          SizedBox(height: size.height * .1),
                          _passwordForgotButton(context)
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
