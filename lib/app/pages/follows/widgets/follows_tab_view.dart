import 'package:flutter/material.dart';

class FollowsTabView extends StatefulWidget {
  @override
  _FollowsTabViewState createState() => _FollowsTabViewState();
}

class _FollowsTabViewState extends State<FollowsTabView> {
  @override
  Widget build(BuildContext context) {
    return TabBarView(
      children: [
        Text('Mostrando seguidores'),
        Text('Mostrando seguindo'),
      ],
    );
  }
}
