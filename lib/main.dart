import 'package:flutter/material.dart';
import 'theme/app_theme.dart';
import 'screens/home_screen.dart';
import 'screens/tools_screen.dart';
import 'screens/profile_screen.dart';

void main() {
  runApp(const FuzziApp());
}

class FuzziApp extends StatelessWidget {
  const FuzziApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fuzzi QA Toolbox',
      debugShowCheckedModeBanner: false,
      darkTheme: AppTheme.dark,
      themeMode: ThemeMode.dark,
      home: const MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  static const _screens = [
    HomeScreen(),
    ToolsScreen(),
    ProfileScreen(),
  ];

  String get _title {
    switch (_currentIndex) {
      case 0: return 'Fuzzi QA Toolbox';
      case 1: return 'Narzędzia';
      case 2: return 'Profil';
      default: return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_title),
      ),
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (i) => setState(() => _currentIndex = i),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.build), label: 'Tools'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}
