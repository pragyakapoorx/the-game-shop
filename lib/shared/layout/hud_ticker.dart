import 'package:flutter/material.dart';
import '../../core/theme/cyber_colors.dart';
import '../../core/clippers/chamfer_clipper.dart';

class HudTicker extends StatefulWidget {
  const HudTicker({super.key});

  @override
  State<HudTicker> createState() => _HudTickerState();
}

class _HudTickerState extends State<HudTicker> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final String _message = "PLAYER.ONE.READY | FLASH SALES: ACTIVE | NEW INVENTORY DETECTED | CONNECTION: STABLE | NEW.QUESTS.AVAILABLE | LOADING WORLD | ";

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 20),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: ChamferClipper(chamferSize: 4.0),
      child: Container(
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          color: CyberColors.green.withOpacity(0.02),
          border: Border.all(color: CyberColors.green.withOpacity(0.1)),
        ),
        child: ClipRect(
          child: AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return FractionalTranslation(
                translation: Offset(-_controller.value, 0),
                // 1. Wrap the Row in an OverflowBox
                child: OverflowBox(
                  maxWidth: double.infinity,
                  alignment: Alignment.centerLeft,
                  // 2. Tell the Row to only be as wide as it needs to be
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _buildText(),
                      _buildText(), // Duplicate for seamless looping
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildText() {
    return Text(
      _message,
      maxLines: 1,
      style: const TextStyle(
        fontFamily: 'Share Tech Mono',
        fontSize: 10,
        color: CyberColors.green,
        letterSpacing: 1,
        shadows: [Shadow(color: CyberColors.green, blurRadius: 4)],
      ),
    );
  }
}