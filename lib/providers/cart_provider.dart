// lib/providers/cart_provider.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'game_data_provider.dart';

class CartNotifier extends Notifier<List<int>> {
  @override
  List<int> build() => []; // Initial state is an empty cart

  void addToCart(int gameId) {
    if (!state.contains(gameId)) {
      state = [...state, gameId];
    }
  }

  void removeFromCart(int gameId) {
    state = state.where((id) => id != gameId).toList();
  }

  void clearCart() {
    state = [];
  }
}

final cartProvider = NotifierProvider<CartNotifier, List<int>>(() {
  return CartNotifier();
});

// A derived provider that automatically calculates the cart subtotal!
final cartSubtotalProvider = Provider<double>((ref) {
  final cartIds = ref.watch(cartProvider);
  final games = ref.watch(gamesProvider);

  double total = 0;
  for (final id in cartIds) {
    final game = games.firstWhere((g) => g.id == id);
    total += game.price;
  }
  return total;
});