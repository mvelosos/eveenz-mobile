import 'package:flutter/material.dart';
import 'package:party_mobile/app/models/notification_model.dart';
import 'package:party_mobile/app/shared/constants/app_colors.dart';

class AccountFollowListTile extends StatelessWidget {
  final NotificationModel? notificationModel;

  AccountFollowListTile(this.notificationModel);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return ListTile(
      contentPadding: EdgeInsets.only(left: 2, bottom: 5, top: 10),
      dense: true,
      onTap: () {},
      leading: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(
            fit: BoxFit.cover,
            image: Image.network(
              notificationModel!.follower!.avatarUrl!,
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
                text: '${notificationModel!.follower!.username}',
                style: TextStyle(fontWeight: FontWeight.bold)),
            TextSpan(text: ' começou a seguir você!'),
          ],
        ),
      ),
      trailing: (notificationModel != null && notificationModel!.followedByMe!)
          ? SizedBox(
              height: size.height * .034,
              width: size.height * .107,
              child: ElevatedButton(
                onPressed: () {},
                child: Text('seguindo'),
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.grey),
                ),
              ),
            )
          : SizedBox(
              height: size.height * .034,
              width: size.height * .084,
              child: ElevatedButton(
                onPressed: () {},
                child: Text('seguir'),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                    AppColors.orange,
                  ),
                ),
              )),
    );
  }
}
