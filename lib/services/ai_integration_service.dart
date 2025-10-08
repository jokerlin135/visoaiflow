import 'dart:typed_data';
import 'package:flutter/material.dart';
import '/services/huggingface_service.dart';
import '/services/image_service.dart';
import '/components/ai_result_dialog.dart';
import 'package:image_picker/image_picker.dart';

class AIIntegrationService {
  static final AIIntegrationService _instance = AIIntegrationService._internal();
  factory AIIntegrationService() => _instance;
  AIIntegrationService._internal();

  final HuggingFaceService _hfService = HuggingFaceService();
  final ImageService _imageService = ImageService();

  Future<void> processWithAI({
    required BuildContext context,
    required Future<Uint8List?> Function() aiFunction,
    required String loadingMessage,
    required String resultTitle,
    VoidCallback? onAdCompleted,
  }) async {
    try {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return Dialog(
            backgroundColor: Colors.transparent,
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF9810FA)),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    loadingMessage,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );

      final result = await aiFunction();

      if (context.mounted) {
        Navigator.of(context).pop();

        if (result != null) {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AIResultDialog(
                imageBytes: result,
                title: resultTitle,
              );
            },
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Failed to generate image. Please try again.'),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    } catch (e) {
      if (context.mounted) {
        Navigator.of(context).pop();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  Future<void> faceSwapFlow(BuildContext context) async {
    final sourceImage = await _imageService.pickImage();
    if (sourceImage == null) return;

    final targetImage = await _imageService.pickImage();
    if (targetImage == null) return;

    await processWithAI(
      context: context,
      aiFunction: () => _hfService.faceSwap(sourceImage, targetImage),
      loadingMessage: 'Swapping faces...',
      resultTitle: 'Face Swap Result',
    );
  }

  Future<void> generateHeadshotFlow(BuildContext context, String prompt) async {
    await processWithAI(
      context: context,
      aiFunction: () => _hfService.generateHeadshot(
        prompt,
        numInferenceSteps: 50,
        guidanceScale: 7.5,
      ),
      loadingMessage: 'Generating AI headshot...',
      resultTitle: 'AI Headshot',
    );
  }

  Future<void> enhancePhotoFlow(BuildContext context) async {
    final image = await _imageService.pickImage();
    if (image == null) return;

    await processWithAI(
      context: context,
      aiFunction: () => _hfService.enhancePhoto(image),
      loadingMessage: 'Enhancing photo to HD...',
      resultTitle: 'Enhanced Photo',
    );
  }

  Future<void> fixOldPhotoFlow(BuildContext context) async {
    final image = await _imageService.pickImage();
    if (image == null) return;

    await processWithAI(
      context: context,
      aiFunction: () => _hfService.fixOldPhoto(image),
      loadingMessage: 'Restoring old photo...',
      resultTitle: 'Restored Photo',
    );
  }

  Future<void> generateAvatarFlow(BuildContext context, String style) async {
    final image = await _imageService.pickImage();
    if (image == null) return;

    await processWithAI(
      context: context,
      aiFunction: () => _hfService.generateAvatar(
        'professional headshot portrait',
        style: style,
      ),
      loadingMessage: 'Creating AI avatar...',
      resultTitle: 'AI Avatar',
    );
  }
}
