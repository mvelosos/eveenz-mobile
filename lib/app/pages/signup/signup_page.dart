import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:party_mobile/app/controllers/signup_controller.dart';
import 'package:party_mobile/app/locator.dart';
import 'package:party_mobile/app/pages/signup/widgets/signup_bezier_container.dart';
import 'package:party_mobile/app/shared/constants/app_colors.dart';
import 'package:party_mobile/app/shared/widgets/loading_indicator.dart';
import 'package:party_mobile/app/stores/signup_store.dart';
import 'package:party_mobile/app/view_models/create_user_vm.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _createUser = CreateUserVM();
  final _signUpStore = locator<SignUpStore>();
  final _signUpController = locator<SignUpController>();
  final _formKey = GlobalKey<FormState>();

  // Functions

  void _requestCreateUser(BuildContext context) {
    var result = _signUpController.createUser(_createUser);
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
                backgroundColor: AppColors.snackWarning,
              ),
            )
          },
          (r) => null,
        )
      },
    );
  }

  // Widgets

  Widget _formInput(BuildContext context) {
    final _size = MediaQuery.of(context).size;

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
              icon: Icon(Icons.person),
              labelText: 'Nome de usuário',
            ),
            validator: (value) {
              if (value.isEmpty) return "Campo obrigatório!";
              return null;
            },
            onChanged: (value) {
              _createUser.username = value;
            },
          ),
          SizedBox(height: _size.height * .015),
          TextFormField(
            textInputAction: TextInputAction.next,
            autocorrect: false,
            enableSuggestions: false,
            decoration: InputDecoration(
              icon: Icon(Icons.email),
              labelText: 'E-mail',
            ),
            validator: (value) {
              if (value.isEmpty) return "Campo obrigatório!";
              return null;
            },
            onChanged: (value) {
              _createUser.email = value;
            },
          ),
          SizedBox(height: _size.height * .015),
          TextFormField(
            obscureText: true,
            decoration: InputDecoration(
              icon: Icon(Icons.lock),
              labelText: 'Senha',
            ),
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
        padding: EdgeInsets.symmetric(vertical: _size.height * .017),
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
          'Cadastrar',
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFC4C4C4).withOpacity(.15),
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
                                    fontSize: 31,
                                    color: AppColors.darkPurple,
                                    fontWeight: FontWeight.w800),
                              ),
                              SizedBox(height: size.height * .005),
                              Text(
                                'É rápido e grátis',
                                style: GoogleFonts.poppins(
                                    fontSize: 14,
                                    color: AppColors.darkPurple,
                                    fontWeight: FontWeight.normal),
                              ),
                              SizedBox(height: size.height * .1),
                              _formInput(context),
                              SizedBox(height: size.height * .025),
                              _signUpButton(context),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Observer(
                builder: (_) => _signUpStore.loading
                    ? LoadingIndicator()
                    : SizedBox.shrink(),
              ),
            ],
          );
        },
      ),
    );
  }
}
