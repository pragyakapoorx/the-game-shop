import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../models/game.dart';
import '../../providers/cart_provider.dart';
import '../../providers/library_provider.dart';
import '../../core/theme/cyber_colors.dart';
import '../../core/clippers/chamfer_clipper.dart';

class GameCard extends ConsumerStatefulWidget {
  final Game game;
  const GameCard({super.key, required this.game});

  @override
  ConsumerState<GameCard> createState() => _GameCardState();
}

class _GameCardState extends ConsumerState<GameCard> {
  bool _isHovered = false;
  Offset _mousePos = Offset.zero;

  @override
  Widget build(BuildContext context) {
    final cart = ref.watch(cartProvider);
    final library = ref.watch(libraryProvider);

    final inCart = cart.contains(widget.game.id);
    final isOwned = library.owned.contains(widget.game.id);
    final isWishlisted = library.wishlist.contains(widget.game.id);

    // Calculate 3D tilt
    final tiltX = _isHovered ? (_mousePos.dy - 100) / 100 * -8 : 0.0;
    final tiltY = _isHovered ? (_mousePos.dx - 100) / 100 * 8 : 0.0;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      onHover: (e) => setState(() => _mousePos = e.localPosition),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => context.push('/game/${widget.game.id}'),
        child: TweenAnimationBuilder(
          duration: const Duration(milliseconds: 150),
          tween: Tween<double>(begin: 0, end: _isHovered ? 1 : 0),
          builder: (context, val, child) {
            return Transform(
              transform: Matrix4.identity()
                ..setEntry(3, 2, 0.001) // perspective
                ..rotateX(tiltX * val * 0.0174533)
                ..rotateY(tiltY * val * 0.0174533)
                ..scale(1.0 + (0.02 * val)),
              alignment: Alignment.center,
              child: ClipPath(
                clipper: ChamferClipper(chamferSize: 10),
                child: Container(
                  decoration: BoxDecoration(
                    color: CyberColors.surface,
                    border: Border.all(
                      color: _isHovered ? CyberColors.green : CyberColors.border,
                    ),
                    boxShadow: _isHovered ? CyberColors.greenGlow : null,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Thumbnail Area
                      Expanded(
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            Image.network(widget.game.cover, fit: BoxFit.cover),
                            // Gradient Overlay
                            Container(
                              decoration: const BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [Colors.transparent, CyberColors.surface],
                                  stops: [0.45, 1.0],
                                ),
                              ),
                            ),
                            // Badge
                            if (widget.game.badge != null)
                              Positioned(
                                top: 8,
                                left: 8,
                                child: _buildBadge(widget.game.badge!),
                              ),
                            // Wishlist Button
                            Positioned(
                              top: 8,
                              right: 8,
                              child: AnimatedOpacity(
                                opacity: (_isHovered || isWishlisted) ? 1.0 : 0.0,
                                duration: const Duration(milliseconds: 150),
                                child: IconButton(
                                  icon: Text(isWishlisted ? '❤️' : '🤍', style: const TextStyle(fontSize: 12)),
                                  onPressed: () => ref.read(libraryProvider.notifier).toggleWishlist(widget.game.id),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Details Area
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(widget.game.genre.toUpperCase(), style: const TextStyle(color: CyberColors.cyan, fontSize: 10, fontFamily: 'Share Tech Mono')),
                                const SizedBox(width: 8),
                                Text('★ ${widget.game.rating}', style: const TextStyle(color: CyberColors.green, fontSize: 10, fontWeight: FontWeight.bold)),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Text(
                              widget.game.name,
                              style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 12),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                _buildPrice(),
                                _buildActionButton(isOwned, inCart),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildBadge(String badge) {
    Color bg = CyberColors.green;
    Color text = Colors.black;
    if (badge == 'sale') bg = CyberColors.magenta;
    if (badge == 'hot') bg = CyberColors.cyan;
    if (badge == 'new') { bg = Colors.black87; text = CyberColors.green; }

    return ClipPath(
      clipper: ChamferClipper(chamferSize: 4),
      child: Container(
        color: bg,
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
        child: Text(
          badge.toUpperCase(),
          style: TextStyle(color: text, fontSize: 9, fontWeight: FontWeight.bold, fontFamily: 'Share Tech Mono'),
        ),
      ),
    );
  }

  Widget _buildPrice() {
    if (widget.game.isFree) return const Text('FREE', style: TextStyle(color: CyberColors.cyan, fontSize: 12, fontWeight: FontWeight.bold));
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.game.originalPrice != null)
          Text('\$${widget.game.originalPrice}', style: const TextStyle(color: CyberColors.text3, fontSize: 10, decoration: TextDecoration.lineThrough)),
        Text('\$${widget.game.price}', style: const TextStyle(color: CyberColors.green, fontSize: 14, fontWeight: FontWeight.bold)),
      ],
    );
  }

  Widget _buildActionButton(bool isOwned, bool inCart) {
    String label = isOwned ? '✓ OWNED' : (inCart ? '✓ IN CART' : (widget.game.isFree ? 'GET FREE' : '+ CART'));
    Color borderColor = isOwned ? CyberColors.magenta : (inCart ? CyberColors.cyan : CyberColors.green.withOpacity(0.3));
    Color textColor = isOwned ? CyberColors.magenta : (inCart ? CyberColors.cyan : CyberColors.green);

    return GestureDetector(
      onTap: () {
        if (!isOwned && !inCart) ref.read(cartProvider.notifier).addToCart(widget.game.id);
      },
      child: ClipPath(
        clipper: ChamferClipper(chamferSize: 4),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
          decoration: BoxDecoration(
            border: Border.all(color: borderColor),
            color: inCart ? CyberColors.cyan.withOpacity(0.1) : Colors.transparent,
          ),
          child: Text(label, style: TextStyle(color: textColor, fontSize: 10, fontFamily: 'Share Tech Mono')),
        ),
      ),
    );
  }
}