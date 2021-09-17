import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:party_mobile/app/pages/settings/widgets/settings_list_tile.dart';
import 'package:party_mobile/app/pages/settings/widgets/sign_out_list_tile.dart';
import 'package:party_mobile/app/shared/constants/app_colors.dart';
import 'package:party_mobile/app/shared/constants/route_names.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Configurações',
          style: TextStyle(color: AppColors.darkPurple, fontSize: 17),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        shadowColor: Colors.transparent,
        brightness: Brightness.light,
        iconTheme: IconThemeData(color: AppColors.orange),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(
            left: _size.width * .06,
            right: _size.width * .06,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 15),
              Text(
                'CONTA',
                style: GoogleFonts.poppins(
                  color: AppColors.darkPurple,
                  fontSize: 13,
                ),
              ),
              SettingsListTile(
                'Perfil',
                FontAwesomeIcons.user,
                FontAwesomeIcons.chevronRight,
                RouteNames.profileSettings,
              ),
              SettingsListTile(
                'Privacidade',
                FontAwesomeIcons.lock,
                FontAwesomeIcons.chevronRight,
                RouteNames.privacySettings,
              ),
              // SettingsListTile(
              //   'Senha',
              //   FontAwesomeIcons.key,
              //   FontAwesomeIcons.chevronRight,
              //   _navigationService,
              //   '',
              // ),
              Divider(),
              SignOutListTile(),
            ],
          ),
        ),
      ),
    );
  }
}
