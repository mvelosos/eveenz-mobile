import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:party_mobile/app/services/navigation_service.dart';
import 'package:party_mobile/app/shared/constants/app_colors.dart';

class SettingsListTile extends StatelessWidget {
  final String _title;
  final IconData _leadingIcon;
  final IconData _trailingIcon;
  final NavigationService _navigationService;
  final String _routeName;

  SettingsListTile(this._title, this._leadingIcon, this._trailingIcon,
      this._navigationService, this._routeName);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.only(left: 2),
      leading: Padding(
        padding: EdgeInsets.only(top: 4),
        child: FaIcon(
          _leadingIcon,
          size: 15,
          color: AppColors.orange,
        ),
      ),
      trailing: FaIcon(
        _trailingIcon,
        size: 15,
        color: AppColors.orange,
      ),
      title: Text(_title, style: GoogleFonts.poppins(fontSize: 14)),
      onTap: () => {
        _navigationService.pushNamed(_routeName),
      },
    );
  }
}
