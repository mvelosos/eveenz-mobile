import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:party_mobile/app/shared/constants/app_colors.dart';

class ProfileSocialTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.profileTabViewContainer,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 15),
              child: FaIcon(
                FontAwesomeIcons.commentAlt,
                size: 40,
                color: AppColors.gray4,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30, right: 30),
              child: Text(
                'Nenhuma publicação a ser mostrada',
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: AppColors.gray4,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
