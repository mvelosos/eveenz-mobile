import 'dart:io';

import 'package:party_mobile/app/shared/utils/commons.dart';

class ImageUploadModel {
  late File imageFile;
  bool? isUploaded;
  bool? uploading;
  String? imageUrl;

  ImageUploadModel({
    required this.imageFile,
    this.isUploaded,
    this.uploading,
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
