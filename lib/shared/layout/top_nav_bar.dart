import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart'; // Added for context.go
import '../../core/theme/cyber_colors.dart';
import '../../core/clippers/chamfer_clipper.dart';
import '../../providers/cart_provider.dart';
import '../../providers/library_provider.dart';
import '../../providers/db_sync_provider.dart';
import '../buttons/nav_link.dart';
import 'hud_ticker.dart';

class TopNavBar extends ConsumerWidget {
  const TopNavBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartCount = ref.watch(cartProvider).length;
    final libraryState = ref.watch(libraryProvider);
    final libraryCount = libraryState.owned.length + libraryState.wishlist.length;
    final dbState = ref.watch(dbSyncProvider);

    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          height: 60,
          padding: const EdgeInsets.symmetric(horizontal: 24),
          decoration: BoxDecoration(
            color: CyberColors.bg.withOpacity(0.85),
            border: const Border(bottom: BorderSide(color: CyberColors.border)),
          ),
          child: Row(
            children: [
              // --- UPDATED CLICKABLE LOGO ---
              GestureDetector(
                onTap: () => context.go('/store'),
                child: MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(text: 'THEGAME', style: TextStyle(color: CyberColors.green, shadows: CyberColors.greenGlow)),
                        TextSpan(text: 'SHOP', style: TextStyle(color: CyberColors.cyan, shadows: CyberColors.cyanGlow)),
                      ],
                    ),
                    style: const TextStyle(fontFamily: 'Orbitron', fontSize: 16, fontWeight: FontWeight.w800, letterSpacing: 2),
                  ),
                ),
              ),
              const SizedBox(width: 32),
              if (MediaQuery.of(context).size.width > 900) const Expanded(child: HudTicker()),
              const Spacer(),
              const NavLink(title: 'Store', route: '/store'),
              NavLink(title: 'Library', route: '/library', badgeCount: libraryCount),
              NavLink(title: 'Cart', route: '/cart', badgeCount: cartCount),
              const NavLink(title: 'Orders', route: '/orders'),
              const SizedBox(width: 16),
              _buildDbChip(dbState),
              const SizedBox(width: 12),
              _buildAvatar(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDbChip(DbSyncState state) {
    final isSaving = state == DbSyncState.saving;
    return ClipPath(
      clipper: ChamferClipper(chamferSize: 4),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        color: CyberColors.surface,
        child: Row(
          children: [
            Container(width: 6, height: 6, decoration: BoxDecoration(color: isSaving ? CyberColors.cyan : CyberColors.green, boxShadow: isSaving ? CyberColors.cyanGlow : CyberColors.greenGlow)),
            const SizedBox(width: 6),
            Text(isSaving ? 'SAVING...' : 'CONNECTED', style: const TextStyle(fontFamily: 'Share Tech Mono', fontSize: 10, color: CyberColors.text3, letterSpacing: 1))
          ],
        ),
      ),
    );
  }

  Widget _buildAvatar() {
    return ClipPath(
      clipper: ChamferClipper(chamferSize: 4),
      child: Container(
        width: 34, height: 34,
        decoration: BoxDecoration(color: CyberColors.surface2, border: Border.all(color: CyberColors.green), boxShadow: CyberColors.greenGlow),
        alignment: Alignment.center,
        child: const Text('TG', style: TextStyle(fontFamily: 'Share Tech Mono', color: CyberColors.green, fontSize: 12)),
      ),
    );
  }
}