import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageService {
  static final ImageService _instance = ImageService._internal();
  factory ImageService() => _instance;
  ImageService._internal();

  final ImagePicker _picker = ImagePicker();

  Future<Uint8List?> pickImage({ImageSource source = ImageSource.gallery}) async {
    try {
      final XFile? image = await _picker.pickImage(
        source: source,
        maxWidth: 1024,
        maxHeight: 1024,
        imageQuality: 85,
      );

      if (image != null) {
        return await image.readAsBytes();
      }
      return null;
    } catch (e) {
      debugPrint('Image picker error: $e');
      return null;
    }
  }

  Future<List<Uint8List>?> pickTwoImages() async {
    try {
      final XFile? image1 = await _picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 1024,
        maxHeight: 1024,
        imageQuality: 85,
      );
      
      if (image1 == null) return null;

      final XFile? image2 = await _picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 1024,
        maxHeight: 1024,
        imageQuality: 85,
      );
      
      if (image2 == null) return null;

      return [
        await image1.readAsBytes(),
        await image2.readAsBytes(),
      ];
    } catch (e) {
      debugPrint('Image picker error: $e');
      return null;
    }
  }
}
