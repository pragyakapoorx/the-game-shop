import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
// 1. ADD THIS IMPORT 👇
import '../../models/game.dart';
import '../../core/theme/cyber_colors.dart';
import '../../core/clippers/chamfer_clipper.dart';
import '../../providers/library_provider.dart';
import '../../providers/game_data_provider.dart';
import '../../shared/buttons/cyber_button.dart';
import 'widgets/library_card.dart';

class LibraryScreen extends ConsumerStatefulWidget {
  const LibraryScreen({super.key});

  @override
  ConsumerState<LibraryScreen> createState() => _LibraryScreenState();
}

class _LibraryScreenState extends ConsumerState<LibraryScreen> {
  String _activeTab = 'all';

  @override
  Widget build(BuildContext context) {
    final library = ref.watch(libraryProvider);
    final games = ref.watch(gamesProvider);

    final ownedGames = games.where((g) => library.owned.contains(g.id)).toList();
    final wishGames = games.where((g) => library.wishlist.contains(g.id)).toList();

    return Scaffold(
      backgroundColor: CyberColors.bg,
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.fromLTRB(48, 48, 48, 32),
              decoration: const BoxDecoration(
                color: CyberColors.bg2,
                border: Border(bottom: BorderSide(color: CyberColors.border)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 2. REMOVED 'const' HERE 👇
                  Text(
                      'MY LIBRARY',
                      style: TextStyle(
                          fontFamily: 'Orbitron',
                          fontSize: 28,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 3,
                          color: CyberColors.green,
                          shadows: CyberColors.greenGlow
                      )
                  ),
                  const SizedBox(height: 6),
                  const Text('> Your owned games and saved wishlist — all in one place.', style: TextStyle(fontFamily: 'JetBrains Mono', fontSize: 13, color: CyberColors.text2)),
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      _buildTab('All', 'all', ownedGames.length + wishGames.length),
                      _buildTab('My Games', 'owned', ownedGames.length),
                      _buildTab('Wishlist', 'wish', wishGames.length),
                    ],
                  )
                ],
              ),
            ),
          ),

          if (_activeTab == 'all' || _activeTab == 'owned') ...[
            if (ownedGames.isNotEmpty)
              _buildSectionHeader('MY GAMES')
            else if (_activeTab == 'owned')
              _buildEmptyState('🎮', 'No games yet', 'Purchase games to see them here'),

            if (ownedGames.isNotEmpty)
              _buildGrid(ownedGames, true),
          ],

          if (_activeTab == 'all' || _activeTab == 'wish') ...[
            if (wishGames.isNotEmpty)
              _buildSectionHeader('WISHLIST')
            else if (_activeTab == 'wish')
              _buildEmptyState('❤️', 'Wishlist is empty', 'Heart games to save them here'),

            if (wishGames.isNotEmpty)
              _buildGrid(wishGames, false),
          ],

          if (_activeTab == 'all' && ownedGames.isEmpty && wishGames.isEmpty)
            _buildEmptyState('📚', 'Library is empty', 'Buy or wishlist games to build your collection'),

          const SliverPadding(padding: EdgeInsets.only(bottom: 64)),
        ],
      ),
    );
  }

  Widget _buildTab(String label, String id, int count) {
    final isOn = _activeTab == id;
    return GestureDetector(
      onTap: () => setState(() => _activeTab = id),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
        decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: isOn ? CyberColors.green : Colors.transparent, width: 2)),
        ),
        child: Row(
          children: [
            // 3. REMOVED 'const' HERE 👇
            Text(
                label.toUpperCase(),
                style: TextStyle(
                    fontFamily: 'Share Tech Mono',
                    fontSize: 10,
                    letterSpacing: 2,
                    color: isOn ? CyberColors.green : CyberColors.text3,
                    shadows: isOn ? CyberColors.greenGlow : null
                )
            ),
            const SizedBox(width: 6),
            ClipPath(
              clipper: ChamferClipper(chamferSize: 4),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                color: CyberColors.surface2,
                child: Text(count.toString(), style: const TextStyle(fontSize: 9, color: CyberColors.text)),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(48, 36, 48, 18),
        child: Row(
          children: [
            // 4. REMOVED 'const' HERE 👇
            Text(
                title,
                style: TextStyle(
                    fontFamily: 'Share Tech Mono',
                    fontSize: 10,
                    letterSpacing: 3,
                    color: CyberColors.cyan,
                    shadows: CyberColors.cyanGlow
                )
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Container(height: 1, decoration: const BoxDecoration(gradient: LinearGradient(colors: [CyberColors.cyan, Colors.transparent]))),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildGrid(List<Game> gamesList, bool isOwned) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 48),
      sliver: SliverGrid(
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 220,
          mainAxisSpacing: 14,
          crossAxisSpacing: 14,
          childAspectRatio: 0.8,
        ),
        delegate: SliverChildBuilderDelegate(
              (context, index) => LibraryCard(game: gamesList[index], isOwned: isOwned),
          childCount: gamesList.length,
        ),
      ),
    );
  }

  Widget _buildEmptyState(String icon, String title, String sub) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 24),
        child: Column(
          children: [
            Text(icon, style: TextStyle(fontSize: 48, color: CyberColors.text3.withOpacity(0.3))),
            const SizedBox(height: 14),
            Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            const SizedBox(height: 4),
            Text(sub, style: const TextStyle(fontSize: 13, color: CyberColors.text3)),
            const SizedBox(height: 16),
            CyberButton(text: 'BROWSE STORE', onPressed: () => context.go('/store')),
          ],
        ),
      ),
    );
  }
}