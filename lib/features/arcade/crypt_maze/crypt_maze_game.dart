import 'dart:math' as math;
import 'package:flame/game.dart';
import 'package:flame/events.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../core/theme/cyber_colors.dart';
import '../utils/sprite_data.dart';

class Point {
  int x, y;
  Point(this.x, this.y);
}

class MazeData {
  bool running = false;
  bool started = false;
  bool won = false;
  int level = 0;
  int lives = 3;
  int gems = 0;
  int totalGems = 0;
  int timer = 90;
  bool hasKey = false;
  String overlayTitle = 'CRYPT MAZE';
  String overlaySub = 'Navigate the dungeon labyrinth\nCollect all gems to earn a code!\n\nWASD or ARROW KEYS to move';
  String log = 'ENTER THE MAZE...';
}

class CryptMazeGame extends FlameGame with KeyboardEvents {
  final VoidCallback onStateChange;
  final MazeData data = MazeData();

  static const int MAZE_W = 15;
  static const int MAZE_H = 10;
  static const double CELL = 32.0;

  late List<List<int>> map;
  Point hero = Point(1, 1);
  List<Point> enemies = [];

  double _enemyTimer = 0;
  double _globalTime = 0;
  double _secondTicker = 0;

  static const List<List<List<int>>> LEVELS = [
    [[1,1,1,1,1,1,1,1,1,1,1,1,1,1,1],[1,0,0,0,1,2,0,0,0,1,0,0,0,0,1],[1,0,1,0,0,0,1,1,0,1,0,1,1,0,1],[1,0,1,1,1,0,0,1,0,0,0,1,2,0,1],[1,2,0,0,1,1,0,1,1,1,0,1,1,0,1],[1,1,1,0,0,0,0,0,0,1,0,0,0,0,1],[1,0,0,0,1,1,1,1,0,1,1,1,1,0,1],[1,0,1,2,0,0,0,1,0,0,0,0,3,0,1],[1,0,1,1,1,1,0,0,0,1,1,1,1,4,1],[1,1,1,1,1,1,1,1,1,1,1,1,1,1,1]],
    [[1,1,1,1,1,1,1,1,1,1,1,1,1,1,1],[1,0,0,0,0,0,1,0,2,0,0,0,1,0,1],[1,0,1,1,1,0,1,0,1,1,1,0,0,0,1],[1,0,1,2,1,0,0,0,0,0,1,1,1,0,1],[1,0,1,0,1,1,1,1,0,0,0,0,1,2,1],[1,0,0,0,0,0,0,1,1,1,1,0,1,0,1],[1,1,1,1,1,0,0,0,0,0,1,0,1,0,1],[1,3,0,0,1,0,1,1,1,0,1,0,0,0,1],[1,4,1,0,0,0,1,0,0,0,1,2,1,0,1],[1,1,1,1,1,1,1,1,1,1,1,1,1,1,1]],
    [[1,1,1,1,1,1,1,1,1,1,1,1,1,1,1],[1,0,1,0,0,0,0,0,1,0,2,0,0,0,1],[1,0,1,0,1,1,1,0,1,0,1,1,1,0,1],[1,0,0,0,1,2,1,0,0,0,0,0,1,0,1],[1,1,1,1,1,0,1,1,1,1,1,0,1,0,1],[1,0,0,0,0,0,0,0,0,0,1,0,1,2,1],[1,0,1,1,1,1,1,1,1,0,1,0,0,0,1],[1,0,0,0,0,0,0,0,1,0,0,0,1,0,1],[1,3,1,1,1,1,1,0,1,1,1,0,4,0,1],[1,1,1,1,1,1,1,1,1,1,1,1,1,1,1]],
  ];

  CryptMazeGame({required this.onStateChange});

  @override
  Color backgroundColor() => Colors.transparent;

  void initMaze(int lv) {
    final src = LEVELS[lv % LEVELS.length];
    map = List.generate(MAZE_H, (y) => List.from(src[y]));

    data.gems = 0;
    data.totalGems = 0;
    data.hasKey = false;
    hero = Point(1, 1);
    data.won = false;
    enemies.clear();

    for (int y = 0; y < MAZE_H; y++) {
      for (int x = 0; x < MAZE_W; x++) {
        if (map[y][x] == 2) data.totalGems++;
      }
    }

    int ex = MAZE_W - 3;
    int ey = MAZE_H ~/ 2;
    enemies.add(Point(map[ey][ex] == 1 ? MAZE_W - 2 : ex, map[ey][ex] == 1 ? 1 : ey));
    if (lv >= 1) enemies.add(Point(1, MAZE_H - 2));
    if (lv >= 2) enemies.add(Point(MAZE_W ~/ 2, MAZE_H ~/ 2));

    data.timer = math.max(45, 90 - lv * 15);
  }

  void startMaze() {
    initMaze(data.level);
    data.running = true;
    data.started = true;
    data.log = 'FIND THE GEMS AND KEY!';
    onStateChange();
  }

  void resetMaze() {
    data.level = 0;
    data.lives = 3;
    data.started = false;
    data.running = false;
    data.overlayTitle = 'CRYPT MAZE';
    data.overlaySub = 'Navigate the dungeon labyrinth\nCollect all gems to earn a code!\n\nWASD or ARROW KEYS to move';
    onStateChange();
  }

  void _log(String msg) {
    data.log = msg.toUpperCase();
    onStateChange();
  }

  @override
  KeyEventResult onKeyEvent(KeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    if (!data.running) return super.onKeyEvent(event, keysPressed);

    if (event is KeyDownEvent) {
      if (event.logicalKey == LogicalKeyboardKey.keyW || event.logicalKey == LogicalKeyboardKey.arrowUp) _moveHero(0, -1);
      else if (event.logicalKey == LogicalKeyboardKey.keyS || event.logicalKey == LogicalKeyboardKey.arrowDown) _moveHero(0, 1);
      else if (event.logicalKey == LogicalKeyboardKey.keyA || event.logicalKey == LogicalKeyboardKey.arrowLeft) _moveHero(-1, 0);
      else if (event.logicalKey == LogicalKeyboardKey.keyD || event.logicalKey == LogicalKeyboardKey.arrowRight) _moveHero(1, 0);
    }
    return super.onKeyEvent(event, keysPressed);
  }

  void _moveHero(int dx, int dy) {
    int nx = hero.x + dx;
    int ny = hero.y + dy;

    if (nx < 0 || ny < 0 || nx >= MAZE_W || ny >= MAZE_H) return;
    int cell = map[ny][nx];
    if (cell == 1) return;

    if (cell == 3) {
      data.hasKey = true;
      map[ny][nx] = 0;
      _log('Key claimed! Find the exit door!');
    }
    if (cell == 4) {
      if (data.hasKey) {
        _mazeWin();
      } else {
        _log('Door is locked — find the key first!');
      }
      return;
    }
    if (cell == 2) {
      data.gems++;
      map[ny][nx] = 0;
      _log('GEM COLLECTED! (${data.gems}/${data.totalGems})');
    }

    hero.x = nx;
    hero.y = ny;
    _checkEnemyHit();
    onStateChange();
  }

  void _moveEnemies() {
    final dirs = [Point(1, 0), Point(-1, 0), Point(0, 1), Point(0, -1)];
    for (var e in enemies) {
      List<Point> opts = [];
      for (var d in dirs) {
        int nx = e.x + d.x;
        int ny = e.y + d.y;
        if (nx >= 0 && ny >= 0 && nx < MAZE_W && ny < MAZE_H && map[ny][nx] != 1) {
          opts.add(Point(nx, ny));
        }
      }
      if (opts.isEmpty) continue;

      // Pursuit AI: Sort by distance to hero
      opts.sort((a, b) {
        int distA = (a.x - hero.x).abs() + (a.y - hero.y).abs();
        int distB = (b.x - hero.x).abs() + (b.y - hero.y).abs();
        return distA.compareTo(distB);
      });

      Point pick = math.Random().nextDouble() < 0.65 ? opts.first : opts[math.Random().nextInt(opts.length)];
      e.x = pick.x;
      e.y = pick.y;
    }
  }

  void _checkEnemyHit() {
    if (!data.running) return;
    for (var e in enemies) {
      if (e.x == hero.x && e.y == hero.y) _loseLife('CAUGHT BY GHOST!');
    }
  }

  void _loseLife(String reason) {
    if (!data.running) return;
    data.running = false;
    data.lives--;
    if (data.lives <= 0) {
      data.overlayTitle = 'GAME OVER';
      data.overlaySub = '$reason\nAll lives spent...';
    } else {
      data.overlayTitle = reason;
      data.overlaySub = 'Lives: ${data.lives}\nTry again!';
    }
    onStateChange();
  }

  void _mazeWin() {
    data.running = false;
    data.level++;
    if (data.level >= LEVELS.length) {
      data.won = true;
      data.overlayTitle = 'YOU ESCAPED!';
      data.overlaySub = 'ALL CRYPTS CONQUERED!\nYour reward awaits!';
      data.level = 0;
    } else {
      data.overlayTitle = 'LEVEL CLEAR!';
      data.overlaySub = 'Descending deeper...\nLevel ${data.level + 1} of ${LEVELS.length}';
    }
    onStateChange();
  }

  @override
  void update(double dt) {
    if (!data.running) return;
    _globalTime += dt;
    _enemyTimer += dt;
    _secondTicker += dt;

    if (_secondTicker >= 1.0) {
      _secondTicker -= 1.0;
      data.timer--;
      if (data.timer <= 0) _loseLife("TIME'S UP!");
      onStateChange();
    }

    if (_enemyTimer > 0.55) {
      _enemyTimer -= 0.55;
      _moveEnemies();
      _checkEnemyHit();
    }
  }

  void _drawSprite(Canvas canvas, List<String> sprite, double scale, double ox, double oy) {
    final paint = Paint()..style = PaintingStyle.fill;
    for (int row = 0; row < sprite.length; row++) {
      final cols = sprite[row].split('');
      for (int col = 0; col < cols.length; col++) {
        if (cols[col] == '_') continue;
        final color = SpriteData.palette[cols[col]];
        if (color != null) {
          paint.color = color;
          canvas.drawRect(Rect.fromLTWH(ox + col * scale, oy + row * scale, scale, scale), paint);
        }
      }
    }
  }

  @override
  void render(Canvas canvas) {
    if (!data.started) return;

    // --- FIXED SCALING ---
    // We calculate a uniform scale factor to ensure the grid tiles stay perfectly square,
    // and then we translate to center the maze within the container (pillarboxing).
    double logicalWidth = MAZE_W * CELL;
    double logicalHeight = MAZE_H * CELL;
    double scale = math.min(size.x / logicalWidth, size.y / logicalHeight);

    double dx = (size.x - (logicalWidth * scale)) / 2;
    double dy = (size.y - (logicalHeight * scale)) / 2;

    canvas.save();
    canvas.translate(dx, dy);
    canvas.scale(scale, scale);

    // Draw base background for the exact maze bounds
    canvas.drawRect(Rect.fromLTWH(0, 0, logicalWidth, logicalHeight), Paint()..color = const Color(0xFF060404));

    final bgPaint1 = Paint()..color = const Color(0xFF070710);
    final bgPaint2 = Paint()..color = const Color(0xFF0a0a18);
    final wallPaintMain = Paint()..color = const Color(0xFF0d0d1a);
    final wallPaintTop = Paint()..color = const Color(0xFF1a1a2e);
    final wallPaintHighlight = Paint()..color = const Color(0x0F00D4FF);
    final wallPaintShadow = Paint()..color = const Color(0x80000000);
    final tileLinePaint = Paint()..color = const Color(0x0A00D4FF);

    for (int y = 0; y < MAZE_H; y++) {
      for (int x = 0; x < MAZE_W; x++) {
        int cell = map[y][x];
        double px = x * CELL;
        double py = y * CELL;

        if (cell == 1) {
          // Wall styling
          canvas.drawRect(Rect.fromLTWH(px, py, CELL, CELL), wallPaintMain);
          canvas.drawRect(Rect.fromLTWH(px, py, CELL, 2), wallPaintTop);
          canvas.drawRect(Rect.fromLTWH(px, py, 2, CELL), wallPaintTop);
          canvas.drawRect(Rect.fromLTWH(px, py, CELL, 2), wallPaintHighlight);
          canvas.drawRect(Rect.fromLTWH(px, py + CELL - 2, CELL, 2), wallPaintShadow);
          canvas.drawRect(Rect.fromLTWH(px + CELL - 2, py, 2, CELL), wallPaintShadow);
        } else {
          // Floor styling
          canvas.drawRect(Rect.fromLTWH(px, py, CELL, CELL), (x + y) % 2 == 0 ? bgPaint1 : bgPaint2);
          canvas.drawRect(Rect.fromLTWH(px, py, CELL, 1), tileLinePaint);
          canvas.drawRect(Rect.fromLTWH(px, py, 1, CELL), tileLinePaint);

          if (cell == 2) {
            double pulse = math.sin(_globalTime * 3 + x * 0.8 + y * 0.6) * 0.5 + 0.5;
            canvas.drawRect(Rect.fromLTWH(px, py, CELL, CELL), Paint()..color = CyberColors.green.withOpacity(0.2 + pulse * 0.3));
            _drawSprite(canvas, SpriteData.gem, 3.5, px + CELL / 2 - 10, py + CELL / 2 - 10);
          } else if (cell == 3) {
            double bob = math.sin(_globalTime * 4 + x) * 2;
            _drawSprite(canvas, SpriteData.keyItem, 3, px + 2, py + CELL / 2 - 12 + bob);
          } else if (cell == 4) {
            canvas.drawRect(Rect.fromLTWH(px, py, CELL, CELL), Paint()..color = data.hasKey ? CyberColors.green.withOpacity(0.15) : const Color(0x66141428));
            _drawSprite(canvas, SpriteData.door, 2, px + 2, py);
            if (data.hasKey) {
              canvas.drawRect(Rect.fromLTWH(px + 1, py + 1, CELL - 2, CELL - 2), Paint()..style = PaintingStyle.stroke..strokeWidth = 2..color = CyberColors.green.withOpacity(0.4 + math.sin(_globalTime * 5) * 0.4));
            }
          }
        }
      }
    }

    // Enemies
    for (var e in enemies) {
      double bob = math.sin(_globalTime * 4 + e.x) * 1.5;
      canvas.drawRect(Rect.fromLTWH(e.x * CELL + 6, e.y * CELL + CELL - 5, 20, 3), Paint()..color = CyberColors.red.withOpacity(0.25));
      _drawSprite(canvas, SpriteData.skel, 2.5, e.x * CELL + 4, e.y * CELL + 2 + bob);
    }

    // Hero
    double hob = math.sin(_globalTime * 3) * 1.5;
    canvas.drawRect(Rect.fromLTWH(hero.x * CELL + 8, hero.y * CELL + CELL - 5, 16, 3), Paint()..color = CyberColors.cyan.withOpacity(0.2));
    _drawSprite(canvas, SpriteData.mazeHero, 3.5, hero.x * CELL + 4, hero.y * CELL + 2 + hob);

    canvas.restore();
  }
}