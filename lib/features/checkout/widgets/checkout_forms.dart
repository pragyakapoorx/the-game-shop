import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/cyber_colors.dart';
import '../../../core/clippers/chamfer_clipper.dart';
import '../../../providers/promo_provider.dart';

// --- SHARED WIDGETS ---

class SectionHeader extends StatelessWidget {
  final String step;
  final String title;
  const SectionHeader({super.key, required this.step, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 18),
      child: Row(
        children: [
          ClipPath(
            clipper: ChamferClipper(chamferSize: 4),
            child: Container(
              width: 24, height: 24,
              color: CyberColors.green.withOpacity(0.15),
              alignment: Alignment.center,
              child: Text(step, style: TextStyle(color: CyberColors.green, fontWeight: FontWeight.bold, fontSize: 12, shadows: CyberColors.greenGlow)),
            ),
          ),
          const SizedBox(width: 12),
          Text(title.toUpperCase(), style: const TextStyle(fontFamily: 'Share Tech Mono', color: CyberColors.text2, fontSize: 14, letterSpacing: 3)),
        ],
      ),
    );
  }
}

class CyberInput extends StatelessWidget {
  final String label;
  final String hint;
  final int maxLines;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final int? maxLength;

  const CyberInput({
    super.key,
    required this.label,
    required this.hint,
    this.maxLines = 1,
    this.validator,
    this.keyboardType,
    this.maxLength,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label.toUpperCase(), style: const TextStyle(fontFamily: 'Share Tech Mono', color: CyberColors.text3, fontSize: 10, letterSpacing: 2)),
        const SizedBox(height: 6),
        ClipPath(
          clipper: ChamferClipper(chamferSize: 4),
          child: TextFormField(
            maxLines: maxLines,
            maxLength: maxLength,
            keyboardType: keyboardType,
            validator: validator,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            style: const TextStyle(color: CyberColors.green, fontFamily: 'JetBrains Mono', fontSize: 13),
            decoration: InputDecoration(
              counterText: "", // Hides the max length counter text
              hintText: hint,
              hintStyle: const TextStyle(color: CyberColors.text3),
              filled: true,
              fillColor: CyberColors.bg2,
              border: InputBorder.none,
              errorStyle: const TextStyle(color: CyberColors.red, fontFamily: 'Share Tech Mono', fontSize: 10, letterSpacing: 1),
              contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            ),
          ),
        ),
      ],
    );
  }
}

// --- FORM SECTIONS ---

class ContactForm extends StatelessWidget {
  const ContactForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(color: CyberColors.surface, border: Border.all(color: CyberColors.border)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionHeader(step: '1', title: 'Contact Details'),
          Row(
            children: [
              Expanded(child: CyberInput(label: 'First Name', hint: 'Alex', validator: (v) => v == null || v.isEmpty ? 'REQUIRED' : null)),
              const SizedBox(width: 16),
              Expanded(child: CyberInput(label: 'Last Name', hint: 'Morgan', validator: (v) => v == null || v.isEmpty ? 'REQUIRED' : null)),
            ],
          ),
          const SizedBox(height: 16),
          CyberInput(
            label: 'Email Address',
            hint: 'alex@example.com',
            keyboardType: TextInputType.emailAddress,
            validator: (value) {
              if (value == null || value.isEmpty) return 'EMAIL REQUIRED';
              final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
              if (!emailRegex.hasMatch(value)) {
                return 'INVALID EMAIL FORMAT';
              }
              return null;
            },
          ),
        ],
      ),
    );
  }
}

class PaymentSelector extends StatefulWidget {
  const PaymentSelector({super.key});

  @override
  State<PaymentSelector> createState() => _PaymentSelectorState();
}

class _PaymentSelectorState extends State<PaymentSelector> {
  String _method = 'card';

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(color: CyberColors.surface, border: Border.all(color: CyberColors.border)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionHeader(step: '2', title: 'Payment Method'),
          Row(
            children: [
              Expanded(child: _buildMethodTab('card', '💳', 'CREDIT CARD')),
              const SizedBox(width: 8),
              Expanded(child: _buildMethodTab('paypal', '🅿️', 'PAYPAL')),
              const SizedBox(width: 8),
              Expanded(child: _buildMethodTab('crypto', '₿', 'CRYPTO')),
            ],
          ),
          const SizedBox(height: 16),

          if (_method == 'card') ...[
            CyberInput(
              label: 'Card Number',
              hint: '1234 5678 9012 3456',
              keyboardType: TextInputType.number,
              maxLength: 19,
              validator: (value) {
                if (value == null || value.isEmpty) return 'CARD REQUIRED';
                final digitsOnly = value.replaceAll(RegExp(r'\D'), '');
                if (digitsOnly.length != 16) {
                  return 'MUST BE EXACTLY 16 DIGITS (FOUND ${digitsOnly.length})';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(child: CyberInput(label: 'Expiry', hint: 'MM/YY', maxLength: 5, validator: (v) => v == null || v.isEmpty ? 'REQUIRED' : null)),
                const SizedBox(width: 16),
                Expanded(child: CyberInput(label: 'CVV', hint: '•••', maxLength: 4, keyboardType: TextInputType.number, validator: (v) => v == null || v.isEmpty ? 'REQUIRED' : null)),
              ],
            ),
          ] else if (_method == 'paypal') ...[
            CyberInput(
              label: 'PayPal Email',
              hint: 'paypal@example.com',
              keyboardType: TextInputType.emailAddress,
              validator: (v) => v == null || !v.contains('@') ? 'INVALID PAYPAL EMAIL' : null,
            ),
          ] else ...[
            CyberInput(
              label: 'Wallet Address',
              hint: '0x...',
              validator: (v) => v == null || v.length < 10 ? 'INVALID WALLET ADDRESS' : null,
            ),
            const SizedBox(height: 8),
            const Text('Accepts BTC, ETH, USDC.', style: TextStyle(color: CyberColors.text3, fontSize: 12)),
          ]
        ],
      ),
    );
  }

  Widget _buildMethodTab(String id, String icon, String label) {
    final isOn = _method == id;
    return GestureDetector(
      onTap: () => setState(() => _method = id),
      child: ClipPath(
        clipper: ChamferClipper(chamferSize: 4),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: isOn ? CyberColors.green.withOpacity(0.08) : CyberColors.bg2,
            border: Border.all(color: isOn ? CyberColors.green : CyberColors.border),
          ),
          child: Column(
            children: [
              Text(icon, style: const TextStyle(fontSize: 20)),
              const SizedBox(height: 6),
              Text(label, style: TextStyle(color: isOn ? CyberColors.green : CyberColors.text2, fontFamily: 'Share Tech Mono', fontSize: 10, letterSpacing: 1)),
            ],
          ),
        ),
      ),
    );
  }
}

class PromoSection extends ConsumerStatefulWidget {
  const PromoSection({super.key});

  @override
  ConsumerState<PromoSection> createState() => _PromoSectionState();
}

class _PromoSectionState extends ConsumerState<PromoSection> {
  final _controller = TextEditingController();
  String _msg = '';
  bool _isSuccess = false;

  void _apply() {
    final code = _controller.text.trim();
    if (code.isEmpty) return;

    final success = ref.read(promoProvider.notifier).applyPromo(code);
    setState(() {
      _isSuccess = success;
      if (success) {
        final pct = ref.read(promoProvider.notifier).currentDiscountPercent;
        _msg = '✓ $pct% OFF APPLIED!';
      } else {
        _msg = '✕ INVALID CODE';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(color: CyberColors.surface, border: Border.all(color: CyberColors.border)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionHeader(step: '3', title: 'Promo Code'),
          Row(
            children: [
              Expanded(
                child: ClipPath(
                  clipper: ChamferClipper(chamferSize: 4),
                  child: TextFormField(
                    controller: _controller,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    onChanged: (val) => setState(() { _isSuccess = false; _msg = ''; }),
                    validator: (val) {
                      if (val != null && val.trim().isNotEmpty && !_isSuccess) {
                        return 'APPLY CODE OR CLEAR BOX';
                      }
                      return null;
                    },
                    style: const TextStyle(color: CyberColors.cyan, fontFamily: 'JetBrains Mono', fontSize: 13),
                    decoration: const InputDecoration(
                      hintText: 'Enter code...',
                      hintStyle: TextStyle(color: CyberColors.text3),
                      filled: true,
                      fillColor: CyberColors.bg2,
                      border: InputBorder.none,
                      errorStyle: TextStyle(color: CyberColors.red, fontFamily: 'Share Tech Mono', fontSize: 10, letterSpacing: 1),
                      contentPadding: EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              GestureDetector(
                onTap: _apply,
                child: ClipPath(
                  clipper: ChamferClipper(chamferSize: 4),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                    decoration: BoxDecoration(border: Border.all(color: CyberColors.cyan), color: Colors.transparent),
                    child: const Text('APPLY', style: TextStyle(color: CyberColors.cyan, fontFamily: 'Share Tech Mono', fontSize: 12, letterSpacing: 2)),
                  ),
                ),
              )
            ],
          ),
          if (_msg.isNotEmpty) ...[
            const SizedBox(height: 10),
            Text(_msg, style: TextStyle(color: _isSuccess ? CyberColors.green : CyberColors.red, fontFamily: 'JetBrains Mono', fontSize: 11, fontWeight: FontWeight.bold)),
          ]
        ],
      ),
    );
  }
}