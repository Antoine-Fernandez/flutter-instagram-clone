import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

Future<dynamic> pickImage(ImageSource source) async {
  final ImagePicker imagePicker = ImagePicker();

  final XFile? file = await imagePicker.pickImage(source: source);

  if (file != null) {
    return file.readAsBytes();
  }
}

void showSnackBar(BuildContext context, String content) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(content),
    ),
  );
}
