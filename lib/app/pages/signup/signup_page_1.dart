import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:party_mobile/app/controllers/signup_controller.dart';
import 'package:party_mobile/app/controllers/users_controller.dart';
import 'package:party_mobile/app/locator.dart';
import 'package:party_mobile/app/pages/signup/widgets/signup_bezier_container.dart';
import 'package:party_mobile/app/services/navigation_service.dart';
import 'package:party_mobile/app/shared/constants/app_colors.dart';
import 'package:party_mobile/app/shared/constants/route_names.dart';
import 'package:party_mobile/app/shared/utils/commons.dart';
import 'package:party_mobile/app/shared/widgets/loading_indicator.dart';
import 'package:party_mobile/app/view_models/create_user_vm.dart';

class SignUpPage1 extends StatefulWidget {
  @override
  _SignUpPage1State createState() => _SignUpPage1State();
}

class _SignUpPage1State extends State<SignUpPage1> {
  final _createUser = CreateUserVM();
  final _signUpController = locator<SignUpController>();
  final _usersController = locator<UsersController>();
  final _formKey = GlobalKey<FormState>();
  NavigationService _navigationService;
  bool _hidePassword = true;
  bool _usernameAvailable = false;
  bool _loading = false;

  // Functions

  _setLoading(value) {
    setState(() {
      _loading = value;
    });
  }

  void _checkUsernameAvailablity(String username) async {
    bool available = await _usersController.usernameAvailable(username);
    setState(() {
      _usernameAvailable = available;
    });
  }

  void _requestCreateUser(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    _setLoading(true);

    var result = _signUpController.createUser(_createUser);
    result
        .then(
          (value) => {
            value.fold(
              (l) => {
                Scaffold.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      l.message,
                      style: TextStyle(fontSize: _size.height * .018),
                      textAlign: TextAlign.center,
                    ),
                    backgroundColor: AppColors.snackWarning,
                    behavior: SnackBarBehavior.floating,
                  ),
                )
              },
              (r) => {
                _navigationService
                    .pushReplacementNamedNoAnimation(RouteNames.signUp2)
              },
            )
          },
        )
        .whenComplete(() => _setLoading(false));
  }

  // Widgets

  Widget _formInput(BuildContext context) {
    final _size = MediaQuery.of(context).size;

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
              labelText: 'Nome de usuário',
              labelStyle: TextStyle(color: AppColors.darkPurple),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: AppColors.orange),
              ),
              suffixIcon: _createUser.username.length >= 3
                  ? Icon(
                      _usernameAvailable ? Icons.check_circle : Icons.close,
                      color:
                          _usernameAvailable ? AppColors.green : AppColors.red,
                    )
                  : null,
            ),
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (value) {
              if (value.isEmpty) return "Campo obrigatório!";
              if (!Commons.matchUsernameRegex(value))
                return "Campo deve conter apenas letras, números, _ e .";
              if (value.length < 3) return "Mínimo de 3 caracteres";
              if (value.length > 25) return "Máximo de 25 caracteres";
              if (!_usernameAvailable) return "Nome de usuário indisponível";
              return null;
            },
            onChanged: (value) {
              setState(() {
                _createUser.username = value;
              });
              if (value.length >= 3) {
                _checkUsernameAvailablity(value);
              }
            },
          ),
          SizedBox(height: _size.height * .03),
          TextFormField(
            textInputAction: TextInputAction.next,
            autocorrect: false,
            enableSuggestions: false,
            decoration: InputDecoration(
              icon: FaIcon(
                FontAwesomeIcons.solidEnvelope,
                color: AppColors.darkPurple,
                size: 17,
              ),
              labelText: 'E-mail',
              labelStyle: TextStyle(color: AppColors.darkPurple),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: AppColors.orange),
              ),
            ),
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (value) {
              if (value.isEmpty) return "Campo obrigatório!";
              if (!Commons.matchEmailRegex(value))
                return "Insira um e-mail válido";
              return null;
            },
            onChanged: (value) {
              _createUser.email = value;
            },
          ),
          SizedBox(height: _size.height * .03),
          TextFormField(
            obscureText: _hidePassword,
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
              suffixIcon: IconButton(
                onPressed: () {
                  setState(() {
                    _hidePassword = !_hidePassword;
                  });
                },
                icon: Icon(
                  _hidePassword ? Icons.visibility_off : Icons.visibility,
                ),
                color: AppColors.purple,
              ),
            ),
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (value) {
              if (value.isEmpty) return "Campo obrigatório!";
              return null;
            },
            onChanged: (value) {
              _createUser.password = value;
            },
          ),
        ],
      ),
    );
  }

  Widget _privacyPolicy(Size size) {
    return RichText(
      textAlign: TextAlign.start,
      text: TextSpan(
        style: TextStyle(
          color: AppColors.gray1,
          fontSize: size.height * .013,
          fontWeight: FontWeight.w300,
        ),
        children: <TextSpan>[
          TextSpan(
            text: 'Ao criar sua conta você concorda com nossos ',
            style: GoogleFonts.poppins(),
          ),
          TextSpan(
            text: 'Termos de Uso e Políticas de Privacidade',
            style: GoogleFonts.poppins(
              color: AppColors.orange,
            ),
          ),
        ],
      ),
    );
  }

  Widget _signUpButton(BuildContext context) {
    final _size = MediaQuery.of(context).size;

    return RawMaterialButton(
      onPressed: () {
        if (_formKey.currentState.validate()) {
          _requestCreateUser(context);
        }
      },
      child: Container(
        width: _size.width,
        margin: EdgeInsets.symmetric(vertical: _size.height * .007),
        padding: EdgeInsets.symmetric(vertical: _size.height * .018),
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
          'Cadastrar',
          style: TextStyle(fontSize: _size.height * .022, color: Colors.white),
        ),
      ),
    );
  }

  Widget _backToLogin(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return RawMaterialButton(
      onPressed: () {
        _navigationService.goBack();
      },
      child: Center(
        child: RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            style: GoogleFonts.inter(
              color: AppColors.gray1,
              fontSize: size.height * .015,
              fontWeight: FontWeight.w700,
            ),
            children: <TextSpan>[
              TextSpan(text: 'Já é cadastrado? '),
              TextSpan(
                text: 'Faça login',
                style: TextStyle(
                  color: AppColors.purple,
                ),
              ),
            ],
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
        backgroundColor: _loading
            ? Color(0xFF000000).withOpacity(.3)
            : Color(0xFFC4C4C4).withOpacity(.15),
        shadowColor: Colors.transparent,
        iconTheme: IconThemeData(color: AppColors.orange),
        brightness: Brightness.light,
        automaticallyImplyLeading: !_loading,
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
                  child: Stack(
                    children: [
                      SignUpBezierContainer(),
                      Container(
                        padding: EdgeInsets.only(
                          left: size.width * .08,
                          right: size.width * .08,
                        ),
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: size.height * .02),
                              Text(
                                'Cadastre-se',
                                style: GoogleFonts.inter(
                                  fontSize: size.height * .035,
                                  color: AppColors.darkPurple,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                              SizedBox(height: size.height * .005),
                              Text(
                                'É rápido e grátis',
                                style: GoogleFonts.poppins(
                                  fontSize: size.height * .016,
                                  color: AppColors.darkPurple,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                              SizedBox(height: size.height * .12),
                              _formInput(context),
                              SizedBox(height: size.height * .03),
                              _privacyPolicy(size),
                              SizedBox(height: size.height * .04),
                              _signUpButton(context),
                              SizedBox(height: size.height * .03),
                              _backToLogin(context)
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              _loading ? LoadingIndicator() : SizedBox.shrink(),
            ],
          );
        },
      ),
    );
  }
}
