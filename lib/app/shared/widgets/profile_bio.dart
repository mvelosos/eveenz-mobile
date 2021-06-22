import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileBio extends StatelessWidget {
  final String? bio;

  ProfileBio(this.bio);

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;

    return (bio != null && bio != '')
        ? Column(
            children: [
              AutoSizeText(
                bio!,
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(),
              ),
              SizedBox(height: _size.height * .02),
            ],
          )
        : SizedBox.shrink();
  }
}
