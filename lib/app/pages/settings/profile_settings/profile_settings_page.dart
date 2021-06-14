import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:party_mobile/app/controllers/profile_controller.dart';
import 'package:party_mobile/app/locator.dart';
import 'package:party_mobile/app/services/navigation_service.dart';
import 'package:party_mobile/app/shared/constants/app_colors.dart';
import 'package:party_mobile/app/shared/constants/route_names.dart';
import 'package:party_mobile/app/shared/utils/commons.dart';
import 'package:party_mobile/app/shared/utils/image_crop_picker.dart';
import 'package:party_mobile/app/stores/profile_store.dart';
import 'package:party_mobile/app/view_models/me_profile_vm.dart';

class ProfileSettingsPage extends StatefulWidget {
  @override
  _ProfileSettingsPageState createState() => _ProfileSettingsPageState();
}

class _ProfileSettingsPageState extends State<ProfileSettingsPage> {
  final ProfileController _profileController = locator<ProfileController>();
  final ProfileStore _profileStore = locator<ProfileStore>();
  final MeProfileVM _profile = MeProfileVM();
  NavigationService? _navigationService;

  void _onImagePick() async {
    File? _pickedImage = await ImageCropPicker(
      enableCrop: true,
      pickerType: 'gallery',
      cropStyle: CropStyle.circle,
    ).initPicker();

    _requestUpdateAvatar(_pickedImage);
  }

  void _requestUpdateAvatar(File? file) async {
    if (file == null) return;

    var base64image = await Commons.encodeBase64(file);
    base64image = Commons.base64dataUri(base64image);
    _profile.avatar = {
      'data': base64image,
      'filename': DateTime.now().millisecondsSinceEpoch
    };

    var result = await _profileController.updateProfile(_profile);
    result.fold(
      (l) => {print(l.message)},
      (r) async => {
        await _profileController.getProfile(),
      },
    );
  }

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
              GestureDetector(
                onTap: () {
                  _onImagePick();
                },
                child: Container(
                  // color: Colors.blue,
                  child: Column(
                    children: [
                      Obx(
                        () => Container(
                          width: 90,
                          height: 90,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: Image.network(
                                _profileStore.avatarUrl.value,
                                loadingBuilder:
                                    (context, child, loadingProgress) {
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
                      ),
                      SizedBox(height: 15),
                      Text(
                        'Alterar foto',
                        style: TextStyle(color: Colors.blue, fontSize: 15),
                      ),
                      SizedBox(height: 10),
                    ],
                  ),
                ),
              ),
              Divider(),
              ListTile(
                leading: Container(
                  width: 60,
                  child: Text('Nome'),
                ),
                title: Obx(() => Text(_profileStore.name.value)),
                onTap: () {
                  _navigationService!.pushNamed(RouteNames.updateNameSettings);
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
                  _navigationService!.pushNamed(RouteNames.updateBioSettings);
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
