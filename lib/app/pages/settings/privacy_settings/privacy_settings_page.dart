import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:party_mobile/app/controllers/profile_controller.dart';
import 'package:party_mobile/app/locator.dart';
import 'package:party_mobile/app/shared/constants/app_colors.dart';
import 'package:party_mobile/app/stores/profile_store.dart';
import 'package:party_mobile/app/view_models/me_profile_vm.dart';

class PrivacySettingsPage extends StatefulWidget {
  final ProfileStore _profileStore = locator<ProfileStore>();
  final MeProfileVM _meProfileVM = MeProfileVM();
  final ProfileController _profileController = locator<ProfileController>();

  @override
  _PrivacySettingsPageState createState() => _PrivacySettingsPageState();
}

class _PrivacySettingsPageState extends State<PrivacySettingsPage> {
  late bool accountPrivacy;

  @override
  void initState() {
    super.initState();
    accountPrivacy = widget._profileStore.accountSetting['private'];
  }

  _updateProfilePrivacy(bool value) async {
    setState(() {
      accountPrivacy = value;
    });
    widget._meProfileVM.private = value;
    await widget._profileController.updateProfile(widget._meProfileVM);
    widget._profileController.getProfile();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Privacidade',
          style: TextStyle(color: AppColors.darkPurple, fontSize: 17),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        shadowColor: Colors.transparent,
        brightness: Brightness.light,
        iconTheme: IconThemeData(color: AppColors.orange),
      ),
      body: ListView(
        children: [
          ListTile(
            title: Row(
              children: [
                Text('Conta privada '),
                Icon(Icons.lock, size: 17),
              ],
            ),
            subtitle: Text(
                'Apenas usuários que você aprovar podem te seguir e visualizar seu conteúdo'),
            trailing: CupertinoSwitch(
              value: accountPrivacy,
              onChanged: (value) {
                _updateProfilePrivacy(value);
              },
            ),
          ),
        ],
      ),
    );
  }
}
