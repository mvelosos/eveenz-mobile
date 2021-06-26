import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:party_mobile/app/shared/constants/app_colors.dart';

class PrivacySettingsPage extends StatelessWidget {
  const PrivacySettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Privacidade',
          style: TextStyle(color: AppColors.darkPurple, fontSize: 17),
        ),
        backgroundColor: Colors.white,
        shadowColor: Colors.transparent,
        brightness: Brightness.light,
        iconTheme: IconThemeData(color: AppColors.orange),
      ),
      body: ListView(
        children: [
          ListTile(
            title: Text('Conta privada'),
            subtitle: Text(
                'Apenas usuários que você aprovar podem te seguir e ter acesso ao seu conteúdo'),
            trailing: CupertinoSwitch(
              value: false,
              onChanged: (value) {},
            ),
          ),
        ],
      ),
    );
  }
}
