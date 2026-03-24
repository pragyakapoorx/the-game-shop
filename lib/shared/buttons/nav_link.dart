import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme/cyber_colors.dart';
import '../../core/clippers/chamfer_clipper.dart';

class NavLink extends StatefulWidget {
  final String title;
  final String route;
  final int badgeCount;

  const NavLink({super.key, required this.title, required this.route, this.badgeCount = 0});

  @override
  State<NavLink> createState() => _NavLinkState();
}

class _NavLinkState extends State<NavLink> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    // Check if the current route matches this link to highlight it
    final currentPath = GoRouterState.of(context).uri.toString();
    final isActive = currentPath.startsWith(widget.route);

    final textColor = isActive || _isHovered ? CyberColors.green : CyberColors.text2;
    final bgColor = isActive
        ? CyberColors.green.withOpacity(0.08)
        : (_isHovered ? CyberColors.green.withOpacity(0.06) : Colors.transparent);

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => context.go(widget.route),
        child: ClipPath(
          clipper: ChamferClipper(chamferSize: 4),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 150),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: bgColor,
              border: Border(
                bottom: BorderSide(
                    color: isActive ? CyberColors.green : Colors.transparent,
                    width: 2
                ),
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  widget.title.toUpperCase(),
                  style: TextStyle(
                    fontFamily: 'Share Tech Mono',
                    fontSize: 12,
                    letterSpacing: 2,
                    color: textColor,
                    shadows: isActive || _isHovered ? CyberColors.greenGlow : null,
                  ),
                ),
                if (widget.badgeCount > 0) ...[
                  const SizedBox(width: 6),
                  ClipPath(
                    clipper: ChamferClipper(chamferSize: 4),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      color: CyberColors.magenta,
                      child: Text(
                        widget.badgeCount.toString(),
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}