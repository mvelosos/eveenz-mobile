import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:party_mobile/app/controllers/profile_controller.dart';
import 'package:party_mobile/app/locator.dart';
import 'package:party_mobile/app/models/notification_model.dart';
import 'package:party_mobile/app/pages/account/account_page.dart';
import 'package:party_mobile/app/shared/constants/app_colors.dart';
import 'package:party_mobile/app/shared/constants/route_names.dart';

class AccountFollowListTile extends StatefulWidget {
  final NotificationModel notificationModel;
  final Function getNotifications;

  AccountFollowListTile(this.notificationModel, this.getNotifications);

  @override
  _AccountFollowListTileState createState() => _AccountFollowListTileState();
}

class _AccountFollowListTileState extends State<AccountFollowListTile> {
  final ProfileController _profileController = locator<ProfileController>();
  bool _loading = false;

  void _navigateToAccount(BuildContext context) {
    Navigator.of(context).pushNamed(
      RouteNames.showAccount,
      arguments: AccountPageArguments(
        username: widget.notificationModel.follower!.username!,
      ),
    );
  }

  void _setLoading(bool value) {
    setState(() {
      _loading = value;
    });
  }

  void _followAccount() async {
    _setLoading(true);
    await _profileController
        .followAccount(widget.notificationModel.follower!.uuid!);
    await widget.getNotifications();
    _setLoading(false);
  }

  void _unfollowAccount() async {
    _setLoading(true);
    await _profileController
        .unfollowAccount(widget.notificationModel.follower!.uuid!);
    await widget.getNotifications();
    _setLoading(false);
  }

  String _formattedDateDiff() {
    var createdAt = DateTime.parse(widget.notificationModel.createdAt!);
    var now = DateTime.now();
    var diff = now.difference(createdAt);

    if (diff.inDays > 0) {
      return ' ${diff.inDays}d';
    }
    if (diff.inHours > 0) {
      return ' ${diff.inHours}h';
    }
    if (diff.inMinutes > 0) {
      return ' ${diff.inMinutes}m';
    }
    if (diff.inSeconds > 0) {
      return ' ${diff.inSeconds}s';
    }
    return '';
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.only(left: 2, bottom: 5, top: 10),
      dense: true,
      onTap: () {
        _navigateToAccount(context);
      },
      leading: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(
            fit: BoxFit.cover,
            image: Image.network(
              widget.notificationModel.follower!.avatarUrl!,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) {
                  return child;
                }
                return CircleAvatar(
                  radius: 50,
                  backgroundColor: Color(0xffd3d5db),
                );
              },
            ).image,
          ),
        ),
      ),
      title: RichText(
        overflow: TextOverflow.clip,
        text: TextSpan(
          style: DefaultTextStyle.of(context).style,
          children: <TextSpan>[
            TextSpan(
              text: '${widget.notificationModel.follower!.username}',
              style: GoogleFonts.nunitoSans(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            TextSpan(
              text: ' ${_formattedDateDiff()}',
              style: GoogleFonts.inter(
                fontWeight: FontWeight.w400,
                fontSize: 11,
                color: AppColors.gray3,
              ),
            ),
          ],
        ),
      ),
      subtitle: Text(
        'começou a seguir você',
        style: TextStyle(fontSize: 13),
      ),
      trailing: widget.notificationModel.followedByMe!
          ? Padding(
              padding: EdgeInsets.only(top: 10, bottom: 10),
              child: ElevatedButton(
                onPressed: () => _loading ? null : _unfollowAccount(),
                child: Text(
                  'seguindo',
                  overflow: TextOverflow.visible,
                ),
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.grey),
                ),
              ),
            )
          : Padding(
              padding: EdgeInsets.only(top: 10, bottom: 10),
              child: ElevatedButton(
                onPressed: () => _loading ? null : _followAccount(),
                child: Text(
                  'seguir',
                  overflow: TextOverflow.visible,
                ),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                    AppColors.orange,
                  ),
                ),
              ),
            ),
    );
  }
}
