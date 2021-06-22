import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:party_mobile/app/shared/constants/app_colors.dart';

class ProfilePopularityBadge extends StatelessWidget {
  final int? popularity;

  ProfilePopularityBadge(this.popularity);

  String _formattedPopularity() {
    var numberFormat = NumberFormat('0,000', 'pt_BR');
    return numberFormat.format(popularity).toString();
  }

  @override
  Widget build(BuildContext context) {
    return (popularity != null && popularity != 0)
        ? Container(
            // width: 120,
            padding: EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 7,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(.3),
                  spreadRadius: 2,
                  blurRadius: 10,
                  offset: Offset(0, 2), // changes position of shadow
                ),
              ],
            ),
            child: IntrinsicWidth(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FaIcon(
                    FontAwesomeIcons.trophy,
                    size: 15,
                    color: AppColors.yellowGold,
                  ),
                  SizedBox(width: 7),
                  Text(
                    _formattedPopularity(),
                    style: GoogleFonts.inter(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          )
        : SizedBox.shrink();
  }
}
