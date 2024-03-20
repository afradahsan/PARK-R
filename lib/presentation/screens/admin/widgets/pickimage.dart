import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

Future<File?> pickImages() async {
  File? image;
  try {
    var files = await FilePicker.platform.pickFiles(
      type: FileType.image,
    );
    if (files != null && files.files.isNotEmpty) {
      image = File(files.files.single.path!);
    }
  } catch (e) {
    debugPrint(e.toString());
  }
  return image;
}