import 'package:flutter/material.dart';
import '../../core/theme/cyber_colors.dart';
import '../../core/clippers/chamfer_clipper.dart';

enum CyberButtonVariant { glow, outline }

class CyberButton extends StatefulWidget {
  final String text;
  final VoidCallback onPressed;
  final CyberButtonVariant variant;
  final bool isFullWidth;
  final Color? hoverTextColor; // <-- Added override property

  const CyberButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.variant = CyberButtonVariant.glow,
    this.isFullWidth = false,
    this.hoverTextColor, // <-- Added to constructor
  });

  @override
  State<CyberButton> createState() => _CyberButtonState();
}

class _CyberButtonState extends State<CyberButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final isGlow = widget.variant == CyberButtonVariant.glow;

    // Determine colors based on variant and hover state
    final borderColor = isGlow
        ? CyberColors.green
        : (_isHovered ? CyberColors.cyan : CyberColors.border);
    final bgColor = isGlow
        ? (_isHovered ? CyberColors.green : Colors.transparent)
        : Colors.transparent;

    // Apply the custom hoverTextColor if provided, otherwise fallback to defaults
    final textColor = _isHovered
        ? (widget.hoverTextColor ?? (isGlow ? Colors.black : CyberColors.cyan))
        : (isGlow ? CyberColors.green : CyberColors.text2);

    final shadows = isGlow
        ? (_isHovered ? CyberColors.greenGlow : [BoxShadow(color: CyberColors.green.withOpacity(0.5), blurRadius: 5)])
        : (_isHovered ? CyberColors.cyanGlow : null);

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onPressed,
        child: ClipPath(
          clipper: ChamferClipper(chamferSize: 8.0),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 150),
            width: widget.isFullWidth ? double.infinity : null,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            decoration: BoxDecoration(
              color: bgColor,
              border: Border.all(color: borderColor, width: isGlow ? 2 : 1),
              boxShadow: shadows,
            ),
            child: Text(
              widget.text.toUpperCase(),
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Share Tech Mono',
                fontSize: 12,
                letterSpacing: 2,
                color: textColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}