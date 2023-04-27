import 'dart:convert' as base;
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerAndConvertor {
  final ImagePicker _picker = ImagePicker();
  CroppedFile? _croppedFile;
  Future<String> pickImage(ImageSource source) async {
    final XFile? image = await _picker.pickImage(source: source);
    final croppedFile = await ImageCropper().cropImage(
      sourcePath: image!.path,
      compressFormat: ImageCompressFormat.jpg,
      compressQuality: 100,
      uiSettings: [
        AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: Colors.grey,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
      ],
    );
    if (croppedFile != null) {
      _croppedFile = croppedFile;
    }
    File imageFile = new File(_croppedFile!.path);

    List<int> imageBytes = imageFile.readAsBytesSync();
    return base.base64.encode(imageBytes);
  }
}
