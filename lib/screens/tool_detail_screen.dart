import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../models/tool_item.dart';

class ToolDetailScreen extends StatelessWidget {
  final ToolItem tool;

  const ToolDetailScreen({super.key, required this.tool});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0C),
      appBar: AppBar(
        backgroundColor: AppColors.roughCard,
        foregroundColor: AppColors.foreground,
        elevation: 0,
        centerTitle: true,
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(tool.icon, size: 20, color: AppColors.primary),
            const SizedBox(width: 8),
            Text(tool.title),
          ],
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(tool.icon, size: 80, color: AppColors.roughCard),
            const SizedBox(height: 16),
            Text(
              tool.title,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w600,
                color: AppColors.foreground,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Narzędzie w budowie',
              style: TextStyle(
                fontSize: 14,
                color: AppColors.foreground.withValues(alpha: 0.5),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
