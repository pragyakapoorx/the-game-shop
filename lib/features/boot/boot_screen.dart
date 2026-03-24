import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme/cyber_colors.dart';

class BootScreen extends StatefulWidget {
  const BootScreen({super.key});

  @override
  State<BootScreen> createState() => _BootScreenState();
}

class _BootScreenState extends State<BootScreen> with TickerProviderStateMixin {
  // Phase Flags
  bool _showBloom = false;
  bool _fadeBloom = false;
  bool _screenOn = false;
  bool _terminalDone = false;
  bool _showLogo = false;
  bool _showPak = false;
  bool _isFlickering = false; // Kept as transition flag
  bool _blackout = false;

  // Terminal State
  final List<Map<String, String>> _visibleLines = [];
  final ScrollController _scrollController = ScrollController();

  // Loader State
  String _loadStatus = 'INITIALIZING...';
  double _loadPct = 0.0;

  late AnimationController _hexController;

  final List<Map<String, String>> _bootLines = [
    {'t': 'cyan', 's': 'TGS NEURAL OS v4.1.2  |  CYBERSPACE EDITION'},
    {'t': 'dim', 's': 'Copyright (C) 2077 TheGameShop Corp. All rights reserved.'},
    {'t': '', 's': ''},
    {'t': 'dim', 's': 'CPU: NEOCORTEX-X9 @ 4.80GHz  [8 CORES / 16 THREADS]'},
    {'t': 'dim', 's': 'RAM: 65536MB DDR6 DUAL-CHANNEL  [ECC ENABLED]'},
    {'t': 'dim', 's': 'GPU: HOLO-MATRIX RTX 9090 Ti  [VRAM: 48GB]'},
    {'t': '', 's': ''},
    {'t': 'ok', 's': '[ OK ] Memory integrity check ................. PASS'},
    {'t': 'ok', 's': '[ OK ] Neural bus controller .................. READY'},
    {'t': 'ok', 's': '[ OK ] Cyberspace handshake ................... ESTABLISHED'},
    {'t': 'ok', 's': '[ OK ] Data vault authentication .............. VERIFIED'},
    {'t': 'ok', 's': '[ OK ] Holographic display driver ............. LOADED'},
    {'t': 'ok', 's': '[ OK ] Network stack (NEON-TCP/IP v6) ......... ACTIVE'},
    {'t': 'ok', 's': '[ OK ] Encrypted storage subsystem ............ MOUNTED'},
    {'t': 'warn', 's': '[WARN] Black ICE firewall — protocol override detected'},
    {'t': 'ok', 's': '[ OK ] ICE override accepted  (level 5 clearance confirmed)'},
    {'t': 'ok', 's': '[ OK ] Quantum entropy source ................. SEEDED'},
    {'t': 'ok', 's': '[ OK ] City grid uplink  [TOWER-7 ↔ SECTOR-9] . LINKED'},
    {'t': 'ok', 's': '[ OK ] Asset pipeline (textures, shaders) ..... COMPILED'},
    {'t': 'ok', 's': '[ OK ] User session restored .................. DONE'},
    {'t': '', 's': ''},
    {'t': 'cyan', 's': 'Loading TheGameShop interface...'},
  ];

  @override
  void initState() {
    super.initState();
    _hexController = AnimationController(vsync: this, duration: const Duration(seconds: 12))..repeat();
    _startSequence();
  }

  @override
  void dispose() {
    _hexController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _startSequence() async {
    await Future.delayed(const Duration(milliseconds: 300));
    if (!mounted) return;
    setState(() => _showBloom = true);

    await Future.delayed(const Duration(milliseconds: 120));
    if (!mounted) return;
    setState(() {
      _fadeBloom = true;
      _screenOn = true;
    });

    await Future.delayed(const Duration(milliseconds: 700));
    for (var line in _bootLines) {
      if (!mounted) return;
      setState(() => _visibleLines.add(line));
      if (_scrollController.hasClients) {
        _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
      }
      await Future.delayed(Duration(milliseconds: 36 + math.Random().nextInt(20)));
    }

    if (!mounted) return;
    setState(() => _terminalDone = true);

    await Future.delayed(const Duration(milliseconds: 500));
    if (!mounted) return;
    setState(() => _showLogo = true);

    final steps = [
      ['CONNECTING TO DATABASE...', 0.15],
      ['AUTHENTICATING...', 0.32],
      ['RESTORING CART...', 0.50],
      ['LOADING LIBRARY...', 0.65],
      ['FETCHING REVIEWS...', 0.80],
      ['SYNCING ORDERS...', 0.92],
      ['READY ✓', 1.0],
    ];

    for (var step in steps) {
      if (!mounted) return;
      setState(() {
        _loadStatus = step[0] as String;
        _loadPct = step[1] as double;
      });
      await Future.delayed(const Duration(milliseconds: 280));
    }

    if (!mounted) return;
    setState(() => _showPak = true);
  }

  void _triggerPowerOff() async {
    if (!_showPak || _isFlickering) return;
    setState(() => _isFlickering = true);

    // FLICKER ANIMATION REMOVED
    // Transitioning directly to bloom flash and blackout

    if (!mounted) return;
    setState(() {
      _showBloom = true;
      _fadeBloom = false;
    });

    await Future.delayed(const Duration(milliseconds: 80));
    if (!mounted) return;
    setState(() {
      _showBloom = false;
      _blackout = true;
    });

    await Future.delayed(const Duration(milliseconds: 60));
    if (mounted) {
      context.go('/store');
    }
  }

  Color _getLineColor(String t) {
    switch (t) {
      case 'cyan': return CyberColors.cyan;
      case 'dim': return CyberColors.text3;
      case 'warn': return Colors.orange;
      case 'err': return CyberColors.red;
      case 'ok':
      default: return CyberColors.green;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: GestureDetector(
        onTap: _triggerPowerOff,
        behavior: HitTestBehavior.opaque,
        child: Stack(
          children: [
            Positioned.fill(
              child: Container(
                decoration: const BoxDecoration(
                    gradient: RadialGradient(
                      radius: 0.8,
                      colors: [Color(0xFF0a0a1a), Colors.black],
                    )
                ),
                child: CustomPaint(painter: _GridPainter()),
              ),
            ),

            Center(
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Container(
                  width: 880,
                  margin: const EdgeInsets.all(40),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(10),
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter, end: Alignment.bottomCenter,
                            colors: [Color(0xFF1a1a22), Color(0xFF0e0e14)],
                          ),
                          borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
                          border: Border(
                            top: BorderSide(color: Color(0xFF2a2a3a)),
                            left: BorderSide(color: Color(0xFF2a2a3a)),
                            right: BorderSide(color: Color(0xFF2a2a3a)),
                          ),
                        ),
                        child: Column(
                          children: [
                            const SizedBox(height: 4),
                            const Text('TGS', style: TextStyle(fontFamily: 'Orbitron', fontSize: 10, color: Color(0xFF2a2a3a), letterSpacing: 3)),
                            const SizedBox(height: 10),

                            AspectRatio(
                              aspectRatio: 16 / 10,
                              child: LayoutBuilder(
                                builder: (context, constraints) {
                                  return Container(
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      color: Colors.black,
                                      borderRadius: BorderRadius.circular(4),
                                      border: Border.all(color: const Color(0xFF0a0a10), width: 2),
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(4),
                                      child: Stack(
                                        children: [
                                          AnimatedContainer(
                                            duration: const Duration(milliseconds: 600),
                                            curve: Curves.easeOutCubic,
                                            height: _screenOn ? constraints.maxHeight : 0,
                                            margin: EdgeInsets.only(top: _screenOn ? 0 : constraints.maxHeight / 2),
                                            child: Stack(
                                              children: [
                                                if (!_terminalDone || !_showLogo)
                                                  Padding(
                                                    padding: const EdgeInsets.all(24),
                                                    child: ListView.builder(
                                                      controller: _scrollController,
                                                      itemCount: _visibleLines.length,
                                                      itemBuilder: (c, i) {
                                                        final line = _visibleLines[i];
                                                        return Text(line['s']!, style: TextStyle(fontFamily: 'Share Tech Mono', fontSize: 12, color: _getLineColor(line['t']!), height: 1.8));
                                                      },
                                                    ),
                                                  ),

                                                if (_showLogo)
                                                  AnimatedOpacity(
                                                    duration: const Duration(milliseconds: 600),
                                                    opacity: _showLogo ? 1.0 : 0.0,
                                                    child: Center(
                                                      child: FittedBox(
                                                        fit: BoxFit.scaleDown,
                                                        child: Column(
                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                          children: [
                                                            SizedBox(
                                                              width: 450, height: 200,
                                                              child: Stack(
                                                                alignment: Alignment.center,
                                                                children: [
                                                                  AnimatedBuilder(
                                                                    animation: _hexController,
                                                                    builder: (_,__) => Transform.rotate(angle: _hexController.value * 2 * math.pi, child: CustomPaint(painter: _HexPainter(CyberColors.green.withOpacity(0.12)), size: const Size(140, 140))),
                                                                  ),
                                                                  AnimatedBuilder(
                                                                    animation: _hexController,
                                                                    builder: (_,__) => Transform.rotate(angle: -_hexController.value * 2 * math.pi, child: CustomPaint(painter: _HexPainter(CyberColors.cyan.withOpacity(0.07)), size: const Size(180, 180))),
                                                                  ),
                                                                  const Column(
                                                                    mainAxisSize: MainAxisSize.min,
                                                                    children: [
                                                                      _RgbShiftLogo(),
                                                                      SizedBox(height: 12),
                                                                      Text('YOUR UNIVERSE OF GAMES', style: TextStyle(fontFamily: 'Share Tech Mono', fontSize: 10, color: CyberColors.text3, letterSpacing: 5)),
                                                                    ],
                                                                  )
                                                                ],
                                                              ),
                                                            ),
                                                            const SizedBox(height: 40),
                                                            Container(
                                                              width: 280, height: 2,
                                                              color: CyberColors.surface2,
                                                              alignment: Alignment.centerLeft,
                                                              child: AnimatedContainer(
                                                                duration: const Duration(milliseconds: 300),
                                                                width: 280 * _loadPct,
                                                                height: 2,
                                                                decoration: BoxDecoration(
                                                                  gradient: const LinearGradient(colors: [CyberColors.green, CyberColors.cyan]),
                                                                  boxShadow: CyberColors.greenGlow,
                                                                ),
                                                              ),
                                                            ),
                                                            const SizedBox(height: 14),
                                                            Text(_loadStatus, style: const TextStyle(fontFamily: 'Share Tech Mono', fontSize: 10, color: CyberColors.text3, letterSpacing: 3)),
                                                            const SizedBox(height: 32),
                                                            if (_showPak)
                                                              const _PulsePakText(),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  )
                                              ],
                                            ),
                                          ),

                                          Positioned.fill(
                                            child: Container(
                                              decoration: BoxDecoration(
                                                gradient: RadialGradient(radius: 0.8, colors: [Colors.transparent, Colors.black.withOpacity(0.75)]),
                                              ),
                                              child: CustomPaint(painter: _ScanlinePainter()),
                                            ),
                                          ),

                                          if (_showBloom)
                                            AnimatedOpacity(
                                              duration: Duration(milliseconds: _fadeBloom ? 600 : 0),
                                              opacity: _fadeBloom ? 0.0 : 1.0,
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  gradient: RadialGradient(radius: 0.8, colors: [CyberColors.green.withOpacity(0.55), CyberColors.cyan.withOpacity(0.2), Colors.transparent]),
                                                ),
                                              ),
                                            )
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),

                      Container(
                        width: double.infinity, height: 16,
                        decoration: const BoxDecoration(
                            gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [Color(0xFF1c1c26), Color(0xFF0e0e14)]),
                            borderRadius: BorderRadius.vertical(bottom: Radius.circular(6)),
                            boxShadow: [
                              BoxShadow(color: Colors.black, blurRadius: 40, offset: Offset(0, 8)),
                              BoxShadow(color: Color(0x1A00FF88), offset: Offset(0, 2)),
                            ]
                        ),
                        alignment: Alignment.center,
                        child: Container(
                          width: 60, height: 6,
                          decoration: BoxDecoration(
                            color: CyberColors.green.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(3),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            if (_blackout)
              Positioned.fill(child: Container(color: Colors.black)),
          ],
        ),
      ),
    );
  }
}

class _RgbShiftLogo extends StatefulWidget {
  const _RgbShiftLogo();

  @override
  State<_RgbShiftLogo> createState() => _RgbShiftLogoState();
}

class _RgbShiftLogoState extends State<_RgbShiftLogo> with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 1000))..repeat(reverse: true);
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: _ctrl,
        builder: (context, child) {
          final t = Curves.easeInOut.transform(_ctrl.value);

          final magX = -2.0 + (4.0 * t);
          final cyanX = 2.0 - (4.0 * t);
          final greenBlur = 6.0 + (4.0 * t);
          final greenOp = 0.4 + (0.1 * t);

          return Text.rich(
            const TextSpan(
                children: [
                  TextSpan(text: 'TheGame', style: TextStyle(color: CyberColors.green)),
                  TextSpan(text: 'Shop', style: TextStyle(color: CyberColors.cyan)),
                ]
            ),
            softWrap: false,
            style: TextStyle(
              fontFamily: 'Orbitron',
              fontSize: 42,
              fontWeight: FontWeight.bold,
              letterSpacing: 4,
              shadows: [
                Shadow(color: CyberColors.magenta, offset: Offset(magX, 0), blurRadius: 2),
                Shadow(color: CyberColors.cyan, offset: Offset(cyanX, 0), blurRadius: 2),
                Shadow(color: CyberColors.green.withOpacity(greenOp), blurRadius: greenBlur),
              ],
            ),
          );
        }
    );
  }
}

class _PulsePakText extends StatefulWidget {
  const _PulsePakText();

  @override
  State<_PulsePakText> createState() => _PulsePakTextState();
}

class _PulsePakTextState extends State<_PulsePakText> with TickerProviderStateMixin {
  late AnimationController _pulseCtrl;
  late AnimationController _blinkCtrl;

  @override
  void initState() {
    super.initState();
    _pulseCtrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 1000))..repeat(reverse: true);
    _blinkCtrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 450))..repeat(reverse: true);
  }

  @override
  void dispose() {
    _pulseCtrl.dispose();
    _blinkCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: Listenable.merge([_pulseCtrl, _blinkCtrl]),
        builder: (context, child) {
          final p = Curves.easeInOut.transform(_pulseCtrl.value);
          final opacity = 1.0 - (0.4 * p);
          final showCursor = _blinkCtrl.value < 0.5;

          return Opacity(
            opacity: opacity,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'PRESS ANY KEY TO ENTER',
                  style: TextStyle(
                    fontFamily: 'Share Tech Mono',
                    fontSize: 12,
                    color: CyberColors.green,
                    letterSpacing: 4,
                    shadows: p > 0.8 ? [] : [
                      Shadow(color: CyberColors.green.withOpacity(1.0 - p), blurRadius: 5),
                      Shadow(color: CyberColors.green.withOpacity((0.4 * (1.0 - p)).clamp(0.0, 1.0)), blurRadius: 10),
                      Shadow(color: CyberColors.green.withOpacity((0.2 * (1.0 - p)).clamp(0.0, 1.0)), blurRadius: 20),
                    ],
                  ),
                ),
                const SizedBox(width: 4),
                Opacity(
                  opacity: showCursor ? 1.0 : 0.0,
                  child: Container(
                    width: 10,
                    height: 16,
                    margin: const EdgeInsets.only(bottom: 2),
                    decoration: BoxDecoration(
                      color: CyberColors.green,
                      boxShadow: CyberColors.greenGlow,
                    ),
                  ),
                ),
              ],
            ),
          );
        }
    );
  }
}

class _GridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = CyberColors.green.withOpacity(0.04)..strokeWidth = 1;
    for (double i = 0; i < size.width; i += 40) canvas.drawLine(Offset(i, 0), Offset(i, size.height), paint);
    for (double i = 0; i < size.height; i += 40) canvas.drawLine(Offset(0, i), Offset(size.width, i), paint);
  }
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _ScanlinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.black.withOpacity(0.14)..strokeWidth = 1;
    for (double i = 0; i < size.height; i += 3) canvas.drawLine(Offset(0, i), Offset(size.width, i), paint);
  }
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _HexPainter extends CustomPainter {
  final Color color;
  _HexPainter(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = color..style = PaintingStyle.stroke..strokeWidth = 1;
    final path = Path();
    final w = size.width, h = size.height;
    path.moveTo(w * 0.5, 0); path.lineTo(w * 0.933, h * 0.25); path.lineTo(w * 0.933, h * 0.75);
    path.lineTo(w * 0.5, h); path.lineTo(w * 0.067, h * 0.75); path.lineTo(w * 0.067, h * 0.25); path.close();
    canvas.drawPath(path, paint);
  }
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}