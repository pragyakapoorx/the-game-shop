import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/cyber_colors.dart';
import '../../../core/clippers/chamfer_clipper.dart';
import '../../../providers/game_data_provider.dart';
import '../../../shared/buttons/cyber_button.dart';
import '../../../shared/widgets/cyber_glitch_text.dart';

class HeroSection extends ConsumerStatefulWidget {
  const HeroSection({super.key});

  @override
  ConsumerState<HeroSection> createState() => _HeroSectionState();
}

class _HeroSectionState extends ConsumerState<HeroSection> {
  final List<int> _featuredIds = [1, 10, 11, 2, 8];
  int _currentIndex = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 6), (timer) {
      setState(() {
        _currentIndex = (_currentIndex + 1) % _featuredIds.length;
      });
    });
  }

  void _setIndex(int index) {
    setState(() => _currentIndex = index);
    _startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width > 900;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 56),
      child: isDesktop
          ? Row(
        children: [
          Expanded(child: _buildHeroText(context)),
          const SizedBox(width: 48),
          Expanded(child: _buildFeaturedCard(context)),
        ],
      )
          : Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeroText(context),
          const SizedBox(height: 48),
          _buildFeaturedCard(context),
        ],
      ),
    );
  }

  Widget _buildHeroText(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Pill
        ClipPath(
          clipper: ChamferClipper(chamferSize: 4),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            decoration: BoxDecoration(
              color: CyberColors.green.withOpacity(0.06),
              border: Border.all(color: CyberColors.green.withOpacity(0.3)),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 6, height: 6,
                  // REMOVED CONST HERE
                  decoration: BoxDecoration(color: CyberColors.green, boxShadow: CyberColors.greenGlow),
                ),
                const SizedBox(width: 8),
                const Text('TOP TITLES AVAILABLE NOW', style: TextStyle(color: CyberColors.green, fontSize: 10, fontFamily: 'Share Tech Mono', letterSpacing: 2)),
              ],
            ),
          ),
        ),
        const SizedBox(height: 20),

        // --- GLITCH TEXT HEADER ---
        const CyberGlitchText(
          text: 'LEVEL UP',
          style: TextStyle(fontFamily: 'Orbitron', fontSize: 48, fontWeight: FontWeight.w900, height: 1.1),
        ),
        const Text(
          'YOUR GAME.',
          style: TextStyle(fontFamily: 'Orbitron', fontSize: 48, fontWeight: FontWeight.w900, height: 1.1, color: CyberColors.text),
        ),
        // --------------------------

        const SizedBox(height: 16),
        const Text(
          '> The best games at the best prices. Instant digital delivery on every platform.',
          style: TextStyle(color: CyberColors.text2, fontSize: 14, height: 1.5),
        ),
        const SizedBox(height: 32),
        Wrap(
          spacing: 16,
          runSpacing: 16,
          children: [
            CyberButton(text: 'Browse Games', onPressed: () {}),
            CyberButton(
                text: 'View Cart',
                variant: CyberButtonVariant.outline,
                hoverTextColor: Colors.black,
                onPressed: () => context.go('/cart')
            ),
          ],
        )
      ],
    );
  }

  Widget _buildFeaturedCard(BuildContext context) {
    final gameId = _featuredIds[_currentIndex];
    final game = ref.watch(gameByIdProvider(gameId));
    if (game == null) return const SizedBox.shrink();

    return GestureDetector(
      onTap: () => context.push('/game/${game.id}'),
      child: ClipPath(
        clipper: ChamferClipper(chamferSize: 10),
        child: Container(
          height: 340,
          decoration: BoxDecoration(
            border: Border.all(color: CyberColors.border),
          ),
          child: Stack(
            fit: StackFit.expand,
            children: [
              // Crossfading Background
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 600),
                child: Image.network(
                  game.cover,
                  key: ValueKey(game.id),
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: double.infinity,
                ),
              ),
              // Dark Gradient Shade
              Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [CyberColors.bg2, Colors.transparent],
                    stops: [0.0, 0.6],
                  ),
                ),
              ),
              // Game Info
              Positioned(
                bottom: 24,
                left: 24,
                right: 24,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // REMOVED CONST HERE
                    Text(game.genre.toUpperCase(), style: TextStyle(color: CyberColors.cyan, fontFamily: 'Share Tech Mono', fontSize: 10, letterSpacing: 3, shadows: CyberColors.cyanGlow)),
                    const SizedBox(height: 6),
                    Text(game.name.toUpperCase(), style: const TextStyle(fontFamily: 'Orbitron', fontSize: 20, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        // REMOVED CONST HERE
                        Text(game.isFree ? 'FREE' : '\$${game.price}', style: TextStyle(fontFamily: 'JetBrains Mono', fontSize: 20, fontWeight: FontWeight.bold, color: CyberColors.green, shadows: CyberColors.greenGlow)),
                        if (game.originalPrice != null) ...[
                          const SizedBox(width: 8),
                          Text('\$${game.originalPrice}', style: const TextStyle(color: CyberColors.text3, decoration: TextDecoration.lineThrough)),
                        ]
                      ],
                    ),
                  ],
                ),
              ),
              // Dots
              Positioned(
                bottom: 24,
                right: 24,
                child: Row(
                  children: List.generate(_featuredIds.length, (i) {
                    final isActive = i == _currentIndex;
                    return GestureDetector(
                      onTap: () => _setIndex(i),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        margin: const EdgeInsets.only(left: 6),
                        width: isActive ? 20 : 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: isActive ? CyberColors.green : CyberColors.green.withOpacity(0.15),
                          border: Border.all(color: isActive ? CyberColors.green : CyberColors.green.withOpacity(0.3)),
                        ),
                      ),
                    );
                  }),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}