import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class ImageCropPicker {
  ImagePicker _picker = ImagePicker();
  String pickerType = 'gallery';
  bool enableCrop = true;

  ImageCropPicker({bool enableCrop, String pickerType}) {
    this.enableCrop = enableCrop;
    this.pickerType = pickerType;
  }

  Future<File> initPicker() async {
    PickedFile pickedFile = await _picker.getImage(source: _getPickerType());

    if (pickedFile == null) return null;

    File fileImage = File(pickedFile.path);

    if (enableCrop) {
      fileImage = await _initCropper(fileImage);
    }

    return fileImage;
  }

  Future<File> _initCropper(File image) async {
    File croppedFile = await ImageCropper.cropImage(
      sourcePath: image.path,
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

    if (croppedFile == null) return null;
    return croppedFile;
  }

  ImageSource _getPickerType() {
    if (pickerType == 'gallery') return ImageSource.gallery;
    if (pickerType == 'camera') return ImageSource.camera;
    return ImageSource.gallery;
  }
}
