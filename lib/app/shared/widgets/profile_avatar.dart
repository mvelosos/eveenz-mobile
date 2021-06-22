import 'package:flutter/material.dart';

class ProfileAvatar extends StatelessWidget {
  final String? avatarUrl;

  ProfileAvatar(this.avatarUrl);

  @override
  Widget build(BuildContext context) {
    return (avatarUrl != null && avatarUrl != '')
        ? Container(
            width: 110,
            height: 110,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                fit: BoxFit.cover,
                image: Image.network(
                  avatarUrl!,
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
          );
  }
}
