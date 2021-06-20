import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:party_mobile/app/locator.dart';
import 'package:party_mobile/app/navigators/keys/navigator_keys.dart';
import 'package:party_mobile/app/services/local_storage_service.dart';
import 'package:party_mobile/app/services/navigation_service.dart';
import 'package:party_mobile/app/shared/constants/app_colors.dart';
import 'package:party_mobile/app/shared/constants/route_names.dart';
import 'package:party_mobile/app/shared/constants/storage.dart';
import 'package:party_mobile/app/stores/auth_user_store.dart';

class SignOutListTile extends StatelessWidget {
  final AuthUserStore _authUserStore = locator<AuthUserStore>();
  final LocalStorageService _storage = locator<LocalStorageService>();

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
        _storage.delete(Storage.jwtToken),
        _storage.delete(Storage.username),
        _authUserStore.clear(),
        OneSignal.shared.removeExternalUserId(),
        Navigator.of(context)
            .pushNamedAndRemoveUntil(RouteNames.root, (_) => false)
      },
    );
  }
}
