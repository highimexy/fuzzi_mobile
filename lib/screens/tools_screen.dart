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

class ToolsScreen extends StatefulWidget {
  const ToolsScreen({super.key});

  @override
  State<ToolsScreen> createState() => _ToolsScreenState();
}

class _ToolsScreenState extends State<ToolsScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Material(
          color: AppColors.roughCard,
          child: TabBar(
            controller: _tabController,
            dividerColor: Colors.transparent,
            tabs: const [
              Tab(text: 'Wszystkie'),
              Tab(text: 'UI/UX'),
              Tab(text: 'Wideo'),
              Tab(text: 'Dev'),
            ],
          ),
        ),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: [
              _buildGrid(0),
              _buildGrid(1),
              _buildGrid(2),
              _buildGrid(3),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildGrid(int categoryIndex) {
    List<ToolItem> tools;
    switch (categoryIndex) {
      case 0:
        tools = _allTools;
      case 1:
        tools = _allTools.where((t) => t.category == 'UI/UX').toList();
      case 2:
        tools = _allTools.where((t) => t.category == 'Wideo').toList();
      case 3:
        tools = _allTools.where((t) => t.category == 'Dev').toList();
      default:
        tools = [];
    }

    if (tools.isEmpty) {
      return Center(
        child: Text('Brak narzędzi w tej kategorii',
          style: TextStyle(color: AppColors.secondary)),
      );
    }

    return GridView.builder(
      padding: const EdgeInsets.all(12),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemCount: tools.length,
      itemBuilder: (context, index) => _ToolTile(tool: tools[index]),
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
