import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

void showSnackBar(BuildContext context, String content) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(content,)
    ),
  );
}

String getNameFromEmail(String email) {
  return email.split('@')[0];
}

Future<File?> pickImage() async {
  
  final ImagePicker picker = ImagePicker();
  final imageFile = await picker.pickImage(source: ImageSource.gallery);
if(imageFile != null) {
  return File(imageFile.path);
 }
 return null; 
}