import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/cyber_colors.dart';
import '../../../providers/game_data_provider.dart';
import 'widgets/detail_hero.dart';
import 'widgets/detail_body.dart';
import 'widgets/review_section.dart';

class GameDetailScreen extends ConsumerWidget {
  final int gameId;
  const GameDetailScreen({super.key, required this.gameId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Look up the game by ID
    final game = ref.watch(gameByIdProvider(gameId));

    if (game == null) {
      return const Scaffold(
        backgroundColor: CyberColors.bg,
        body: Center(
          child: Text('GAME NOT FOUND // 404', style: TextStyle(color: CyberColors.red, fontFamily: 'Orbitron', fontSize: 24)),
        ),
      );
    }

    return Scaffold(
      backgroundColor: CyberColors.bg,
      body: SingleChildScrollView(
        child: Column(
          children: [
            DetailHero(game: game),
            DetailBody(game: game),

            // --- REVIEWS SECTION ---
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 64),
              child: ReviewSection(game: game),
            ),
          ],
        ),
      ),
    );
  }
}