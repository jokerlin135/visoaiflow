import 'package:flutter/material.dart';
import '/services/ai_integration_service.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_widgets.dart';

class AITestWidget extends StatefulWidget {
  const AITestWidget({super.key});

  static String routeName = 'ai_test';
  static String routePath = '/ai_test';

  @override
  State<AITestWidget> createState() => _AITestWidgetState();
}

class _AITestWidgetState extends State<AITestWidget> {
  final AIIntegrationService _aiService = AIIntegrationService();
  final TextEditingController _promptController = TextEditingController();

  @override
  void dispose() {
    _promptController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'AI Test',
          style: TextStyle(
            color: Color(0xFF101828),
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF101828)),
          onPressed: () => Navigator.pop(context),
        ),
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Test Hugging Face AI Features',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF101828),
                ),
              ),
              const SizedBox(height: 30),
              
              // Face Swap
              _buildFeatureCard(
                title: 'Face Swap',
                description: 'Swap faces between two photos',
                icon: Icons.face,
                onPressed: () => _aiService.faceSwapFlow(context),
              ),
              
              const SizedBox(height: 16),
              
              // AI Headshot
              _buildFeatureCard(
                title: 'AI Headshot',
                description: 'Generate AI headshot from prompt',
                icon: Icons.person,
                onPressed: () => _showPromptDialog(
                  'AI Headshot',
                  (prompt) => _aiService.generateHeadshotFlow(context, prompt),
                ),
              ),
              
              const SizedBox(height: 16),
              
              // Photo Enhancement
              _buildFeatureCard(
                title: 'HD Photo Enhancement',
                description: 'Upscale photo to 4K quality',
                icon: Icons.high_quality,
                onPressed: () => _aiService.enhancePhotoFlow(context),
              ),
              
              const SizedBox(height: 16),
              
              // Fix Old Photo
              _buildFeatureCard(
                title: 'Fix Old Photo',
                description: 'Restore and colorize old photos',
                icon: Icons.auto_fix_high,
                onPressed: () => _aiService.fixOldPhotoFlow(context),
              ),
              
              const SizedBox(height: 16),
              
              // AI Avatar
              _buildFeatureCard(
                title: 'AI Avatar',
                description: 'Create AI-powered avatar',
                icon: Icons.account_circle,
                onPressed: () => _aiService.generateAvatarFlow(context, 'professional'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFeatureCard({
    required String title,
    required String description,
    required IconData icon,
    required VoidCallback onPressed,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: const Color(0xFF9810FA).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    icon,
                    size: 30,
                    color: const Color(0xFF9810FA),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF101828),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        description,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
                const Icon(
                  Icons.arrow_forward_ios,
                  size: 20,
                  color: Colors.grey,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showPromptDialog(String title, Function(String) onSubmit) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: TextField(
            controller: _promptController,
            decoration: const InputDecoration(
              hintText: 'Enter prompt (e.g., professional headshot)',
              border: OutlineInputBorder(),
            ),
            maxLines: 3,
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            FFButtonWidget(
              onPressed: () {
                Navigator.pop(context);
                onSubmit(_promptController.text);
                _promptController.clear();
              },
              text: 'Generate',
              options: FFButtonOptions(
                height: 40,
                color: const Color(0xFF9810FA),
                textStyle: const TextStyle(color: Colors.white),
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ],
        );
      },
    );
  }
}
