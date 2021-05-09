import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:party_mobile/app/locator.dart';
import 'package:party_mobile/app/services/navigation_service.dart';
import 'package:party_mobile/app/shared/constants/app_colors.dart';
import 'package:party_mobile/app/shared/constants/route_names.dart';
import 'package:party_mobile/app/stores/profile_store.dart';

class ProfileSettingsPage extends StatefulWidget {
  @override
  _ProfileSettingsPageState createState() => _ProfileSettingsPageState();
}

class _ProfileSettingsPageState extends State<ProfileSettingsPage> {
  final ProfileStore _profileStore = locator<ProfileStore>();
  NavigationService _navigationService;

  @override
  Widget build(BuildContext context) {
    _navigationService = NavigationService.currentNavigator(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Alterar Perfil',
          style: TextStyle(color: AppColors.darkPurple, fontSize: 17),
        ),
        backgroundColor: Colors.white,
        shadowColor: Colors.transparent,
        brightness: Brightness.light,
        iconTheme: IconThemeData(color: AppColors.orange),
      ),
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          child: Column(
            children: [
              Container(
                width: 90,
                height: 90,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    fit: BoxFit.fill,
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
              ),
              SizedBox(height: 15),
              Text('Alterar foto'),
              SizedBox(height: 10),
              Divider(),
              ListTile(
                leading: Container(
                  width: 60,
                  child: Text('Nome'),
                ),
                title: Obx(() => Text(_profileStore.name.value)),
                onTap: () {
                  _navigationService.pushNamed(RouteNames.updateNameSettings);
                },
              ),
              ListTile(
                leading: Container(
                  width: 60,
                  child: Text('Nome de usuário'),
                ),
                title: Obx(() => Text(_profileStore.username.value)),
                onTap: () {},
              ),
              ListTile(
                leading: Container(
                  width: 60,
                  child: Text('Bio'),
                ),
                title: Obx(() => Text(_profileStore.bio.value)),
                onTap: () {
                  _navigationService.pushNamed(RouteNames.updateBioSettings);
                },
              ),
              Divider(),
            ],
          ),
        ),
      ),
    );
  }
}
