import 'package:flutter/material.dart';

class ChamferClipper extends CustomClipper<Path> {
  final double chamferSize;

  ChamferClipper({this.chamferSize = 10.0});

  @override
  Path getClip(Size size) {
    final w = size.width;
    final h = size.height;
    final c = chamferSize;

    Path path = Path()
      ..moveTo(0, c)
      ..lineTo(c, 0)
      ..lineTo(w - c, 0)
      ..lineTo(w, c)
      ..lineTo(w, h - c)
      ..lineTo(w - c, h)
      ..lineTo(c, h)
      ..lineTo(0, h - c)
      ..close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}