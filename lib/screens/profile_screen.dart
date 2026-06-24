import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../theme/app_theme.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  Future<void> _signOut(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
  }

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
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Column(
              children: [
                const Spacer(),
                CircleAvatar(
                  radius: 48,
                  backgroundColor: AppColors.roughCard,
                  child: Icon(Icons.person, size: 52, color: AppColors.primary),
                ),
                const SizedBox(height: 20),
                Text('QA Tester',
                  style: const TextStyle(
                    fontSize: 24, fontWeight: FontWeight.w700,
                    color: AppColors.foreground),
                ),
                const SizedBox(height: 4),
                Text('Manual QA Engineer',
                  style: TextStyle(
                    fontSize: 14, color: AppColors.secondary),
                ),
                const SizedBox(height: 32),
                _ProfileInfoRow(icon: Icons.email, label: 'qa@fuzzi.dev'),
                const SizedBox(height: 12),
                _ProfileInfoRow(icon: Icons.calendar_today, label: 'Dołączył: czerwiec 2025'),
                const SizedBox(height: 12),
                _ProfileInfoRow(icon: Icons.star, label: 'Ranga: Senior Tester'),
                const Spacer(),
                SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton.icon(
                    onPressed: () => _signOut(context),
                    icon: const Icon(Icons.logout, size: 20),
                    label: const Text('Wyloguj się'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.redAccent.withValues(alpha: 0.15),
                      foregroundColor: Colors.redAccent,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                        side: BorderSide(color: Colors.redAccent.withValues(alpha: 0.3)),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _ProfileInfoRow extends StatelessWidget {
  final IconData icon;
  final String label;

  const _ProfileInfoRow({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: AppColors.roughCard,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.secondary.withValues(alpha: 0.15)),
      ),
      child: Row(
        children: [
          Icon(icon, size: 20, color: AppColors.primary),
          const SizedBox(width: 12),
          Text(label,
            style: const TextStyle(fontSize: 14, color: AppColors.foreground)),
        ],
      ),
    );
  }
}
