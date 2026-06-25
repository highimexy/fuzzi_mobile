import 'dart:ui';
import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../models/tool_item.dart';
import 'tool_detail_screen.dart';

const _allTools = [
  ToolItem(title: 'Kolor', icon: Icons.color_lens),
  ToolItem(title: 'Kontrast', icon: Icons.brightness_6),
  ToolItem(title: 'Linijka', icon: Icons.straighten),
  ToolItem(title: 'JSON', icon: Icons.data_object),
  ToolItem(title: 'API', icon: Icons.api),
  ToolItem(title: 'Deep Link', icon: Icons.link),
  ToolItem(title: 'Generator', icon: Icons.token),
  ToolItem(title: 'Logi', icon: Icons.receipt_long),
];

class ToolsScreen extends StatelessWidget {
  const ToolsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: -100,
          left: -100,
          child: Container(
            width: 300,
            height: 300,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: const Color(0xFF7a8a6e).withValues(alpha: 0.15),
            ),
          ),
        ),
        Positioned(
          bottom: -120,
          right: -80,
          child: Container(
            width: 260,
            height: 260,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: const Color(0xFFf5e642).withValues(alpha: 0.1),
            ),
          ),
        ),
        Positioned.fill(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 80, sigmaY: 80),
            child: const SizedBox(),
          ),
        ),
        SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 20, 16, 20),
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
              ),
              itemCount: _allTools.length,
              itemBuilder: (context, index) => _ToolTile(tool: _allTools[index]),
            ),
          ),
        ),
      ],
    );
  }
}

class _ToolTile extends StatelessWidget {
  final ToolItem tool;

  const _ToolTile({required this.tool});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => ToolDetailScreen(tool: tool),
          ),
        );
      },
      borderRadius: BorderRadius.circular(16),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.roughCard,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: AppColors.secondary.withValues(alpha: 0.15),
            width: 1,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(tool.icon, size: 44, color: AppColors.primary),
            const SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Text(
                tool.title,
                style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
