// lib/models/game.dart

class Game {
  final int id;
  final String name;
  final String genre;
  final String rating;
  final double price;
  final double? originalPrice;
  final String? badge; // 'new', 'sale', 'hot', 'free', null
  final String emoji;
  final String bgGradient;
  final String cover;
  final String developer;
  final String publisher;
  final String released;
  final List<String> platforms;
  final String size;
  final String desc;
  final List<String> tags;
  final String trailerYT;
  final List<GameScreenshot> screenshots;
  final SystemRequirements requirements;
  final bool isFree;

  const Game({
    required this.id,
    required this.name,
    required this.genre,
    required this.rating,
    required this.price,
    this.originalPrice,
    this.badge,
    required this.emoji,
    required this.bgGradient,
    required this.cover,
    required this.developer,
    required this.publisher,
    required this.released,
    required this.platforms,
    required this.size,
    required this.desc,
    required this.tags,
    required this.trailerYT,
    required this.screenshots,
    required this.requirements,
    required this.isFree,
  });
}

class GameScreenshot {
  final String url;
  final String label;
  final String emoji;

  const GameScreenshot({required this.url, required this.label, required this.emoji});
}

class SystemRequirements {
  final RequirementSpecs min;
  final RequirementSpecs rec;

  const SystemRequirements({required this.min, required this.rec});
}

class RequirementSpecs {
  final String os;
  final String cpu;
  final String gpu;
  final String ram;
  final String storage;

  const RequirementSpecs({
    required this.os,
    required this.cpu,
    required this.gpu,
    required this.ram,
    required this.storage,
  });
}