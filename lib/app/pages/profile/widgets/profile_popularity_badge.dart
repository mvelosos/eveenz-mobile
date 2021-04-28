import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:party_mobile/app/locator.dart';
import 'package:party_mobile/app/shared/constants/app_colors.dart';
import 'package:party_mobile/app/stores/me_store.dart';

class ProfilePopularityBadge extends StatelessWidget {
  final MeStore _meStore = locator<MeStore>();

  String _formattedPopularity() {
    var numberFormat = NumberFormat('0,000', 'pt_BR');
    return numberFormat.format(_meStore.popularity.value).toString();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => _meStore.popularity.value != 0
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
                    Obx(
                      () => Text(
                        _formattedPopularity(),
                        style: GoogleFonts.inter(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )
          : SizedBox.shrink(),
    );
  }
}
