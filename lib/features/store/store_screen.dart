import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../shared/cards/game_card.dart';
import '../../core/theme/cyber_colors.dart';
import 'store_providers.dart';
import 'widgets/hero_section.dart';
import 'widgets/store_controls.dart';

class StoreScreen extends ConsumerWidget {
  const StoreScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // We watch the filtered provider. If the user searches or clicks a tab, this updates automatically!
    final games = ref.watch(filteredGamesProvider);

    // Split into paid and free (like your JS)
    final paidGames = games.where((g) => !g.isFree).toList();
    final freeGames = games.where((g) => g.isFree).toList();

    return CustomScrollView(
      slivers: [
        const SliverToBoxAdapter(child: HeroSection()),
        const SliverToBoxAdapter(child: StatsBar()),
        const SliverToBoxAdapter(child: StoreFilters()),

        // --- ALL GAMES GRID ---
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.only(left: 48, right: 48, bottom: 24),
            child: Text.rich(
              TextSpan(
                children: [
                  const TextSpan(text: 'ALL ', style: TextStyle(color: CyberColors.text)),
                  TextSpan(text: 'GAMES', style: TextStyle(color: CyberColors.green, shadows: CyberColors.greenGlow)),
                ],
              ),
              style: const TextStyle(fontFamily: 'Orbitron', fontSize: 18, fontWeight: FontWeight.bold, letterSpacing: 2),
            ),
          ),
        ),

        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 48),
          sliver: SliverGrid(
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 280, // Matches CSS auto-fill minmax(215px) + gap
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              childAspectRatio: 0.75, // Adjust based on your card height
            ),
            delegate: SliverChildBuilderDelegate(
                  (context, index) => GameCard(game: paidGames[index]),
              childCount: paidGames.length,
            ),
          ),
        ),

        // --- FLASH DEAL BANNER PLACEHOLDER ---
        const SliverToBoxAdapter(
          child: SizedBox(height: 64), // We can add the FlashDealBanner widget here later
        ),

        // --- FREE TO PLAY GRID ---
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.only(left: 48, right: 48, bottom: 24),
            child: Text.rich(
              TextSpan(
                children: [
                  const TextSpan(text: 'FREE TO ', style: TextStyle(color: CyberColors.text)),
                  TextSpan(text: 'PLAY', style: TextStyle(color: CyberColors.green, shadows: CyberColors.greenGlow)),
                ],
              ),
              style: const TextStyle(fontFamily: 'Orbitron', fontSize: 18, fontWeight: FontWeight.bold, letterSpacing: 2),
            ),
          ),
        ),

        SliverPadding(
          padding: const EdgeInsets.only(left: 48, right: 48, bottom: 64),
          sliver: SliverGrid(
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 280,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              childAspectRatio: 0.75,
            ),
            delegate: SliverChildBuilderDelegate(
                  (context, index) => GameCard(game: freeGames[index]),
              childCount: freeGames.length,
            ),
          ),
        ),
      ],
    );
  }
}