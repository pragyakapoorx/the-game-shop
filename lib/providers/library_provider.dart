// lib/providers/library_provider.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LibraryState {
  final Set<int> owned;
  final Set<int> wishlist;

  const LibraryState({required this.owned, required this.wishlist});

  LibraryState copyWith({Set<int>? owned, Set<int>? wishlist}) {
    return LibraryState(
      owned: owned ?? this.owned,
      wishlist: wishlist ?? this.wishlist,
    );
  }
}

class LibraryNotifier extends Notifier<LibraryState> {
  @override
  LibraryState build() => const LibraryState(owned: {}, wishlist: {});

  void toggleWishlist(int gameId) {
    final newWishlist = Set<int>.from(state.wishlist);
    if (newWishlist.contains(gameId)) {
      newWishlist.remove(gameId);
    } else {
      newWishlist.add(gameId);
    }
    state = state.copyWith(wishlist: newWishlist);
  }

  void purchaseGames(List<int> gameIds) {
    final newOwned = Set<int>.from(state.owned)..addAll(gameIds);
    final newWishlist = Set<int>.from(state.wishlist)..removeAll(gameIds);

    state = state.copyWith(owned: newOwned, wishlist: newWishlist);
  }
}

final libraryProvider = NotifierProvider<LibraryNotifier, LibraryState>(() {
  return LibraryNotifier();
});