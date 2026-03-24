import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/cyber_colors.dart';
import '../../../core/clippers/chamfer_clipper.dart';
import '../../../models/game.dart';
import '../../../providers/cart_provider.dart';
import '../../../providers/library_provider.dart';
import '../../../shared/buttons/cyber_button.dart';

class DetailHero extends ConsumerWidget {
  final Game game;
  const DetailHero({super.key, required this.game});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cart = ref.watch(cartProvider);
    final library = ref.watch(libraryProvider);

    final inCart = cart.contains(game.id);
    final isOwned = library.owned.contains(game.id);
    final isWishlisted = library.wishlist.contains(game.id);

    return SizedBox(
      height: 440,
      child: Stack(
        fit: StackFit.expand,
        children: [
          // Blurred Background
          ImageFiltered(
            imageFilter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
            child: Transform.scale(
              scale: 1.1,
              child: Image.network(game.cover, fit: BoxFit.cover),
            ),
          ),
          // Dark Gradient Shade
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [CyberColors.bg.withOpacity(0.5), CyberColors.bg.withOpacity(0.98)],
                stops: const [0.0, 0.8],
              ),
            ),
          ),
          // Content
          Positioned(
            bottom: 40, left: 48, right: 48,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Back Button
                      GestureDetector(
                        onTap: () => context.pop(),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          margin: const EdgeInsets.only(bottom: 18),
                          decoration: BoxDecoration(
                            color: CyberColors.green.withOpacity(0.06),
                            border: Border.all(color: CyberColors.green.withOpacity(0.2)),
                          ),
                          child: const Text('← BACK TO STORE', style: TextStyle(color: CyberColors.green, fontFamily: 'Share Tech Mono', fontSize: 10, letterSpacing: 2)),
                        ),
                      ),
                      // Tags
                      Wrap(
                        spacing: 8, runSpacing: 8,
                        children: [
                          _buildChip(game.genre, CyberColors.cyan),
                          ...game.tags.take(4).map((t) => _buildChip(t, CyberColors.text3, isDark: true)),
                        ],
                      ),
                      const SizedBox(height: 12),
                      // Title
                      Text(game.name.toUpperCase(), style: const TextStyle(fontFamily: 'Orbitron', fontSize: 46, fontWeight: FontWeight.w900, height: 1.05)),
                      const SizedBox(height: 12),
                      // Meta Row
                      Wrap(
                        spacing: 16, runSpacing: 8,
                        children: [
                          Text('★ ${game.rating}', style: TextStyle(color: CyberColors.green, fontFamily: 'JetBrains Mono', fontSize: 13, fontWeight: FontWeight.bold, shadows: CyberColors.greenGlow)),
                          Text('🏢 ${game.developer}', style: const TextStyle(color: CyberColors.text2, fontFamily: 'JetBrains Mono', fontSize: 11)),
                          Text('📅 ${game.released}', style: const TextStyle(color: CyberColors.text2, fontFamily: 'JetBrains Mono', fontSize: 11)),
                        ],
                      ),
                    ],
                  ),
                ),
                // Price & Actions
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    if (game.originalPrice != null)
                      Text('Was \$${game.originalPrice}', style: const TextStyle(color: CyberColors.text3, decoration: TextDecoration.lineThrough, fontFamily: 'JetBrains Mono', fontSize: 12)),
                    Text(game.isFree ? 'FREE' : '\$${game.price}', style: TextStyle(color: CyberColors.green, fontFamily: 'Orbitron', fontSize: 30, fontWeight: FontWeight.bold, shadows: CyberColors.greenGlow)),
                    const SizedBox(height: 12),
                    CyberButton(
                      text: isOwned ? '✓ OWNED' : (inCart ? 'VIEW CART →' : (game.isFree ? 'GET FREE →' : 'ADD TO CART →')),
                      onPressed: () {
                        if (isOwned) return;
                        if (inCart) context.go('/cart');
                        else ref.read(cartProvider.notifier).addToCart(game.id);
                      },
                    ),
                    const SizedBox(height: 10),
                    GestureDetector(
                      onTap: () => ref.read(libraryProvider.notifier).toggleWishlist(game.id),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 9),
                        decoration: BoxDecoration(
                          border: Border.all(color: isWishlisted ? CyberColors.magenta : CyberColors.border),
                          color: isWishlisted ? CyberColors.magenta.withOpacity(0.08) : Colors.transparent,
                        ),
                        child: Text(isWishlisted ? '❤️ WISHLISTED' : '🤍 ADD TO WISHLIST', style: TextStyle(color: isWishlisted ? CyberColors.magenta : CyberColors.text2, fontFamily: 'Share Tech Mono', fontSize: 10, letterSpacing: 1.5)),
                      ),
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildChip(String label, Color color, {bool isDark = false}) {
    return ClipPath(
      clipper: ChamferClipper(chamferSize: 4),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        // Move color and border INSIDE a BoxDecoration!
        decoration: BoxDecoration(
          color: isDark ? CyberColors.surface2 : color.withOpacity(0.08),
          border: Border.all(color: isDark ? CyberColors.border : color.withOpacity(0.25)),
        ),
        child: Text(
            label.toUpperCase(),
            style: TextStyle(
                color: color,
                fontFamily: 'Share Tech Mono',
                fontSize: 9,
                letterSpacing: 2
            )
        ),
      ),
    );
  }
}