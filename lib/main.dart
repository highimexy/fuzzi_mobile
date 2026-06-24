import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'firebase_options.dart';

// Ekrany
import 'screens/home_screen.dart';
import 'screens/login_screen.dart';
import 'screens/tools_screen.dart';
import 'screens/profile_screen.dart';

// Widgety
import 'widgets/fuzzi_mark.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const FuzziApp());
}

class FuzziApp extends StatelessWidget {
  const FuzziApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fuzzi QA Toolbox',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF0A0A0C),
        primaryColor: Colors.blueAccent,
      ),
      home: const AuthWrapper(),
    );
  }
}

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        Widget child;
        if (snapshot.connectionState == ConnectionState.waiting) {
          child = const Scaffold(
            body: Center(child: FuzziMark(size: 64)),
          );
        } else if (snapshot.hasData) {
          child = const MainScreen();
        } else {
          child = const LoginScreen();
        }
        return AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          child: child,
        );
      },
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

  final List<Widget> _screens = [
    const HomeScreen(),
    const ToolsScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: Stack(
        children: [
          // 1. Ekran główny - z dolnym paddingiem, żeby nie chował się pod paskiem
          Padding(
            padding: const EdgeInsets.only(bottom: 80),
            child: _screens[_currentIndex],
          ),

          // 2. Pływający Pasek Nawigacji (Custom Dock)
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
              child: Container(
                height: 60,
                decoration: BoxDecoration(
                  color: const Color(0xFF1E1E1E).withOpacity(0.9),
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(color: Colors.white.withOpacity(0.05)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    IconButton(
                      icon: Icon(Icons.newspaper_rounded,
                        color: _currentIndex == 0 ? Colors.white : Colors.white54),
                      onPressed: () => setState(() => _currentIndex = 0),
                    ),
                    const SizedBox(width: 60), // Miejsce na Fuzziego
                    IconButton(
                      icon: Icon(Icons.person_outline_rounded,
                        color: _currentIndex == 2 ? Colors.white : Colors.white54),
                      onPressed: () => setState(() => _currentIndex = 2),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // 3. Fuzzi w centralnym punkcie
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 40),
              child: GestureDetector(
                onTap: () => setState(() => _currentIndex = 1),
                child: Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: const Color(0xFF161914),
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white.withOpacity(0.1), width: 2),
                    boxShadow: [
                      BoxShadow(color: Colors.black.withOpacity(0.5), blurRadius: 10, offset: const Offset(0, 4)),
                    ],
                  ),
                  child: const Center(child: FuzziMark(size: 36)),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
