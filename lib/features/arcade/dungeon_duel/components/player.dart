import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../core/theme/cyber_colors.dart';

class Player extends PositionComponent with KeyboardHandler {
  static const double speed = 250.0;
  Vector2 velocity = Vector2.zero();

  Player() : super(size: Vector2(40, 40), anchor: Anchor.center);

  @override
  void render(Canvas canvas) {
    // Draw a glowing neon square for our skeleton player
    final paint = Paint()
      ..color = CyberColors.cyan.withOpacity(0.8)
      ..style = PaintingStyle.fill;

    final borderPaint = Paint()
      ..color = CyberColors.cyan
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    final rect = size.toRect();
    canvas.drawRect(rect, paint);
    canvas.drawRect(rect, borderPaint);

    super.render(canvas);
  }

  @override
  void update(double dt) {
    // Move the player based on velocity and delta time (dt)
    position += velocity * dt;
    super.update(dt);
  }

  @override
  bool onKeyEvent(KeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    // Reset velocity
    velocity = Vector2.zero();

    // WASD or Arrow Keys for movement
    if (keysPressed.contains(LogicalKeyboardKey.keyW) || keysPressed.contains(LogicalKeyboardKey.arrowUp)) {
      velocity.y = -speed;
    }
    if (keysPressed.contains(LogicalKeyboardKey.keyS) || keysPressed.contains(LogicalKeyboardKey.arrowDown)) {
      velocity.y = speed;
    }
    if (keysPressed.contains(LogicalKeyboardKey.keyA) || keysPressed.contains(LogicalKeyboardKey.arrowLeft)) {
      velocity.x = -speed;
    }
    if (keysPressed.contains(LogicalKeyboardKey.keyD) || keysPressed.contains(LogicalKeyboardKey.arrowRight)) {
      velocity.x = speed;
    }

    return super.onKeyEvent(event, keysPressed);
  }
}