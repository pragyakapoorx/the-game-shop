import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../../core/theme/cyber_colors.dart';
import '../../../core/clippers/chamfer_clipper.dart';
import '../../../providers/library_provider.dart';
import '../../../providers/reviews_provider.dart';
import '../../../models/game.dart';

class ReviewSection extends ConsumerStatefulWidget {
  final Game game;
  const ReviewSection({super.key, required this.game});

  @override
  ConsumerState<ReviewSection> createState() => _ReviewSectionState();
}

class _ReviewSectionState extends ConsumerState<ReviewSection> {
  int _selectedStars = 0;
  final _textController = TextEditingController();
  final _userController = TextEditingController();

  void _submitReview() {
    final text = _textController.text.trim();

    // CHANGED: Now only requires EITHER a star rating OR text
    if (_selectedStars == 0 && text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('⚠️ Please provide a star rating or write a review', style: TextStyle(fontFamily: 'Share Tech Mono'))
      ));
      return;
    }

    final username = _userController.text.trim().isEmpty ? 'Anonymous' : _userController.text.trim();
    final dateStr = DateFormat('MMM d, yyyy').format(DateTime.now());

    final newReview = Review(
      username: username,
      stars: _selectedStars,
      text: text,
      date: dateStr,
    );

    // Save to global state
    ref.read(reviewsProvider.notifier).addReview(widget.game.id, newReview);

    // Reset Form
    setState(() {
      _selectedStars = 0;
      _textController.clear();
      _userController.clear();
    });

    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text('✅ Review posted successfully!', style: TextStyle(fontFamily: 'Share Tech Mono', color: CyberColors.green)),
      backgroundColor: CyberColors.surface2,
    ));
  }

  @override
  void dispose() {
    _textController.dispose();
    _userController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isOwned = ref.watch(libraryProvider).owned.contains(widget.game.id);
    final reviewsMap = ref.watch(reviewsProvider);
    final reviews = reviewsMap[widget.game.id] ?? [];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('COMMUNITY REVIEWS', style: TextStyle(fontFamily: 'Orbitron', fontSize: 18, fontWeight: FontWeight.bold, letterSpacing: 2, color: CyberColors.text)),
            Text('${reviews.length} REVIEW${reviews.length != 1 ? 'S' : ''}', style: const TextStyle(fontFamily: 'Share Tech Mono', color: CyberColors.text3, fontSize: 12)),
          ],
        ),
        const SizedBox(height: 20),

        // FORM OR LOCKED STATE
        isOwned ? _buildReviewForm() : _buildLockedState(),

        const SizedBox(height: 24),

        // REVIEWS LIST
        if (reviews.isEmpty)
          Container(
            padding: const EdgeInsets.all(40),
            alignment: Alignment.center,
            child: const Text('// No reviews yet — be the first!', style: TextStyle(fontFamily: 'JetBrains Mono', fontSize: 13, color: CyberColors.text3)),
          )
        else
          ...reviews.asMap().entries.map((entry) => _buildReviewCard(entry.key, entry.value)),
      ],
    );
  }

  Widget _buildLockedState() {
    return ClipPath(
      clipper: ChamferClipper(chamferSize: 10),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 24),
        decoration: BoxDecoration(
          color: CyberColors.surface,
          border: Border.all(color: CyberColors.border),
        ),
        child: const Column(
          children: [
            Text('🔒', style: TextStyle(fontSize: 32)),
            SizedBox(height: 12),
            Text('Purchase required to leave a review', style: TextStyle(fontFamily: 'JetBrains Mono', fontSize: 13, fontWeight: FontWeight.bold, color: CyberColors.text2)),
            SizedBox(height: 6),
            Text('// Only verified owners can post reviews for this game.', style: TextStyle(fontFamily: 'JetBrains Mono', fontSize: 12, color: CyberColors.text3)),
          ],
        ),
      ),
    );
  }

  Widget _buildReviewForm() {
    return ClipPath(
      clipper: ChamferClipper(chamferSize: 10),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: CyberColors.surface,
          border: Border.all(color: CyberColors.border),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('> ✍️ WRITE A REVIEW', style: TextStyle(fontFamily: 'Share Tech Mono', fontSize: 12, letterSpacing: 2, color: CyberColors.green)),
            const SizedBox(height: 14),

            // Star Picker
            Row(
              children: List.generate(5, (index) {
                final starNum = index + 1;
                final isSelected = starNum <= _selectedStars;
                return GestureDetector(
                  onTap: () => setState(() => _selectedStars = starNum),
                  child: Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Text(
                      isSelected ? '★' : '☆',
                      style: TextStyle(
                        fontSize: 26,
                        color: CyberColors.green,
                        height: 1.0,
                        shadows: isSelected ? CyberColors.greenGlow : null,
                      ),
                    ),
                  ),
                );
              }),
            ),
            const SizedBox(height: 16),

            // Text Input
            TextField(
              controller: _textController,
              maxLines: 4,
              style: const TextStyle(fontFamily: 'JetBrains Mono', fontSize: 13, color: CyberColors.text),
              decoration: const InputDecoration(
                hintText: 'Share your experience with this game (Optional)',
                hintStyle: TextStyle(color: CyberColors.text3),
                filled: true,
                fillColor: CyberColors.bg2,
                enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: CyberColors.border)),
                focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: CyberColors.green)),
              ),
            ),
            const SizedBox(height: 16),

            // Bottom Row (Username & Submit)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Text('\$ Username: ', style: TextStyle(fontFamily: 'JetBrains Mono', fontSize: 12, color: CyberColors.green)),
                    SizedBox(
                      width: 140,
                      child: TextField(
                        controller: _userController,
                        style: const TextStyle(fontFamily: 'JetBrains Mono', fontSize: 12, color: CyberColors.text),
                        decoration: const InputDecoration(
                          hintText: 'Your name',
                          hintStyle: TextStyle(color: CyberColors.text3),
                          filled: true,
                          fillColor: CyberColors.bg2,
                          isDense: true,
                          contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                          enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: CyberColors.border)),
                          focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: CyberColors.green)),
                        ),
                      ),
                    ),
                  ],
                ),
                MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: GestureDetector(
                    onTap: _submitReview,
                    child: ClipPath(
                      clipper: ChamferClipper(chamferSize: 4),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          border: Border.all(color: CyberColors.green),
                        ),
                        child: const Text('POST REVIEW', style: TextStyle(fontFamily: 'Share Tech Mono', fontSize: 11, letterSpacing: 2, color: CyberColors.green)),
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildReviewCard(int index, Review review) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: CyberColors.surface,
        border: Border.all(color: CyberColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    width: 34, height: 34,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(color: CyberColors.green.withOpacity(0.1), border: Border.all(color: CyberColors.green.withOpacity(0.3))),
                    child: Text(review.username.substring(0, 2).toUpperCase(), style: const TextStyle(fontFamily: 'Share Tech Mono', color: CyberColors.green, fontSize: 11)),
                  ),
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(review.username, style: const TextStyle(fontFamily: 'JetBrains Mono', fontSize: 13, fontWeight: FontWeight.bold)),
                          if (review.verifiedOwner) ...[
                            const SizedBox(width: 8),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                              decoration: BoxDecoration(color: CyberColors.green.withOpacity(0.08), border: Border.all(color: CyberColors.green.withOpacity(0.25))),
                              child: const Text('✓ VERIFIED OWNER', style: TextStyle(fontFamily: 'Share Tech Mono', fontSize: 8, letterSpacing: 1.5, color: CyberColors.green)),
                            )
                          ]
                        ],
                      ),
                      const SizedBox(height: 2),
                      Text(review.date, style: const TextStyle(fontFamily: 'Share Tech Mono', fontSize: 9, color: CyberColors.text3, letterSpacing: 1)),
                    ],
                  )
                ],
              ),
              // Handle "only review" case where stars = 0
              if (review.stars > 0)
                Text('★' * review.stars + '☆' * (5 - review.stars), style: TextStyle(color: CyberColors.green, fontSize: 13, letterSpacing: 1, shadows: CyberColors.greenGlow))
              else
                const Text('UNRATED', style: TextStyle(fontFamily: 'Share Tech Mono', color: CyberColors.text3, fontSize: 10, letterSpacing: 1)),
            ],
          ),

          // Handle "only rating" case where text is empty
          if (review.text.isNotEmpty) ...[
            const SizedBox(height: 12),
            Text(review.text, style: const TextStyle(fontFamily: 'JetBrains Mono', fontSize: 13, color: CyberColors.text2, height: 1.7)),
          ],

          const SizedBox(height: 12),
          Row(
            children: [
              Text('${review.helpful} found this helpful', style: const TextStyle(fontFamily: 'JetBrains Mono', fontSize: 11, color: CyberColors.text3)),
              const SizedBox(width: 12),
              GestureDetector(
                // CHANGED: Now calls toggleHelpful, and stays clickable!
                onTap: () => ref.read(reviewsProvider.notifier).toggleHelpful(widget.game.id, index),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    border: Border.all(color: review.hasVotedHelpful ? CyberColors.cyan : CyberColors.border),
                    color: review.hasVotedHelpful ? CyberColors.cyan.withOpacity(0.1) : Colors.transparent,
                  ),
                  child: Text(
                      review.hasVotedHelpful ? '✓ VOTED' : '👍 HELPFUL',
                      style: TextStyle(
                        fontFamily: 'Share Tech Mono',
                        fontSize: 9,
                        letterSpacing: 1,
                        color: review.hasVotedHelpful ? CyberColors.cyan : CyberColors.text3,
                        shadows: review.hasVotedHelpful ? CyberColors.cyanGlow : null,
                      )
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}