import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:party_mobile/app/services/sign_out_service.dart';
import 'package:party_mobile/app/shared/constants/app_colors.dart';

class SignOutListTile extends StatelessWidget {
  SignOutListTile();

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.only(left: 2),
      leading: Padding(
        padding: EdgeInsets.only(top: 4),
        child: FaIcon(
          FontAwesomeIcons.signOutAlt,
          size: 15,
          color: AppColors.gray1,
        ),
      ),
      title: Text('Sair', style: GoogleFonts.poppins(fontSize: 14)),
      onTap: () => {
        SignOutService.signOutUser(),
      },
    );
  }
}
