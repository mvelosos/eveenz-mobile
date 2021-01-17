import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:party_mobile/app/controllers/signup_controller.dart';
import 'package:party_mobile/app/locator.dart';
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
    final _size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Cadastre-se',
          style: TextStyle(color: Colors.blue),
        ),
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
                  padding: EdgeInsets.symmetric(
                    horizontal: constraints.maxWidth * .05,
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _formInput(context),
                        SizedBox(height: _size.height * .025),
                        _signUpButton(context),
                      ],
                    ),
                  ),
                ),
              ),
              Observer(
                builder: (_) => _signUpStore.loading
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
