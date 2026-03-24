// lib/providers/promo_provider.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PromoState {
  final Map<String, int> unlockedCodes; // e.g., {'DUNGEON20': 20, 'GAMEON': 15}
  final String? appliedCode;

  const PromoState({required this.unlockedCodes, this.appliedCode});

  PromoState copyWith({Map<String, int>? unlockedCodes, String? appliedCode, bool clearApplied = false}) {
    return PromoState(
      unlockedCodes: unlockedCodes ?? this.unlockedCodes,
      appliedCode: clearApplied ? null : (appliedCode ?? this.appliedCode),
    );
  }
}

class PromoNotifier extends Notifier<PromoState> {
  // Base promos that are always available
  final Map<String, int> _basePromos = {'SAVE10': 10, 'TGS25': 25};

  @override
  PromoState build() => const PromoState(unlockedCodes: {});

  void unlockPromo(String code, int discountPercent) {
    final newCodes = Map<String, int>.from(state.unlockedCodes);
    newCodes[code] = discountPercent;
    state = state.copyWith(unlockedCodes: newCodes);
  }

  bool applyPromo(String code) {
    final upperCode = code.toUpperCase();
    if (_basePromos.containsKey(upperCode) || state.unlockedCodes.containsKey(upperCode)) {
      state = state.copyWith(appliedCode: upperCode);
      return true;
    }
    return false;
  }

  void removePromo() {
    state = state.copyWith(clearApplied: true);
  }

  int get currentDiscountPercent {
    if (state.appliedCode == null) return 0;
    return _basePromos[state.appliedCode] ?? state.unlockedCodes[state.appliedCode] ?? 0;
  }
}

final promoProvider = NotifierProvider<PromoNotifier, PromoState>(() {
  return PromoNotifier();
});