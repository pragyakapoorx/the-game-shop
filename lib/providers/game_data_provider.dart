// lib/providers/game_data_provider.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/game.dart';

final gamesProvider = Provider<List<Game>>((ref) {
  return const [
    Game(
      id: 1,
      name: "Baldur's Gate 3",
      genre: "RPG",
      rating: "4.9",
      price: 59.99,
      badge: "hot",
      emoji: "🎲",
      bgGradient: "linear-gradient(135deg,#0d0a1e,#1a1040)",
      cover: "https://cdn.akamai.steamstatic.com/steam/apps/1086940/header.jpg",
      developer: "Larian Studios",
      publisher: "Larian Studios",
      released: "August 3, 2023",
      platforms: ["PC", "PS5", "Xbox Series X", "Mac"],
      size: "150 GB",
      desc: "Gather your party and return to the Forgotten Realms in a tale of fellowship and betrayal...",
      tags: ["Turn-Based", "D&D", "Multiplayer", "Open World", "Story Rich", "Co-op", "Fantasy", "RPG"],
      trailerYT: "1T22wNvoNiU",
      isFree: false,
      screenshots: [
        GameScreenshot(url: "https://shared.akamai.steamstatic.com/store_item_assets/steam/apps/1086940/ss_b63cfde456e5a81dd52e0e39706e5d12bdabcf2b.600x338.jpg", label: "Character Creation", emoji: "🎭"),
      ],
      requirements: SystemRequirements(
        min: RequirementSpecs(os: "Windows 10 64-bit", cpu: "Intel i5-4690 / AMD FX 8350", gpu: "NVIDIA GTX 970 / RX 480", ram: "8 GB RAM", storage: "150 GB SSD"),
        rec: RequirementSpecs(os: "Windows 10 64-bit", cpu: "Intel i7 8700K / AMD r5 3600", gpu: "NVIDIA RTX 2060 Super / RX 5700 XT", ram: "16 GB RAM", storage: "150 GB SSD"),
      ),
    ),
    // TODO: Paste the remaining 14 games here following this format!
  ];
});

// Helper provider to safely get a game by its ID without crashing!
final gameByIdProvider = Provider.family<Game?, int>((ref, id) {
  final games = ref.watch(gamesProvider);

  // Safe way to check without throwing "Bad state: No element"
  final matches = games.where((g) => g.id == id);
  return matches.isNotEmpty ? matches.first : null;
});