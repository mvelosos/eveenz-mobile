import 'package:flutter/material.dart';

class ProfileAvatar extends StatelessWidget {
  final String? avatarUrl;

  ProfileAvatar(this.avatarUrl);

  @override
  Widget build(BuildContext context) {
    return (avatarUrl != null && avatarUrl != '')
        ? CircleAvatar(
            backgroundColor: Color(0xffd3d5db),
            radius: 55,
            child: CircleAvatar(
              radius: 55,
              backgroundColor: Colors.transparent,
              backgroundImage: NetworkImage(avatarUrl!),
            ),
          )
        : CircleAvatar(
            radius: 55,
            backgroundColor: Color(0xffd3d5db),
          );
  }
}
