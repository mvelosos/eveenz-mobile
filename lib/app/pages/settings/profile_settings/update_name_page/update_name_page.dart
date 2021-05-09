import 'package:flutter/material.dart';
import 'package:party_mobile/app/controllers/profile_controller.dart';
import 'package:party_mobile/app/locator.dart';
import 'package:party_mobile/app/services/navigation_service.dart';
import 'package:party_mobile/app/shared/constants/app_colors.dart';
import 'package:party_mobile/app/stores/profile_store.dart';
import 'package:party_mobile/app/view_models/me_profile_vm.dart';

class UpdateNamePage extends StatefulWidget {
  @override
  _UpdateNamePageState createState() => _UpdateNamePageState();
}

class _UpdateNamePageState extends State<UpdateNamePage> {
  final ProfileController _profileController = locator<ProfileController>();
  final ProfileStore _profileStore = locator<ProfileStore>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final MeProfileVM _profile = MeProfileVM();
  final TextEditingController _nameInputController = TextEditingController();
  NavigationService _navigationService;
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    _profile.name = _profileStore.name.value;
    _nameInputController.text = _profileStore.name.value;
  }

  void _setLoading(bool value) {
    setState(() {
      _loading = value;
    });
  }

  void _requestUpdateName() async {
    if (_formKey.currentState.validate()) {
      _setLoading(true);
      var result = await _profileController.updateProfile(_profile);
      _setLoading(false);
      result.fold(
        (l) => {print(l.message)},
        (r) async => {
          await _profileController.getProfile(),
          _navigationService.goBack(),
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
          'Nome',
          style: TextStyle(color: AppColors.darkPurple, fontSize: 17),
        ),
        backgroundColor: Colors.white,
        shadowColor: Colors.transparent,
        brightness: Brightness.light,
        iconTheme: IconThemeData(color: AppColors.orange),
        actions: [
          TextButton(
            onPressed: _loading ? null : () => _requestUpdateName(),
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
                controller: _nameInputController,
                decoration: InputDecoration(
                  labelText: 'Nome',
                  labelStyle: TextStyle(color: AppColors.darkPurple),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: AppColors.orange),
                  ),
                ),
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) {
                  if (value.isEmpty) return 'O nome não pode ficar em branco';
                  return null;
                },
                autocorrect: false,
                enableSuggestions: false,
                maxLength: 30,
                onChanged: (value) {
                  _profile.name = value.trim();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
