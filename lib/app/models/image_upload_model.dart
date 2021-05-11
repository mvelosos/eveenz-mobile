import 'dart:io';

import 'package:party_mobile/app/shared/utils/commons.dart';

class ImageUploadModel {
  bool isUploaded;
  bool uploading;
  File imageFile;
  String imageUrl;

  ImageUploadModel({
    this.isUploaded,
    this.uploading,
    this.imageFile,
    this.imageUrl,
  });

  get imagePath {
    return imageFile.path;
  }

  get base64Image {
    var base64image = Commons.encodeBase64(this.imageFile);
    return Commons.base64dataUri(base64image);
  }
}
