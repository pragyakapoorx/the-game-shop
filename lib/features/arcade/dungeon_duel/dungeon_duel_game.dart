import 'dart:math' as math;
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import '../../../../core/theme/cyber_colors.dart';
import '../utils/sprite_data.dart';

// --- DATA MODELS ---

class Monster {
  final String name;
  final List<String> sprite;
  final int maxHp;
  final int minAtk;
  final int maxAtk;
  final int def;
  final String desc;

  Monster(this.name, this.sprite, this.maxHp, this.minAtk, this.maxAtk, this.def, this.desc);
}

class BattleData {
  bool active = false;
  Monster? monster;
  int currentEnemyHp = 0;
  int heroHp = 30;
  int heroMaxHp = 30;
  int potions = 2;
  String turn = 'hero';
  bool locked = false;
  bool over = false;
  bool won = false;
  int round = 1;
  int streak = 0;
  String log = 'SELECT A GAME TO BEGIN...';
}

// --- THE FLAME ENGINE ---

class DungeonDuelGame extends FlameGame {
  final VoidCallback onStateChange;
  final BattleData data = BattleData();
  final _random = math.Random();

  // FIXED: Inline lazy initialization prevents the onGameResize crash!
  late final _PixelSpriteComponent heroSprite = _PixelSpriteComponent(
      spriteArray: SpriteData.hero,
      pixelSize: 4.5,
      flipHorizontal: false
  );

  late final _PixelSpriteComponent monsterSprite = _PixelSpriteComponent(
      spriteArray: SpriteData.dragon,
      pixelSize: 4.5,
      flipHorizontal: true
  )..setOpacity(0.0); // Hidden until battle starts

  final List<Monster> _bestiary = [
    Monster('CAVE TROLL', SpriteData.troll, 30, 3, 7, 1, 'A hulking beast of stone and fury!'),
    Monster('SHADOW WITCH', SpriteData.witch, 25, 4, 9, 0, 'Dark magic crackles around her!'),
    Monster('IRON GOLEM', SpriteData.golem, 45, 2, 6, 3, 'Its armored hide is nearly impenetrable!'),
    Monster('CURSED KNIGHT', SpriteData.knight, 35, 3, 8, 2, 'A fallen warrior bound by dark magic!'),
    Monster('DRAGON WHELP', SpriteData.dragon, 40, 5, 10, 1, 'Even young, its fire burns white-hot!'),
  ];

  DungeonDuelGame({required this.onStateChange});

  @override
  Color backgroundColor() => Colors.transparent;

  @override
  Future<void> onLoad() async {
    add(_BattleFloor());
    add(heroSprite);
    add(monsterSprite);
  }

  @override
  void onGameResize(Vector2 size) {
    super.onGameResize(size);
    // This is now perfectly safe!
    heroSprite.position = Vector2(size.x * 0.22, size.y * 0.55);
    monsterSprite.position = Vector2(size.x * 0.78, size.y * 0.55);
  }

  void _log(String msg) {
    data.log = msg.toUpperCase();
    onStateChange();
  }

  // --- ACTIONS ---

  void startBattle() {
    final m = _bestiary[_random.nextInt(_bestiary.length)];
    data.monster = m;
    data.currentEnemyHp = m.maxHp;
    data.heroHp = 30;
    data.potions = 2;
    data.turn = 'hero';
    data.locked = false;
    data.over = false;
    data.won = false;
    data.active = true;

    monsterSprite.spriteArray = m.sprite;
    monsterSprite.setOpacity(1.0);
    heroSprite.setOpacity(1.0);

    _log('A wild ${m.name} appears! ${m.desc}');
  }

  void flee() {
    data.locked = true;
    onStateChange();

    if (_random.nextDouble() < 0.45) {
      _log('You flee the battle! The dungeon stays sealed.');
      data.over = true;
      data.streak = 0;
      Future.delayed(const Duration(milliseconds: 1200), () => onStateChange());
    } else {
      _log('The monster blocks thy escape!');
      Future.delayed(const Duration(milliseconds: 900), _monsterTurn);
    }
  }

  void heal() {
    if (data.potions <= 0) return;
    data.locked = true;

    int healAmt = _random.nextInt(6) + 8;
    data.potions--;
    data.heroHp = math.min(data.heroMaxHp, data.heroHp + healAmt);

    _log('You use a stim, restoring $healAmt HP!');
    add(_DamageText(text: '+$healAmt HP', color: CyberColors.green, position: heroSprite.position.clone()..y -= 40));

    onStateChange();
    Future.delayed(const Duration(milliseconds: 900), _monsterTurn);
  }

  void attack() {
    data.locked = true;
    onStateChange();

    int dmg = _random.nextInt(7) + 5;
    bool crit = _random.nextDouble() < 0.2;
    if (crit) dmg = (dmg * 1.9).floor();

    heroSprite.lunge(28.0);

    Future.delayed(const Duration(milliseconds: 250), () {
      data.currentEnemyHp -= dmg;
      add(_DamageText(text: '-$dmg HP', color: CyberColors.red, position: monsterSprite.position.clone()..y -= 40));
      monsterSprite.shake();
      _log(crit ? 'CRITICAL STRIKE! You deal $dmg damage!' : 'You attack for $dmg damage!');
      onStateChange();
      _checkWinState();
    });
  }

  void fireLaser() {
    data.locked = true;
    onStateChange();

    int dmg = _random.nextInt(10) + 8;
    _log('CHARGING LASER...');
    heroSprite.charge();

    Future.delayed(const Duration(milliseconds: 500), () {
      _log('FIRING!');
      add(_LaserBeam(
        start: heroSprite.position.clone()..y -= 10,
        end: monsterSprite.position.clone()..y -= 10,
        onImpact: () {
          data.currentEnemyHp -= dmg;
          add(_DamageText(text: '-$dmg HP', color: CyberColors.green, position: monsterSprite.position.clone()..y -= 40));
          monsterSprite.shake();
          _log('LASER BEAM! You deal $dmg damage!');
          onStateChange();
          _checkWinState();
        },
      ));
    });
  }

  void _monsterTurn() {
    data.turn = 'monster';
    _log('${data.monster!.name} charges...');
    onStateChange();

    Future.delayed(const Duration(milliseconds: 600), () {
      monsterSprite.lunge(-26.0);

      Future.delayed(const Duration(milliseconds: 250), () {
        int atk = _random.nextInt(data.monster!.maxAtk - data.monster!.minAtk + 1) + data.monster!.minAtk;
        int actual = math.max(1, atk - data.monster!.def);

        data.heroHp = math.max(0, data.heroHp - actual);
        add(_DamageText(text: '-$actual HP', color: CyberColors.red, position: heroSprite.position.clone()..y -= 40));
        heroSprite.shake();
        _log('${data.monster!.name} strikes for $actual damage!');
        onStateChange();

        if (data.heroHp <= 0) {
          Future.delayed(const Duration(milliseconds: 700), () {
            data.over = true;
            data.streak = 0;
            onStateChange();
          });
        } else {
          data.turn = 'hero';
          data.locked = false;
          onStateChange();
        }
      });
    });
  }

  void _checkWinState() {
    if (data.currentEnemyHp <= 0) {
      monsterSprite.setOpacity(0.18);
      Future.delayed(const Duration(milliseconds: 800), () {
        data.won = true;
        data.over = true;
        data.streak++;
        data.round++;
        onStateChange();
      });
    } else {
      Future.delayed(const Duration(milliseconds: 700), _monsterTurn);
    }
  }
}

// --- CUSTOM FLAME COMPONENTS ---

class _PixelSpriteComponent extends PositionComponent {
  List<String> spriteArray;
  final double pixelSize;
  final bool flipHorizontal;

  double _time = 0;
  double _alpha = 1.0;
  double _offsetX = 0;
  double _shakeTimer = 0;
  bool _isCharging = false;

  _PixelSpriteComponent({required this.spriteArray, required this.pixelSize, required this.flipHorizontal}) {
    anchor = Anchor.center;
  }

  void setOpacity(double alpha) => _alpha = alpha;

  void lunge(double distance) {
    _offsetX = distance;
    Future.delayed(const Duration(milliseconds: 250), () => _offsetX = 0);
  }

  void charge() {
    _isCharging = true;
    Future.delayed(const Duration(milliseconds: 500), () => _isCharging = false);
  }

  void shake() {
    _shakeTimer = 0.3;
  }

  @override
  void update(double dt) {
    _time += dt;
    if (_shakeTimer > 0) _shakeTimer -= dt;
  }

  @override
  void render(Canvas canvas) {
    if (_alpha <= 0) return;

    double bob = math.sin(_time * 3.0) * 4.0;
    double sx = _offsetX;
    double sy = bob;

    if (_isCharging) {
      sx += (math.Random().nextDouble() - 0.5) * 4;
      sy += (math.Random().nextDouble() - 0.5) * 4;
    } else if (_shakeTimer > 0) {
      sx += (math.Random().nextDouble() - 0.5) * 10;
    }

    canvas.save();
    canvas.translate(sx, sy);

    if (_isCharging) {
      canvas.scale(1.12);
    }

    final paint = Paint()..style = PaintingStyle.fill;
    if (_alpha < 1.0) paint.color = Colors.white.withOpacity(_alpha);

    final width = spriteArray[0].length * pixelSize;
    final height = spriteArray.length * pixelSize;
    final startX = -width / 2;
    final startY = -height / 2;

    for (int row = 0; row < spriteArray.length; row++) {
      final cols = spriteArray[row].split('');
      final cw = cols.length;
      for (int col = 0; col < cw; col++) {
        final char = flipHorizontal ? cols[cw - 1 - col] : cols[col];
        if (char == '_') continue;
        final color = SpriteData.palette[char];
        if (color != null) {
          paint.color = _alpha < 1.0 ? color.withOpacity(_alpha) : color;
          canvas.drawRect(Rect.fromLTWH(startX + col * pixelSize, startY + row * pixelSize, pixelSize, pixelSize), paint);
        }
      }
    }
    canvas.restore();
  }
}

class _DamageText extends PositionComponent {
  final String text;
  final Color color;
  double _elapsed = 0;

  _DamageText({required this.text, required this.color, required Vector2 position}) {
    this.position = position;
    anchor = Anchor.center;
  }

  @override
  void update(double dt) {
    _elapsed += dt;
    position.y -= dt * 40;
    if (_elapsed > 0.95) removeFromParent();
  }

  @override
  void render(Canvas canvas) {
    final span = TextSpan(
        text: text,
        style: TextStyle(fontFamily: 'Press Start 2P', fontSize: 14, color: color, fontWeight: FontWeight.bold, shadows: const [Shadow(color: Colors.black, blurRadius: 2, offset: Offset(2, 2))])
    );
    final painter = TextPainter(text: span, textDirection: TextDirection.ltr)..layout();
    painter.paint(canvas, Offset(-painter.width / 2, -painter.height / 2));
  }
}

class _LaserBeam extends PositionComponent {
  final Vector2 start;
  final Vector2 end;
  final VoidCallback onImpact;

  double _elapsed = 0;
  bool _impactFired = false;

  _LaserBeam({required this.start, required this.end, required this.onImpact});

  @override
  void update(double dt) {
    _elapsed += dt;
    if (_elapsed > 0.28 && !_impactFired) {
      _impactFired = true;
      onImpact();
    }
    if (_elapsed > 0.56) removeFromParent();
  }

  @override
  void render(Canvas canvas) {
    double t = (_elapsed / 0.28).clamp(0.0, 1.0);
    double currentX = start.x + (end.x - start.x) * t;
    double currentY = start.y + (end.y - start.y) * t;

    double alpha = 1.0;
    if (_elapsed > 0.38) {
      alpha = (1.0 - ((_elapsed - 0.38) / 0.18)).clamp(0.0, 1.0);
    }

    final p1 = Offset(start.x, start.y);
    final p2 = Offset(currentX, currentY);

    canvas.drawLine(p1, p2, Paint()..color = CyberColors.green.withOpacity(0.18 * alpha)..strokeWidth = 18..strokeCap = StrokeCap.round);
    canvas.drawLine(p1, p2, Paint()..color = CyberColors.green.withOpacity(0.45 * alpha)..strokeWidth = 7..strokeCap = StrokeCap.round);
    canvas.drawLine(p1, p2, Paint()..color = Colors.white..strokeWidth = 2..strokeCap = StrokeCap.round);

    canvas.drawCircle(p1, 6, Paint()..color = CyberColors.green.withOpacity(alpha * 0.7));
    canvas.drawCircle(p1, 2, Paint()..color = Colors.white.withOpacity(alpha));

    if (_impactFired) {
      canvas.drawCircle(p2, 32, Paint()..color = CyberColors.green.withOpacity(alpha * 0.4));
      canvas.drawCircle(p2, 12, Paint()..color = Colors.white.withOpacity(alpha));
    }
  }
}

class _BattleFloor extends PositionComponent with HasGameRef<DungeonDuelGame> {
  @override
  void render(Canvas canvas) {
    final paint = Paint()..color = CyberColors.cyan.withOpacity(0.1)..strokeWidth = 1;
    final y = gameRef.size.y * 0.7;
    canvas.drawLine(Offset(0, y), Offset(gameRef.size.x, y), paint);

    final fill = Paint()..color = Colors.black.withOpacity(0.3);
    canvas.drawRect(Rect.fromLTWH(0, y, gameRef.size.x, gameRef.size.y - y), fill);
  }
}