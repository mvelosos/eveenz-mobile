import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class ImageCropPicker {
  ImagePicker _picker = ImagePicker();
  String pickerType = 'gallery';
  CropStyle cropStyle = CropStyle.rectangle;
  bool enableCrop = true;

  ImageCropPicker({bool enableCrop, String pickerType, CropStyle cropStyle}) {
    this.enableCrop = enableCrop;
    this.pickerType = pickerType;
    this.cropStyle = cropStyle;
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
      compressFormat: ImageCompressFormat.png,
      cropStyle: this.cropStyle,
      aspectRatioPresets: [
        CropAspectRatioPreset.square,
        CropAspectRatioPreset.ratio3x2,
        CropAspectRatioPreset.original,
        CropAspectRatioPreset.ratio4x3,
      ],
      androidUiSettings: AndroidUiSettings(
        toolbarTitle: 'Cortar',
        toolbarColor: Colors.transparent,
        toolbarWidgetColor: Colors.white,
        initAspectRatio: CropAspectRatioPreset.original,
        lockAspectRatio: false,
      ),
      iosUiSettings: IOSUiSettings(
        minimumAspectRatio: 1.0,
        doneButtonTitle: 'Ok',
        cancelButtonTitle: 'Cancelar',
        aspectRatioLockEnabled: true,
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
