import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

pickImage(ImageSource source) async {
  final ImagePicker imagerPicker = ImagePicker();
  XFile? _file = await imagerPicker.pickImage(source: source);
  if (_file != null) {
    return await _file.readAsBytes();
  }
  return debugPrint("No file selected from gallery");
}
