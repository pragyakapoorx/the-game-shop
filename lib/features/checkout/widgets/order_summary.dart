import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/cyber_colors.dart';
import '../../../core/clippers/chamfer_clipper.dart';
import '../../../providers/cart_provider.dart';
import '../../../providers/library_provider.dart';
import '../../../providers/promo_provider.dart';
import '../../../providers/game_data_provider.dart';
import '../../../shared/buttons/cyber_button.dart';
import '../../../models/order.dart';
import '../../../providers/orders_provider.dart';
import 'package:intl/intl.dart'; // Add this package if you want pretty dates, or just use DateTime.now().toString()

class OrderSummary extends ConsumerWidget {
  final GlobalKey<FormState> formKey;
  const OrderSummary({super.key, required this.formKey});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartIds = ref.watch(cartProvider);
    final games = ref.watch(gamesProvider);
    final discountPct = ref.read(promoProvider.notifier).currentDiscountPercent;

    double subtotal = 0;
    final cartGames = cartIds.map((id) => games.firstWhere((g) => g.id == id)).toList();
    for (var g in cartGames) { subtotal += g.price; }

    final discountVal = subtotal * (discountPct / 100);
    final total = (subtotal - discountVal).clamp(0.0, double.infinity);

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(color: CyberColors.surface, border: Border.all(color: CyberColors.border)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('ORDER SUMMARY', style: TextStyle(fontFamily: 'Orbitron', fontSize: 14, fontWeight: FontWeight.bold, letterSpacing: 2)),
          const SizedBox(height: 20),

          // Cart Items List
          ConstrainedBox(
            constraints: const BoxConstraints(maxHeight: 300),
            child: ListView.separated(
              shrinkWrap: true,
              itemCount: cartGames.length,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (context, i) {
                final g = cartGames[i];
                return Row(
                  children: [
                    ClipPath(
                      clipper: ChamferClipper(chamferSize: 4),
                      child: SizedBox(width: 44, height: 44, child: Image.network(g.cover, fit: BoxFit.cover)),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(g.name, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold), maxLines: 1, overflow: TextOverflow.ellipsis),
                          Text(g.genre.toUpperCase(), style: const TextStyle(fontFamily: 'Share Tech Mono', fontSize: 9, color: CyberColors.text3, letterSpacing: 1)),
                        ],
                      ),
                    ),
                    Text(g.isFree ? 'FREE' : '\$${g.price}', style: TextStyle(color: CyberColors.green, fontSize: 13, fontWeight: FontWeight.bold, shadows: CyberColors.greenGlow)),
                    const SizedBox(width: 8),
                    GestureDetector(
                      onTap: () => ref.read(cartProvider.notifier).removeFromCart(g.id),
                      child: const Icon(Icons.close, color: CyberColors.text3, size: 16),
                    )
                  ],
                );
              },
            ),
          ),

          // Math Breakdown
          Divider(color: CyberColors.border, height: 32),
          _mathRow('Subtotal', '\$${subtotal.toStringAsFixed(2)}'),
          if (discountVal > 0) ...[
            const SizedBox(height: 8),
            _mathRow('Discount ($discountPct%)', '-\$${discountVal.toStringAsFixed(2)}', isGreen: true),
          ],
          const SizedBox(height: 8),
          _mathRow('Tax', '\$0.00'),
          Divider(color: CyberColors.border, height: 32),

          // Total & Buy Button
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('TOTAL', style: TextStyle(fontFamily: 'Share Tech Mono', fontSize: 12, letterSpacing: 2, color: CyberColors.text2)),
              Text('\$${total.toStringAsFixed(2)}', style: TextStyle(fontFamily: 'Orbitron', fontSize: 24, fontWeight: FontWeight.bold, color: CyberColors.green, shadows: CyberColors.greenGlow)),
            ],
          ),
          const SizedBox(height: 24),
          CyberButton(
            text: 'PLACE ORDER →',
            isFullWidth: true,

            onPressed: () {
            if (!formKey.currentState!.validate()) {
            // ... (keep the error snackbar)
            return;
            }

            // NEW: Create the Order Object!
            final newOrder = Order(
            id: 'TGS-${DateTime.now().millisecondsSinceEpoch.toString().substring(7)}', // Random looking ID
            date: DateTime.now().toString().split(' ')[0], // Simple date string
            gameIds: List.from(cartIds),
            total: total,
            payMethod: 'Credit Card', // Hardcoded for this example
            email: 'user@cyber.net',
            promo: ref.read(promoProvider).appliedCode,
            );

            // 1. Save to Orders
            ref.read(ordersProvider.notifier).addOrder(newOrder);

            // 2. Add to Library, Clear Cart, Clear Promos
            ref.read(libraryProvider.notifier).purchaseGames(cartIds);
            ref.read(cartProvider.notifier).clearCart();
            ref.read(promoProvider.notifier).removePromo();

              context.go('/library');
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('> ORDER CONFIRMED. GAMES ADDED TO LIBRARY.', style: TextStyle(fontFamily: 'Share Tech Mono', color: CyberColors.green))),
              );
            },
          ),
          const SizedBox(height: 12),
          const Center(child: Text('🔒 Secure checkout · Instant delivery', style: TextStyle(fontSize: 11, color: CyberColors.text3))),
        ],
      ),
    );
  }

  Widget _mathRow(String label, String val, {bool isGreen = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: const TextStyle(color: CyberColors.text2, fontSize: 12)),
        Text(val, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: isGreen ? CyberColors.green : CyberColors.text, shadows: isGreen ? CyberColors.greenGlow : null)),
      ],
    );
  }
}