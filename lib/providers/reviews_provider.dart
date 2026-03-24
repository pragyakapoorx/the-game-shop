import 'package:flutter_riverpod/flutter_riverpod.dart';

class Review {
  final String username;
  final int stars;
  final String text;
  final String date;
  final int helpful;
  final bool verifiedOwner;
  final bool hasVotedHelpful;

  Review({
    required this.username,
    required this.stars,
    required this.text,
    required this.date,
    this.helpful = 0,
    this.verifiedOwner = true,
    this.hasVotedHelpful = false,
  });
}

class ReviewsNotifier extends StateNotifier<Map<int, List<Review>>> {
  ReviewsNotifier() : super({});

  void addReview(int gameId, Review review) {
    final currentReviews = state[gameId] ?? [];
    state = {
      ...state,
      gameId: [review, ...currentReviews],
    };
  }

  // CHANGED: Now toggles the helpful vote on and off
  void toggleHelpful(int gameId, int reviewIndex) {
    if (state[gameId] == null) return;
    final reviews = List<Review>.from(state[gameId]!);
    final old = reviews[reviewIndex];

    reviews[reviewIndex] = Review(
      username: old.username,
      stars: old.stars,
      text: old.text,
      date: old.date,
      // If they already voted, subtract 1. Otherwise, add 1.
      helpful: old.hasVotedHelpful ? old.helpful - 1 : old.helpful + 1,
      verifiedOwner: old.verifiedOwner,
      // Flip the boolean
      hasVotedHelpful: !old.hasVotedHelpful,
    );

    state = {...state, gameId: reviews};
  }
}

final reviewsProvider = StateNotifierProvider<ReviewsNotifier, Map<int, List<Review>>>((ref) {
  return ReviewsNotifier();
});