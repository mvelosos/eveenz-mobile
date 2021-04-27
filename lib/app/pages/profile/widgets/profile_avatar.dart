import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:party_mobile/app/locator.dart';
import 'package:party_mobile/app/stores/me_store.dart';

class ProfileAvatar extends StatelessWidget {
  final MeStore _meStore = locator<MeStore>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => _meStore.avatarUrl.value != ''
          ? Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  fit: BoxFit.fill,
                  image: Image.network(
                    _meStore.avatarUrl.value,
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
