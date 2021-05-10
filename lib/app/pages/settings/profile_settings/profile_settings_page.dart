import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
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
  final ImagePicker _picker = ImagePicker();
  File _image;
  NavigationService _navigationService;

  void _onImagePick() async {
    final pickedFile = await _picker.getImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        _initImageCropper();
      } else {
        print('No image selected.');
      }
    });
  }

  void _initImageCropper() async {
    File croppedFile = await ImageCropper.cropImage(
      sourcePath: _image.path,
      aspectRatioPresets: [
        CropAspectRatioPreset.square,
        CropAspectRatioPreset.ratio3x2,
        CropAspectRatioPreset.original,
        CropAspectRatioPreset.ratio4x3,
        CropAspectRatioPreset.ratio16x9
      ],
      androidUiSettings: AndroidUiSettings(
          toolbarTitle: 'Cortar',
          toolbarColor: Colors.transparent,
          toolbarWidgetColor: Colors.white,
          initAspectRatio: CropAspectRatioPreset.original,
          lockAspectRatio: false),
      iosUiSettings: IOSUiSettings(
        minimumAspectRatio: 1.0,
        doneButtonTitle: 'Ok',
        cancelButtonTitle: 'Cancelar',
      ),
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
                      Container(
                        width: 90,
                        height: 90,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            fit: BoxFit.fill,
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
