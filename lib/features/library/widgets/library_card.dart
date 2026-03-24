import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/cyber_colors.dart';
import '../../../core/clippers/chamfer_clipper.dart';
import '../../../models/game.dart';
import '../../../providers/cart_provider.dart';
import '../../../providers/library_provider.dart';

class LibraryCard extends ConsumerStatefulWidget {
  final Game game;
  final bool isOwned;

  const LibraryCard({super.key, required this.game, required this.isOwned});

  @override
  ConsumerState<LibraryCard> createState() => _LibraryCardState();
}

class _LibraryCardState extends ConsumerState<LibraryCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final cart = ref.watch(cartProvider);
    final inCart = cart.contains(widget.game.id);

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => context.push('/game/${widget.game.id}'),
        child: ClipPath(
          clipper: ChamferClipper(chamferSize: 8),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            decoration: BoxDecoration(
              color: CyberColors.surface,
              border: Border.all(color: _isHovered ? CyberColors.green : CyberColors.border),
              boxShadow: _isHovered ? CyberColors.greenGlow : null,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Thumbnail
                Expanded(
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      AnimatedScale(
                        scale: _isHovered ? 1.06 : 1.0,
                        duration: const Duration(milliseconds: 400),
                        child: Image.network(widget.game.cover, fit: BoxFit.cover),
                      ),
                      // Status Badge
                      Positioned(
                        bottom: 6, left: 6,
                        child: ClipPath(
                          clipper: ChamferClipper(chamferSize: 4),
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
                            decoration: BoxDecoration(
                              color: widget.isOwned ? CyberColors.green.withOpacity(0.15) : CyberColors.magenta.withOpacity(0.15),
                              border: Border.all(color: widget.isOwned ? CyberColors.green.withOpacity(0.4) : CyberColors.magenta.withOpacity(0.4)),
                            ),
                            child: Text(
                              widget.isOwned ? '✓ OWNED' : '♥ WISHLISTED',
                              style: TextStyle(
                                fontFamily: 'Share Tech Mono',
                                fontSize: 8,
                                letterSpacing: 1,
                                color: widget.isOwned ? CyberColors.green : CyberColors.magenta,
                                shadows: widget.isOwned ? CyberColors.greenGlow : [const Shadow(color: CyberColors.magenta, blurRadius: 4)],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // Body & Actions
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(widget.game.name, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: CyberColors.text), maxLines: 1, overflow: TextOverflow.ellipsis),
                      const SizedBox(height: 2),
                      Text(widget.game.genre.toUpperCase(), style: const TextStyle(fontFamily: 'Share Tech Mono', fontSize: 9, color: CyberColors.text3, letterSpacing: 1)),
                      const SizedBox(height: 10),
                      // Action Buttons
                      Row(
                        children: widget.isOwned
                            ? [
                          _buildBtn('▶ PLAY', CyberColors.green, true, () {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('> LAUNCHING ${widget.game.name.toUpperCase()}...', style: const TextStyle(fontFamily: 'Share Tech Mono', color: CyberColors.green))));
                          }),
                          const SizedBox(width: 5),
                          _buildBtn('DETAILS', CyberColors.text2, false, () => context.push('/game/${widget.game.id}')),
                        ]
                            : [
                          _buildBtn(inCart ? 'IN CART' : '+ CART', inCart ? CyberColors.cyan : CyberColors.text2, false, () {
                            if (!inCart) ref.read(cartProvider.notifier).addToCart(widget.game.id);
                          }),
                          const SizedBox(width: 5),
                          _buildBtn('✕', CyberColors.red, false, () {
                            ref.read(libraryProvider.notifier).toggleWishlist(widget.game.id);
                          }, isDanger: true),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBtn(String label, Color color, bool isPrimary, VoidCallback onTap, {bool isDanger = false}) {
    return Expanded(
      flex: label == '✕' ? 0 : 1,
      child: GestureDetector(
        onTap: () {
          // Prevent the card's onTap from triggering
          onTap();
        },
        child: ClipPath(
          clipper: ChamferClipper(chamferSize: 4),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
            decoration: BoxDecoration(
              color: isPrimary ? color.withOpacity(0.12) : (isDanger ? color.withOpacity(0.08) : CyberColors.surface2),
              border: Border.all(color: isPrimary ? color.withOpacity(0.3) : (isDanger ? color.withOpacity(0.2) : CyberColors.border)),
            ),
            alignment: Alignment.center,
            child: Text(label, style: TextStyle(fontFamily: 'Share Tech Mono', fontSize: 9, color: color, letterSpacing: 1)),
          ),
        ),
      ),
    );
  }
}