// lib/features/store/store_providers.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../models/game.dart';
import '../../providers/game_data_provider.dart';

// Tracks the current search text
final searchQueryProvider = StateProvider<String>((ref) => '');

// Tracks the selected genre tab
final selectedFilterProvider = StateProvider<String>((ref) => 'All');

// Automatically filters the games list based on search and tab selection
final filteredGamesProvider = Provider<List<Game>>((ref) {
  final games = ref.watch(gamesProvider);
  final query = ref.watch(searchQueryProvider).toLowerCase();
  final filter = ref.watch(selectedFilterProvider);

  return games.where((g) {
    // 1. Check if it matches the tab filter
    final matchesFilter = filter == 'All' || g.genre == filter || g.tags.contains(filter);

    // 2. Check if it matches the search query
    final matchesQuery = query.isEmpty ||
        g.name.toLowerCase().contains(query) ||
        g.genre.toLowerCase().contains(query) ||
        g.tags.any((t) => t.toLowerCase().contains(query));

    return matchesFilter && matchesQuery;
  }).toList();
});