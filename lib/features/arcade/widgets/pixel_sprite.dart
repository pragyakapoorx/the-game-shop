import 'package:flutter/material.dart';
import '../utils/sprite_data.dart';

class PixelSprite extends StatelessWidget {
  final List<String> sprite;
  final double pixelSize;
  final bool flipHorizontal;

  const PixelSprite({
    super.key,
    required this.sprite,
    this.pixelSize = 4.0,
    this.flipHorizontal = false,
  });

  @override
  Widget build(BuildContext context) {
    final width = sprite[0].length * pixelSize;
    final height = sprite.length * pixelSize;

    return CustomPaint(
      size: Size(width, height),
      painter: _PixelPainter(
        sprite: sprite,
        pixelSize: pixelSize,
        flipHorizontal: flipHorizontal,
      ),
    );
  }
}

class _PixelPainter extends CustomPainter {
  final List<String> sprite;
  final double pixelSize;
  final bool flipHorizontal;

  _PixelPainter({required this.sprite, required this.pixelSize, required this.flipHorizontal});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..style = PaintingStyle.fill;

    for (int row = 0; row < sprite.length; row++) {
      final cols = sprite[row].split('');
      final cw = cols.length;

      for (int col = 0; col < cw; col++) {
        final char = flipHorizontal ? cols[cw - 1 - col] : cols[col];
        if (char == '_') continue; // Transparent

        final color = SpriteData.palette[char];
        if (color != null) {
          paint.color = color;
          canvas.drawRect(
            Rect.fromLTWH(col * pixelSize, row * pixelSize, pixelSize, pixelSize),
            paint,
          );
        }
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}