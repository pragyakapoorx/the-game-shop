import 'package:flutter/material.dart';

class CyberColors {
  static const Color bg = Color(0xFF0A0A0F);
  static const Color bg2 = Color(0xFF0D0D14);
  static const Color surface = Color(0xFF12121A);
  static const Color surface2 = Color(0xFF1C1C2E);
  static const Color border = Color(0xFF2A2A3A);

  static const Color cyan = Color(0xFF00D4FF);
  static const Color green = Color(0xFF00FF88);
  static const Color magenta = Color(0xFFFF00FF);
  static const Color red = Color(0xFFFF3366);

  static const Color text = Color(0xFFE0E0E0);
  static const Color text2 = Color(0xFF8888AA);
  static const Color text3 = Color(0xFF4A4A6A);

  // Reusable BoxShadows for Neon Glows
  static List<BoxShadow> get greenGlow => [
    const BoxShadow(color: green, blurRadius: 5, spreadRadius: 0),
    BoxShadow(color: green.withOpacity(0.4), blurRadius: 10, spreadRadius: 0),
    BoxShadow(color: green.withOpacity(0.2), blurRadius: 20, spreadRadius: 0),
  ];

  static List<BoxShadow> get cyanGlow => [
    const BoxShadow(color: cyan, blurRadius: 5, spreadRadius: 0),
    BoxShadow(color: cyan.withOpacity(0.5), blurRadius: 15, spreadRadius: 0),
  ];
}