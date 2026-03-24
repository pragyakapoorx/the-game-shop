import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme/cyber_colors.dart';
import '../../providers/cart_provider.dart';
import '../../shared/buttons/cyber_button.dart';
import 'widgets/checkout_forms.dart';
import 'widgets/order_summary.dart';

class CheckoutScreen extends ConsumerStatefulWidget {
  const CheckoutScreen({super.key});

  @override
  ConsumerState<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends ConsumerState<CheckoutScreen> {
  // This key tracks the validation state of all form fields inside the Form widget
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final cart = ref.watch(cartProvider);

    if (cart.isEmpty) {
      return Scaffold(
        backgroundColor: CyberColors.bg,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('🛒', style: TextStyle(fontSize: 56, color: CyberColors.text3)),
              const SizedBox(height: 16),
              const Text('YOUR CART IS EMPTY', style: TextStyle(fontFamily: 'Orbitron', fontSize: 24, fontWeight: FontWeight.bold, color: CyberColors.text)),
              const SizedBox(height: 8),
              const Text('Add some games first!', style: TextStyle(color: CyberColors.text2)),
              const SizedBox(height: 24),
              CyberButton(text: 'BROWSE STORE', onPressed: () => context.go('/store')),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: CyberColors.bg,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 48),
          // Wrap the entire layout in a Form to validate all sections at once
          child: Form(
            key: _formKey,
            child: LayoutBuilder(
              builder: (context, constraints) {
                final isDesktop = constraints.maxWidth > 900;

                if (isDesktop) {
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Expanded(
                        flex: 6,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('CHECKOUT', style: TextStyle(fontFamily: 'Orbitron', fontSize: 24, fontWeight: FontWeight.bold, color: CyberColors.green, letterSpacing: 2)),
                            SizedBox(height: 32),
                            ContactForm(),
                            PaymentSelector(),
                            PromoSection(),
                          ],
                        ),
                      ),
                      const SizedBox(width: 48),
                      Expanded(
                        flex: 4,
                        // Pass the key to the summary so the button can trigger validation
                        child: OrderSummary(formKey: _formKey),
                      ),
                    ],
                  );
                }

                // Mobile / Tablet Layout
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('CHECKOUT', style: TextStyle(fontFamily: 'Orbitron', fontSize: 24, fontWeight: FontWeight.bold, color: CyberColors.green, letterSpacing: 2)),
                    const SizedBox(height: 32),
                    OrderSummary(formKey: _formKey),
                    const SizedBox(height: 24),
                    const ContactForm(),
                    const PaymentSelector(),
                    const PromoSection(),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}