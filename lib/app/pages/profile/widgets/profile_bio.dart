import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:party_mobile/app/locator.dart';
import 'package:party_mobile/app/stores/profile_store.dart';

class ProfileBio extends StatelessWidget {
  final ProfileStore _profileStore = locator<ProfileStore>();

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;

    return Obx(
      () => _profileStore.bio.value != ''
          ? Column(
              children: [
                Obx(
                  () => AutoSizeText(
                    _profileStore.bio.value,
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
