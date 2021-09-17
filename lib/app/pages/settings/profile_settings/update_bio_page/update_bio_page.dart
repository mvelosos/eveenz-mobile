import 'package:flutter/material.dart';
import 'package:party_mobile/app/controllers/profile_controller.dart';
import 'package:party_mobile/app/locator.dart';
import 'package:party_mobile/app/services/navigation_service.dart';
import 'package:party_mobile/app/shared/constants/app_colors.dart';
import 'package:party_mobile/app/stores/profile_store.dart';
import 'package:party_mobile/app/view_models/me_profile_vm.dart';

class UpdateBioPage extends StatefulWidget {
  @override
  _UpdateBioPageState createState() => _UpdateBioPageState();
}

class _UpdateBioPageState extends State<UpdateBioPage> {
  final ProfileController _profileController = locator<ProfileController>();
  final ProfileStore _profileStore = locator<ProfileStore>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final MeProfileVM _profile = MeProfileVM();
  final TextEditingController _bioInputController = TextEditingController();
  NavigationService? _navigationService;
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    _profile.bio = _profileStore.bio.value;
    _bioInputController.text = _profileStore.bio.value;
  }

  void _setLoading(bool value) {
    setState(() {
      _loading = value;
    });
  }

  void _requestUpdateBio() async {
    if (_formKey.currentState!.validate()) {
      _setLoading(true);
      var result = await _profileController.updateProfile(_profile);
      _setLoading(false);
      result.fold(
        (l) => {},
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
          'Bio',
          style: TextStyle(color: AppColors.darkPurple, fontSize: 17),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        shadowColor: Colors.transparent,
        brightness: Brightness.light,
        iconTheme: IconThemeData(color: AppColors.orange),
        actions: [
          TextButton(
            onPressed: _loading ? null : () => _requestUpdateBio(),
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
                controller: _bioInputController,
                decoration: InputDecoration(
                  labelText: 'Bio',
                  labelStyle: TextStyle(color: AppColors.darkPurple),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: AppColors.orange),
                  ),
                ),
                maxLines: 3,
                maxLength: 150,
                onChanged: (value) {
                  _profile.bio = value;
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
