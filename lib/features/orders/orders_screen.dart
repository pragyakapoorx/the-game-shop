import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme/cyber_colors.dart';
import '../../providers/orders_provider.dart';
import '../../shared/buttons/cyber_button.dart';
import 'widgets/order_accordion.dart';

class OrdersScreen extends ConsumerWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final orders = ref.watch(ordersProvider);

    return Scaffold(
      backgroundColor: CyberColors.bg,
      body: SingleChildScrollView(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 900),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 48),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // REMOVED CONST HERE 👇
                  Text(
                      'ORDER HISTORY',
                      style: TextStyle(
                          fontFamily: 'Orbitron',
                          fontSize: 22,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 3,
                          color: CyberColors.green,
                          shadows: CyberColors.greenGlow
                      )
                  ),
                  const SizedBox(height: 28),

                  if (orders.isEmpty)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 80),
                      child: Center(
                        child: Column(
                          children: [
                            Text('📦', style: TextStyle(fontSize: 52, color: CyberColors.text3.withOpacity(0.3))),
                            const SizedBox(height: 14),
                            const Text('No orders yet', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                            const SizedBox(height: 4),
                            const Text('Your purchase history appears here', style: TextStyle(fontSize: 13, color: CyberColors.text3)),
                            const SizedBox(height: 16),
                            CyberButton(text: 'BROWSE STORE', onPressed: () => context.go('/store')),
                          ],
                        ),
                      ),
                    )
                  else
                    ...orders.map((o) => OrderAccordion(order: o)),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}