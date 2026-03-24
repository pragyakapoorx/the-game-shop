import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/cyber_colors.dart';
import '../../../core/clippers/chamfer_clipper.dart';
import '../../../providers/cart_provider.dart';
import '../../../providers/library_provider.dart';
import '../../../providers/game_data_provider.dart';
import '../store_providers.dart';

class StatsBar extends ConsumerWidget {
  const StatsBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final totalGames = ref.watch(gamesProvider).length;
    final wishlistCount = ref.watch(libraryProvider).wishlist.length;
    final cartCount = ref.watch(cartProvider).length;

    return Container(
      decoration: const BoxDecoration(
        color: CyberColors.bg2,
        border: Border.symmetric(horizontal: BorderSide(color: CyberColors.border)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 48),
      child: Wrap(
        children: [
          _buildStat(totalGames.toString(), 'Games Available'),
          _buildStat('2.4M', 'Active Players'),
          _buildStat(wishlistCount.toString(), 'Your Wishlist'),
          _buildStat(cartCount.toString(), 'In Your Cart', isLast: true),
        ],
      ),
    );
  }

  Widget _buildStat(String number, String label, {bool isLast = false}) {
    return Container(
      width: 200,
      padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 20),
      decoration: BoxDecoration(
        border: isLast ? null : const Border(right: BorderSide(color: CyberColors.border)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(number, style: TextStyle(fontFamily: 'Orbitron', fontSize: 22, fontWeight: FontWeight.bold, color: CyberColors.green, shadows: CyberColors.greenGlow)),
          const SizedBox(height: 4),
          Text(label.toUpperCase(), style: const TextStyle(fontFamily: 'Share Tech Mono', fontSize: 10, color: CyberColors.text3, letterSpacing: 1.5)),
        ],
      ),
    );
  }
}

class StoreFilters extends ConsumerWidget {
  const StoreFilters({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filters = ['All', 'RPG', 'Horror', 'Action', 'Adventure', 'Sandbox', 'Indie', 'Simulation'];
    final selected = ref.watch(selectedFilterProvider);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 24),
      child: Wrap(
        spacing: 16,
        runSpacing: 16,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          // Search Box
          SizedBox(
            width: 300,
            child: ClipPath(
              clipper: ChamferClipper(chamferSize: 8),
              child: TextField(
                onChanged: (val) => ref.read(searchQueryProvider.notifier).state = val,
                style: const TextStyle(color: CyberColors.green, fontFamily: 'JetBrains Mono', fontSize: 13),
                decoration: InputDecoration(
                  hintText: 'Search games, genres, tags...',
                  hintStyle: const TextStyle(color: CyberColors.text3),
                  prefixIcon: const Icon(Icons.search, color: CyberColors.green, size: 18),
                  filled: true,
                  fillColor: CyberColors.surface,
                  enabledBorder: OutlineBorder(borderSide: BorderSide(color: CyberColors.border)),
                  focusedBorder: OutlineBorder(borderSide: BorderSide(color: CyberColors.green)),
                ),
              ),
            ),
          ),

          // Filter Tabs
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: filters.map((f) {
              final isOn = selected == f;
              return GestureDetector(
                onTap: () => ref.read(selectedFilterProvider.notifier).state = f,
                child: ClipPath(
                  clipper: ChamferClipper(chamferSize: 4),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 150),
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                    decoration: BoxDecoration(
                      color: isOn ? CyberColors.green.withOpacity(0.1) : Colors.transparent,
                      border: Border.all(color: isOn ? CyberColors.green : CyberColors.border),
                    ),
                    child: Text(
                      f.toUpperCase(),
                      style: TextStyle(
                        fontFamily: 'Share Tech Mono',
                        fontSize: 10,
                        letterSpacing: 1.5,
                        color: isOn ? CyberColors.green : CyberColors.text3,
                        shadows: isOn ? CyberColors.greenGlow : null,
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}

// A helper class to remove the default rounded corners of Flutter's text field so it works with our Clipper
class OutlineBorder extends InputBorder {
  @override
  final BorderSide borderSide;

  const OutlineBorder({required this.borderSide}) : super(borderSide: borderSide);

  @override
  bool get isOutline => true;

  @override
  InputBorder copyWith({BorderSide? borderSide}) => OutlineBorder(borderSide: borderSide ?? this.borderSide);

  @override
  EdgeInsetsGeometry get dimensions => EdgeInsets.all(borderSide.width);

  @override
  Path getInnerPath(Rect rect, {TextDirection? textDirection}) => Path()..addRect(rect.deflate(borderSide.width));

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) => Path()..addRect(rect);

  @override
  void paint(Canvas canvas, Rect rect, {double? gapStart, double? gapExtent, double? gapPercentage, TextDirection? textDirection}) {
    canvas.drawRect(
        rect,
        Paint()
          ..color = borderSide.color
          ..style = PaintingStyle.stroke
          ..strokeWidth = borderSide.width
    );
  }

  // 👇 This is the missing method Flutter was complaining about!
  @override
  ShapeBorder scale(double t) {
    return OutlineBorder(borderSide: borderSide.scale(t));
  }
}