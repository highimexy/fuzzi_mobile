import 'dart:ui';
import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class ToolItem {
  final String title;
  final String category;
  final IconData icon;

  const ToolItem({
    required this.title,
    required this.category,
    required this.icon,
  });
}

const _allTools = [
  ToolItem(title: 'Kolor', category: 'UI/UX', icon: Icons.color_lens),
  ToolItem(title: 'Linijka', category: 'UI/UX', icon: Icons.straighten),
  ToolItem(title: 'Kontrast', category: 'UI/UX', icon: Icons.brightness_6),
  ToolItem(title: 'Siatka', category: 'UI/UX', icon: Icons.grid_4x4),
  ToolItem(title: 'Lupa', category: 'UI/UX', icon: Icons.search),
  ToolItem(title: 'Kompresuj', category: 'Wideo', icon: Icons.compress),
  ToolItem(title: 'Przytnij', category: 'Wideo', icon: Icons.cut),
  ToolItem(title: 'FPS', category: 'Wideo', icon: Icons.speed),
  ToolItem(title: 'Metadane', category: 'Wideo', icon: Icons.info_outline),
  ToolItem(title: 'Logi', category: 'Dev', icon: Icons.receipt_long),
  ToolItem(title: 'Dane Testowe', category: 'Dev', icon: Icons.data_object),
  ToolItem(title: 'Deep Link', category: 'Dev', icon: Icons.link),
  ToolItem(title: 'API', category: 'Dev', icon: Icons.api),
  ToolItem(title: 'Mocki', category: 'Dev', icon: Icons.copy_all),
  ToolItem(title: 'Cache', category: 'Dev', icon: Icons.cached),
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
          child: GridView.builder(
            padding: const EdgeInsets.all(20),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            itemCount: _allTools.length,
            itemBuilder: (context, index) => _ToolTile(tool: _allTools[index]),
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
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Uruchamiam: ${tool.title}'),
            duration: const Duration(milliseconds: 500),
            backgroundColor: AppColors.primary,
          ),
        );
      },
      borderRadius: BorderRadius.circular(12),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.roughCard,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: AppColors.secondary.withValues(alpha: 0.15),
            width: 1,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(tool.icon, size: 32, color: AppColors.primary),
            const SizedBox(height: 8),
            Text(
              tool.title,
              style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w400),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
