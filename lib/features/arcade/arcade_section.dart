import 'package:flutter/material.dart';
import 'package:flame/game.dart';
import '../../core/theme/cyber_colors.dart';
import '../../core/clippers/chamfer_clipper.dart';
import 'widgets/pixel_sprite.dart';
import 'utils/sprite_data.dart';
import 'dungeon_duel/dungeon_duel_game.dart';
import 'crypt_maze/crypt_maze_game.dart';

class ArcadeSection extends StatefulWidget {
  const ArcadeSection({super.key});

  @override
  State<ArcadeSection> createState() => _ArcadeSectionState();
}

class _ArcadeSectionState extends State<ArcadeSection> {
  String _activeTab = 'battle';
  late DungeonDuelGame _duelGame;
  late CryptMazeGame _mazeGame;

  @override
  void initState() {
    super.initState();
    _duelGame = DungeonDuelGame(onStateChange: () => setState(() {}));
    _mazeGame = CryptMazeGame(onStateChange: () => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(48, 24, 48, 64),
      decoration: BoxDecoration(
        color: CyberColors.surface,
        border: Border.all(color: CyberColors.green.withOpacity(0.3)),
        boxShadow: [BoxShadow(color: CyberColors.green.withOpacity(0.05), blurRadius: 20)],
      ),
      child: Column(
        children: [
          // --- HEADER & TABS ---
          Container(
            decoration: BoxDecoration(
              border: const Border(bottom: BorderSide(color: CyberColors.border)),
              gradient: LinearGradient(colors: [CyberColors.green.withOpacity(0.04), Colors.transparent]),
            ),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('★ NEURAL ARCADE ★', style: TextStyle(fontFamily: 'Orbitron', fontSize: 12, color: CyberColors.green, letterSpacing: 2, shadows: CyberColors.greenGlow)),
                      const SizedBox(height: 4),
                      const Text('Win games → earn discount codes', style: TextStyle(fontFamily: 'Share Tech Mono', fontSize: 10, color: CyberColors.text3, letterSpacing: 1)),
                    ],
                  ),
                ),
                Container(width: 1, height: 50, color: CyberColors.border),
                Expanded(
                  child: Row(
                    children: [
                      _buildTab('DUNGEON DUEL', 'battle', SpriteData.hero, 2.0),
                      _buildTab('CRYPT MAZE', 'maze', SpriteData.mazeHero, 2.5),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  decoration: const BoxDecoration(border: Border(left: BorderSide(color: CyberColors.border))),
                  child: Text('WIN = PROMO CODE', style: TextStyle(fontFamily: 'Share Tech Mono', fontSize: 10, color: CyberColors.green, letterSpacing: 2, shadows: CyberColors.greenGlow)),
                )
              ],
            ),
          ),

          // --- VIEWPORT ---
          Container(
            height: 380,
            width: double.infinity,
            color: const Color(0xFF050403),
            child: _activeTab == 'battle' ? _buildBattleViewport() : _buildMazeViewport(),
          ),

          // --- BOTTOM HUD ---
          _activeTab == 'battle' ? _buildBattleHUD() : _buildMazeHUD(),
        ],
      ),
    );
  }

  // ==========================================
  // DUNGEON DUEL UI
  // ==========================================
  Widget _buildBattleViewport() {
    final d = _duelGame.data;
    return Stack(
      children: [
        GameWidget(game: _duelGame),
        if (d.active && !d.over) ...[
          Positioned(top: 16, left: 16, child: _buildHpBar('HERO', d.heroHp, d.heroMaxHp, CyberColors.cyan)),
          Positioned(top: 16, right: 16, child: _buildHpBar('ENEMY', d.currentEnemyHp, d.monster!.maxHp, CyberColors.red)),
          Positioned(top: 16, left: 0, right: 0, child: Center(child: Container(padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7), decoration: BoxDecoration(color: Colors.black.withOpacity(0.8), border: Border.all(color: CyberColors.green.withOpacity(0.3))), child: Text(d.log, style: TextStyle(fontFamily: 'Share Tech Mono', fontSize: 10, color: CyberColors.green, letterSpacing: 1, shadows: CyberColors.greenGlow))))),
        ],
        if (!d.active || d.over)
          Positioned.fill(
            child: Container(
              color: Colors.black.withOpacity(0.85),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    PixelSprite(sprite: d.won ? d.monster!.sprite : SpriteData.dragon, pixelSize: 4),
                    const SizedBox(height: 24),
                    Text(d.won ? 'VICTORY!' : (d.active ? 'DEFEATED' : 'DUNGEON DUEL'), style: TextStyle(fontFamily: 'Orbitron', fontSize: 24, fontWeight: FontWeight.bold, color: d.won ? CyberColors.green : (d.active ? CyberColors.red : CyberColors.green), letterSpacing: 3)),
                    const SizedBox(height: 12),
                    Text(d.won ? 'The beast hath been vanquished!\nStreak: ${d.streak}' : (d.active ? 'Thou hast fallen in battle...\nShall ye rise again?' : 'DEFEAT THE GUARDIAN BEAST\nTO EARN A DISCOUNT CODE!'), textAlign: TextAlign.center, style: const TextStyle(fontFamily: 'Share Tech Mono', fontSize: 11, color: CyberColors.text3, letterSpacing: 1.5, height: 1.8)),
                    if (d.won) ...[
                      const SizedBox(height: 16),
                      Container(padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8), decoration: BoxDecoration(border: Border.all(color: CyberColors.cyan)), child: Text('DUNGEON20', style: TextStyle(fontFamily: 'Orbitron', fontSize: 16, fontWeight: FontWeight.bold, color: CyberColors.cyan, letterSpacing: 4, shadows: CyberColors.cyanGlow)))
                    ],
                    const SizedBox(height: 24),
                    GestureDetector(onTap: () => _duelGame.startBattle(), child: Container(padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10), decoration: BoxDecoration(color: CyberColors.green.withOpacity(0.1), border: Border.all(color: CyberColors.green)), child: Text(d.won ? '⚔ FIGHT AGAIN' : (d.active ? '⚔ TRY AGAIN' : '⚔ ENTER DUNGEON'), style: const TextStyle(fontFamily: 'Share Tech Mono', color: CyberColors.green, fontSize: 11, letterSpacing: 2))))
                  ],
                ),
              ),
            ),
          )
      ],
    );
  }

  Widget _buildBattleHUD() {
    final d = _duelGame.data;
    final canAct = d.active && !d.locked && !d.over && d.turn == 'hero';
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      decoration: const BoxDecoration(border: Border(top: BorderSide(color: CyberColors.border)), color: CyberColors.surface),
      child: Column(
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [_buildStat('POTIONS', d.potions.toString()), const SizedBox(width: 48), _buildStat('ROUND', d.round.toString()), const SizedBox(width: 48), _buildStat('STREAK', d.streak.toString())]),
          const SizedBox(height: 16),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [_btn('⚔ ATTACK', canAct, () => _duelGame.attack(), true), const SizedBox(width: 12), _btn('⚡ LASER', canAct, () => _duelGame.fireLaser(), false), const SizedBox(width: 12), _btn('⚗ HEAL', canAct && d.potions > 0, () => _duelGame.heal(), false), const SizedBox(width: 12), _btn('↩ FLEE', canAct, () => _duelGame.flee(), false, isDanger: true)])
        ],
      ),
    );
  }

  // ==========================================
  // CRYPT MAZE UI
  // ==========================================
  Widget _buildMazeViewport() {
    final m = _mazeGame.data;

    // Calculate the dynamic button text
    String btnText = '▶ ENTER MAZE';
    if (m.lives <= 0) {
      btnText = '↺ RESTART';
    } else if (m.won) {
      btnText = '↺ PLAY AGAIN';
    } else if (m.started) {
      btnText = m.overlayTitle == 'LEVEL CLEAR!' ? '▶ PROCEED' : '▶ RETRY';
    }

    return Stack(
      children: [
        GameWidget(game: _mazeGame),

        if (m.running)
          Positioned(
            top: 16, left: 0, right: 0,
            child: Center(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
                decoration: BoxDecoration(color: Colors.black.withOpacity(0.8), border: Border.all(color: CyberColors.green.withOpacity(0.3))),
                child: Text(m.log, style: TextStyle(fontFamily: 'Share Tech Mono', fontSize: 10, color: CyberColors.green, letterSpacing: 1, shadows: CyberColors.greenGlow)),
              ),
            ),
          ),

        if (!m.running)
          Positioned.fill(
            child: Container(
              color: Colors.black.withOpacity(0.85),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    PixelSprite(sprite: SpriteData.mazeHero, pixelSize: 4),
                    const SizedBox(height: 24),
                    Text(m.overlayTitle, style: TextStyle(fontFamily: 'Orbitron', fontSize: 24, fontWeight: FontWeight.bold, color: m.won ? CyberColors.green : (m.lives <= 0 ? CyberColors.red : CyberColors.green), letterSpacing: 3)),
                    const SizedBox(height: 12),
                    Text(m.overlaySub, textAlign: TextAlign.center, style: const TextStyle(fontFamily: 'Share Tech Mono', fontSize: 11, color: CyberColors.text3, letterSpacing: 1.5, height: 1.8)),
                    if (m.won) ...[
                      const SizedBox(height: 16),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                        decoration: BoxDecoration(border: Border.all(color: CyberColors.cyan)),
                        child: Text('GAMEON', style: TextStyle(fontFamily: 'Orbitron', fontSize: 16, fontWeight: FontWeight.bold, color: CyberColors.cyan, letterSpacing: 4, shadows: CyberColors.cyanGlow)),
                      )
                    ],
                    const SizedBox(height: 24),
                    GestureDetector(
                      onTap: () {
                        if (m.lives <= 0 || m.won) {
                          _mazeGame.resetMaze();
                        } else {
                          _mazeGame.startMaze();
                        }
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                        decoration: BoxDecoration(color: CyberColors.green.withOpacity(0.1), border: Border.all(color: CyberColors.green)),
                        child: Text(btnText, style: const TextStyle(fontFamily: 'Share Tech Mono', color: CyberColors.green, fontSize: 11, letterSpacing: 2)),
                      ),
                    )
                  ],
                ),
              ),
            ),
          )
      ],
    );
  }

  Widget _buildMazeHUD() {
    final m = _mazeGame.data;
    String livesStr = '♥' * m.lives + '♡' * (3 - m.lives);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      decoration: const BoxDecoration(border: Border(top: BorderSide(color: CyberColors.border)), color: CyberColors.surface),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildStat('GEMS', '${m.gems}/${m.totalGems}'),
          _buildStat('LIVES', livesStr),
          _buildStat('LEVEL', (m.level + 1).toString()),
          _buildStat('TIME', m.timer.toString()),
          const SizedBox(width: 16),
          _btn('↺ RESTART', true, () => _mazeGame.resetMaze(), false)
        ],
      ),
    );
  }

  // ==========================================
  // SHARED HELPERS
  // ==========================================
  Widget _buildHpBar(String label, int current, int max, Color color) {
    double pct = (current / max).clamp(0.0, 1.0);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      decoration: BoxDecoration(color: CyberColors.surface2, border: Border.all(color: CyberColors.border)),
      width: 140,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(fontFamily: 'Share Tech Mono', fontSize: 9, color: CyberColors.text3, letterSpacing: 1)),
          const SizedBox(height: 4),
          Container(height: 6, width: double.infinity, color: CyberColors.bg2, alignment: Alignment.centerLeft, child: AnimatedContainer(duration: const Duration(milliseconds: 300), width: 122 * pct, height: 6, color: color)),
          const SizedBox(height: 4),
          Text('$current / $max HP', style: const TextStyle(fontFamily: 'Share Tech Mono', fontSize: 9, color: CyberColors.text3)),
        ],
      ),
    );
  }

  Widget _btn(String text, bool enabled, VoidCallback onTap, bool isPrimary, {bool isDanger = false}) {
    return GestureDetector(
      onTap: enabled ? onTap : null,
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 200),
        opacity: enabled ? 1.0 : 0.3,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          decoration: BoxDecoration(color: isPrimary ? CyberColors.green.withOpacity(0.1) : CyberColors.surface2, border: Border.all(color: isPrimary ? CyberColors.green : (isDanger ? CyberColors.red.withOpacity(0.5) : CyberColors.border))),
          child: Text(text, style: TextStyle(fontFamily: 'Share Tech Mono', fontSize: 10, color: isPrimary ? CyberColors.green : (isDanger ? CyberColors.red : CyberColors.text2), letterSpacing: 1.5)),
        ),
      ),
    );
  }

  Widget _buildStat(String label, String val) {
    return Column(
      children: [
        Text(label, style: const TextStyle(fontFamily: 'Share Tech Mono', fontSize: 9, color: CyberColors.text3, letterSpacing: 1)),
        const SizedBox(height: 2),
        Text(val, style: TextStyle(fontFamily: 'Press Start 2P', fontSize: 10, color: CyberColors.green, shadows: CyberColors.greenGlow)),
      ],
    );
  }

  Widget _buildTab(String title, String id, List<String> sprite, double pxSize) {
    final isActive = _activeTab == id;
    return GestureDetector(
      onTap: () => setState(() => _activeTab = id),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        decoration: BoxDecoration(color: isActive ? CyberColors.green.withOpacity(0.06) : Colors.transparent, border: Border(right: const BorderSide(color: CyberColors.border), bottom: BorderSide(color: isActive ? CyberColors.green : Colors.transparent, width: 2))),
        child: Column(
          children: [
            SizedBox(height: 24, child: Center(child: PixelSprite(sprite: sprite, pixelSize: pxSize))),
            const SizedBox(height: 8),
            Text(title, style: TextStyle(fontFamily: 'Orbitron', fontSize: 9, color: isActive ? CyberColors.green : CyberColors.text3, shadows: isActive ? CyberColors.greenGlow : null)),
          ],
        ),
      ),
    );
  }
}