import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:party_mobile/app/locator.dart';
import 'package:party_mobile/app/stores/profile_store.dart';

class ProfileAvatar extends StatelessWidget {
  final ProfileStore _profileStore = locator<ProfileStore>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => _profileStore.avatarUrl.value != ''
          ? Container(
              width: 110,
              height: 110,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: Image.network(
                    _profileStore.avatarUrl.value,
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
            )
          : CircleAvatar(
              radius: 50,
              backgroundColor: Color(0xffd3d5db),
            ),
    );
  }
}
