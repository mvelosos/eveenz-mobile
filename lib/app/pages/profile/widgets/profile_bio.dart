import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:party_mobile/app/locator.dart';
import 'package:party_mobile/app/stores/me_store.dart';

class ProfileBio extends StatelessWidget {
  final MeStore _meStore = locator<MeStore>();

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;

    return Obx(
      () => _meStore.bio.value != ''
          ? Column(
              children: [
                Obx(
                  () => AutoSizeText(
                    _meStore.bio.value,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(),
                  ),
                ),
                SizedBox(height: _size.height * .02),
              ],
            )
          : SizedBox.shrink(),
    );
  }
}
