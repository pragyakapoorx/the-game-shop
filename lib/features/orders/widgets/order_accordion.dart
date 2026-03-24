import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/cyber_colors.dart';
import '../../../core/clippers/chamfer_clipper.dart';
import '../../../models/order.dart';
import '../../../models/game.dart'; // Make sure Game model is imported!
import '../../../providers/game_data_provider.dart';

class OrderAccordion extends ConsumerStatefulWidget {
  final Order order;
  const OrderAccordion({super.key, required this.order});

  @override
  ConsumerState<OrderAccordion> createState() => _OrderAccordionState();
}

class _OrderAccordionState extends ConsumerState<OrderAccordion> {
  bool _isOpen = false;
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final games = ref.watch(gamesProvider);
    final orderGames = widget.order.gameIds.map((id) => games.firstWhere((g) => g.id == id)).toList();

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: ClipPath(
        clipper: ChamferClipper(chamferSize: 8),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          margin: const EdgeInsets.only(bottom: 12),
          decoration: BoxDecoration(
            color: CyberColors.surface,
            border: Border.all(color: _isHovered || _isOpen ? CyberColors.green.withOpacity(0.3) : CyberColors.border),
          ),
          child: Column(
            children: [
              // HEADER
              GestureDetector(
                onTap: () => setState(() => _isOpen = !_isOpen),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 16),
                  color: _isHovered ? CyberColors.green.withOpacity(0.03) : Colors.transparent,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // REMOVED CONST HERE 👇
                          Text(widget.order.id, style: TextStyle(fontFamily: 'Share Tech Mono', fontSize: 11, color: CyberColors.cyan, letterSpacing: 2, shadows: CyberColors.cyanGlow)),
                          const SizedBox(height: 4),
                          Text(widget.order.date, style: const TextStyle(fontFamily: 'JetBrains Mono', fontSize: 11, color: CyberColors.text3)),
                        ],
                      ),
                      Row(
                        children: [
                          ClipPath(
                            clipper: ChamferClipper(chamferSize: 4),
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                              decoration: BoxDecoration(
                                color: CyberColors.green.withOpacity(0.08),
                                border: Border.all(color: CyberColors.green.withOpacity(0.25)),
                              ),
                              // REMOVED CONST HERE 👇
                              child: Text('✓ COMPLETED', style: TextStyle(fontFamily: 'Share Tech Mono', fontSize: 9, letterSpacing: 1.5, color: CyberColors.green, shadows: CyberColors.greenGlow)),
                            ),
                          ),
                          const SizedBox(width: 16),
                          // REMOVED CONST HERE 👇
                          Text('\$${widget.order.total.toStringAsFixed(2)}', style: TextStyle(fontFamily: 'Orbitron', fontSize: 16, fontWeight: FontWeight.bold, color: CyberColors.green, shadows: CyberColors.greenGlow)),
                          const SizedBox(width: 16),
                          AnimatedRotation(
                            turns: _isOpen ? 0.5 : 0,
                            duration: const Duration(milliseconds: 200),
                            child: const Icon(Icons.keyboard_arrow_down, color: CyberColors.text3, size: 20),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              // BODY (Expands)
              AnimatedSize(
                duration: const Duration(milliseconds: 250),
                curve: Curves.easeInOut,
                child: SizedBox(
                  width: double.infinity,
                  child: _isOpen ? Container(
                    padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 16),
                    decoration: const BoxDecoration(
                      border: Border(top: BorderSide(color: CyberColors.border)),
                    ),
                    child: Column(
                      children: [
                        ...orderGames.map((g) => _buildOrderItem(g)),
                        const SizedBox(height: 14),
                        Container(
                          padding: const EdgeInsets.only(top: 12),
                          decoration: const BoxDecoration(border: Border(top: BorderSide(color: CyberColors.border))),
                          child: Row(
                            children: [
                              _buildMeta('💳', widget.order.payMethod.toUpperCase()),
                              const SizedBox(width: 20),
                              _buildMeta('✉️', widget.order.email),
                              if (widget.order.promo != null) ...[
                                const SizedBox(width: 20),
                                _buildMeta('🏷️', widget.order.promo!),
                              ]
                            ],
                          ),
                        )
                      ],
                    ),
                  ) : const SizedBox.shrink(),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOrderItem(Game g) {
    return Container(
      margin: const EdgeInsets.only(bottom: 6),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: CyberColors.bg2,
        border: Border.all(color: CyberColors.border),
      ),
      child: Row(
        children: [
          ClipPath(
            clipper: ChamferClipper(chamferSize: 4),
            child: SizedBox(width: 40, height: 40, child: Image.network(g.cover, fit: BoxFit.cover)),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text.rich(
              TextSpan(
                children: [
                  TextSpan(text: g.name, style: const TextStyle(fontFamily: 'JetBrains Mono', fontSize: 12, fontWeight: FontWeight.bold, color: CyberColors.text)),
                  TextSpan(text: '  ${g.genre}', style: const TextStyle(fontFamily: 'Share Tech Mono', fontSize: 11, color: CyberColors.text3)),
                ],
              ),
            ),
          ),
          Text(g.isFree ? 'FREE' : '\$${g.price}', style: const TextStyle(fontFamily: 'JetBrains Mono', fontSize: 11, color: CyberColors.green)),
        ],
      ),
    );
  }

  Widget _buildMeta(String icon, String text) {
    return Row(
      children: [
        Text(icon, style: const TextStyle(fontSize: 12)),
        const SizedBox(width: 6),
        Text(text, style: const TextStyle(fontSize: 12, color: CyberColors.text3)),
      ],
    );
  }
}