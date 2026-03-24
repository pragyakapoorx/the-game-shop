import 'package:flutter/material.dart';
import '../../core/theme/cyber_colors.dart';

class CyberGlitchText extends StatefulWidget {
  final String text;
  final TextStyle style;

  const CyberGlitchText({super.key, required this.text, required this.style});

  @override
  State<CyberGlitchText> createState() => _CyberGlitchTextState();
}

class _CyberGlitchTextState extends State<CyberGlitchText> with TickerProviderStateMixin {
  late AnimationController _glitchController;
  late AnimationController _rgbController;

  @override
  void initState() {
    super.initState();
    _glitchController = AnimationController(vsync: this, duration: const Duration(milliseconds: 2500))..repeat();
    _rgbController = AnimationController(vsync: this, duration: const Duration(seconds: 2))..repeat(reverse: true);
  }

  @override
  void dispose() {
    _glitchController.dispose();
    _rgbController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: Listenable.merge([_glitchController, _rgbController]),
      builder: (context, child) {
        final g = _glitchController.value;
        final r = _rgbController.value;

        // FIXED: Dropped blurRadius back to 2 for crispness, increased Offset distance!
        final shadowStyle = widget.style.copyWith(
          color: CyberColors.green,
          shadows: [
            // FIXED: Reduced multiplier from 6 to 2 to prevent horizontal bleeding
            Shadow(color: CyberColors.magenta, offset: Offset(-1 + (2 * r), 0), blurRadius: 2),
            Shadow(color: CyberColors.cyan, offset: Offset(1 - (2 * r), 0), blurRadius: 2),
            Shadow(color: CyberColors.green.withOpacity(0.4 + (0.2 * r)), blurRadius: 8 + (4 * r)),
          ],
        );

        double shiftX = 0;
        double shiftY = 0;
        Rect? clipRect;

        if (g > 0.85) {
          if (g < 0.88) {
            shiftX = -4; shiftY = 2;
            clipRect = const Rect.fromLTWH(0, 10, 1000, 10);
          } else if (g < 0.92) {
            shiftX = 4; shiftY = -2;
            clipRect = const Rect.fromLTWH(0, 30, 1000, 10);
          } else if (g < 0.96) {
            shiftX = -2; shiftY = 4;
          } else if (g < 0.99) {
            shiftX = 2; shiftY = -4;
            clipRect = const Rect.fromLTWH(0, 5, 1000, 10);
          }
        }

        Widget mainText = Text(widget.text, style: shadowStyle);

        if (clipRect != null) {
          return Stack(
            children: [
              Text(widget.text, style: shadowStyle),
              Transform.translate(
                offset: Offset(shiftX, shiftY),
                child: ClipRect(
                  clipper: _GlitchClipper(clipRect),
                  child: Text(widget.text, style: shadowStyle),
                ),
              ),
            ],
          );
        }

        return Transform.translate(
          offset: Offset(shiftX, shiftY),
          child: mainText,
        );
      },
    );
  }
}

class _GlitchClipper extends CustomClipper<Rect> {
  final Rect rect;
  _GlitchClipper(this.rect);
  @override
  Rect getClip(Size size) => rect;
  @override
  bool shouldReclip(_GlitchClipper oldClipper) => rect != oldClipper.rect;
}