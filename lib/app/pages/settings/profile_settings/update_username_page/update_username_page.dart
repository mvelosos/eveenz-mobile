import 'package:flutter/material.dart';
import 'package:party_mobile/app/controllers/profile_controller.dart';
import 'package:party_mobile/app/controllers/users_controller.dart';
import 'package:party_mobile/app/locator.dart';
import 'package:party_mobile/app/services/navigation_service.dart';
import 'package:party_mobile/app/shared/constants/app_colors.dart';
import 'package:party_mobile/app/shared/utils/commons.dart';
import 'package:party_mobile/app/stores/profile_store.dart';
import 'package:party_mobile/app/view_models/me_profile_vm.dart';

class UpdateUsernamePage extends StatefulWidget {
  @override
  _UpdateUsernamePageState createState() => _UpdateUsernamePageState();
}

class _UpdateUsernamePageState extends State<UpdateUsernamePage> {
  final ProfileController _profileController = locator<ProfileController>();
  final UsersController _usersController = locator<UsersController>();
  final ProfileStore _profileStore = locator<ProfileStore>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final MeProfileVM _profile = MeProfileVM();
  final TextEditingController _usernameInputController =
      TextEditingController();
  NavigationService? _navigationService;
  bool _usernameAvailable = false;
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    _profile.username = _profileStore.username.value;
    _usernameInputController.text = _profileStore.username.value;
  }

  void _setLoading(bool value) {
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

  void _requestUpdateUsername() async {
    if (_formKey.currentState!.validate()) {
      _setLoading(true);
      var result = await _profileController.updateProfile(_profile);
      _setLoading(false);
      result.fold(
        (l) => {print(l.message)},
        (r) async => {
          await _profileController.getProfile(),
          _navigationService!.goBack(),
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    _navigationService = NavigationService.currentNavigator(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Nome de usuário',
          style: TextStyle(color: AppColors.darkPurple, fontSize: 17),
        ),
        backgroundColor: Colors.white,
        shadowColor: Colors.transparent,
        brightness: Brightness.light,
        iconTheme: IconThemeData(color: AppColors.orange),
        actions: [
          TextButton(
            onPressed: _loading ? null : () => _requestUpdateUsername(),
            child: Text('Salvar'),
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.only(
          left: _size.width * .06,
          right: _size.width * .06,
        ),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                autofocus: true,
                controller: _usernameInputController,
                decoration: InputDecoration(
                  labelText: 'Nome de usuário',
                  labelStyle: TextStyle(color: AppColors.darkPurple),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: AppColors.orange),
                  ),
                  suffixIcon: _profile.username!.length >= 3
                      ? Icon(
                          _usernameAvailable ? Icons.check_circle : Icons.close,
                          color: _usernameAvailable
                              ? AppColors.green
                              : AppColors.red,
                        )
                      : null,
                ),
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) {
                  if (value!.isEmpty) return "Campo obrigatório!";
                  if (!Commons.matchUsernameRegex(value))
                    return "Campo deve conter apenas letras, números, _ e .";
                  if (value.length < 3) return "Mínimo de 3 caracteres";
                  if (value.length > 25) return "Máximo de 25 caracteres";
                  if (!_usernameAvailable)
                    return "Nome de usuário indisponível";
                  return null;
                },
                autocorrect: false,
                enableSuggestions: false,
                maxLength: 30,
                onChanged: (value) {
                  setState(() {
                    _profile.username = value.trim();
                  });
                  if (value.length >= 3) {
                    _checkUsernameAvailablity(value);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
