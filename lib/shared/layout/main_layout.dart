import 'package:flutter/material.dart';
import '../../core/theme/cyber_colors.dart';
import 'top_nav_bar.dart';

class MainLayout extends StatelessWidget {
  final Widget child;

  const MainLayout({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CyberColors.bg,
      body: Column(
        children: [
          const TopNavBar(),
          // The Expanded widget ensures the current page takes up the remaining screen space
          Expanded(
            child: child,
          ),
        ],
      ),
    );
  }
}