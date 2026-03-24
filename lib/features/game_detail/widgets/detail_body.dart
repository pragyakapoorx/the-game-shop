import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../core/theme/cyber_colors.dart';
import '../../../core/clippers/chamfer_clipper.dart';
import '../../../models/game.dart';

class DetailBody extends StatelessWidget {
  final Game game;
  const DetailBody({super.key, required this.game});

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width > 1024;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 32),
      child: isDesktop
          ? Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(flex: 7, child: _MainContent(game: game)),
          const SizedBox(width: 24),
          Expanded(flex: 3, child: _Sidebar(game: game)),
        ],
      )
          : Column(
        children: [
          _MainContent(game: game),
          const SizedBox(height: 24),
          _Sidebar(game: game),
        ],
      ),
    );
  }
}

class _MainContent extends StatefulWidget {
  final Game game;
  const _MainContent({required this.game});

  @override
  State<_MainContent> createState() => _MainContentState();
}

class _MainContentState extends State<_MainContent> {
  bool _showRecReqs = false;

  Future<void> _launchTrailer() async {
    final url = Uri.parse('https://www.youtube.com/watch?v=${widget.game.trailerYT}');
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Trailer Section
        _buildSectionHeader('▶', 'OFFICIAL TRAILER'),
        GestureDetector(
          onTap: _launchTrailer,
          child: MouseRegion(
            cursor: SystemMouseCursors.click,
            child: ClipPath(
              clipper: ChamferClipper(chamferSize: 8),
              child: AspectRatio(
                aspectRatio: 16 / 9,
                child: Stack(
                  children: [
                    // Background Image with Fallback
                    Positioned.fill(
                      child: Image.network(
                        'https://img.youtube.com/vi/${widget.game.trailerYT}/maxresdefault.jpg',
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Image.network('https://img.youtube.com/vi/${widget.game.trailerYT}/hqdefault.jpg', fit: BoxFit.cover);
                        },
                      ),
                    ),
                    // Dark Overlay
                    Positioned.fill(
                      child: Container(color: Colors.black45),
                    ),
                    // Play Button Overlay
                    Positioned.fill(
                      child: Center(
                        child: SizedBox(
                          width: 84,
                          height: 84,
                          child: CustomPaint(
                            painter: _PlayButtonPainter(),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 24),

        // Screenshots Section
        _buildSectionHeader('🖼', 'SCREENSHOTS'),
        SizedBox(
          height: 146,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: widget.game.screenshots.length,
            separatorBuilder: (c, i) => const SizedBox(width: 10),
            itemBuilder: (context, i) {
              final shot = widget.game.screenshots[i];
              return ClipPath(
                clipper: ChamferClipper(chamferSize: 4),
                child: Container(
                  width: 260,
                  decoration: BoxDecoration(border: Border.all(color: CyberColors.border)),
                  child: Image.network(shot.url, fit: BoxFit.cover),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 24),

        // About Section
        _buildSectionHeader('📋', 'ABOUT THIS GAME'),
        Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(color: CyberColors.surface, border: Border.all(color: CyberColors.border)),
          child: Text(widget.game.desc, style: const TextStyle(color: CyberColors.text2, fontSize: 13, height: 1.9, letterSpacing: 0.3)),
        ),
        const SizedBox(height: 24),

        // System Requirements
        _buildSectionHeader('💻', 'SYSTEM REQUIREMENTS'),
        Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(color: CyberColors.surface, border: Border.all(color: CyberColors.border)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  _buildReqTab('MINIMUM', !_showRecReqs, () => setState(() => _showRecReqs = false)),
                  const SizedBox(width: 6),
                  _buildReqTab('RECOMMENDED', _showRecReqs, () => setState(() => _showRecReqs = true)),
                ],
              ),
              const SizedBox(height: 16),
              _buildReqGrid(_showRecReqs ? widget.game.requirements.rec : widget.game.requirements.min),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSectionHeader(String icon, String title) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      decoration: BoxDecoration(
        color: CyberColors.surface,
        border: Border.all(color: CyberColors.border),
      ),
      child: Row(
        children: [
          Text(icon, style: const TextStyle(fontSize: 14)),
          const SizedBox(width: 10),
          Text(title, style: TextStyle(fontFamily: 'Share Tech Mono', fontSize: 11, color: CyberColors.green, letterSpacing: 2.5, shadows: CyberColors.greenGlow)),
        ],
      ),
    );
  }

  Widget _buildReqTab(String text, bool isActive, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: ClipPath(
        clipper: ChamferClipper(chamferSize: 4),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          decoration: BoxDecoration(
            color: isActive ? CyberColors.cyan.withOpacity(0.08) : Colors.transparent,
            border: Border.all(color: isActive ? CyberColors.cyan : CyberColors.border),
          ),
          child: Text(text, style: TextStyle(color: isActive ? CyberColors.cyan : CyberColors.text3, fontFamily: 'Share Tech Mono', fontSize: 9, letterSpacing: 2)),
        ),
      ),
    );
  }

  Widget _buildReqGrid(RequirementSpecs reqs) {
    return Wrap(
      spacing: 8, runSpacing: 8,
      children: [
        _reqItem('OS', reqs.os), _reqItem('CPU', reqs.cpu),
        _reqItem('GPU', reqs.gpu), _reqItem('RAM', reqs.ram),
        SizedBox(width: double.infinity, child: _reqItem('STORAGE', reqs.storage)),
      ],
    );
  }

  Widget _reqItem(String label, String val) {
    return Container(
      width: 300,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(color: CyberColors.bg2, border: Border.all(color: CyberColors.border)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(fontFamily: 'Share Tech Mono', fontSize: 8, color: CyberColors.cyan, letterSpacing: 2)),
          const SizedBox(height: 4),
          Text(val, style: const TextStyle(fontFamily: 'JetBrains Mono', fontSize: 11, color: CyberColors.text2)),
        ],
      ),
    );
  }
}

class _Sidebar extends StatelessWidget {
  final Game game;
  const _Sidebar({required this.game});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Info Card
        ClipPath(
          clipper: ChamferClipper(chamferSize: 8),
          child: Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(color: CyberColors.surface, border: Border.all(color: CyberColors.border)),
            child: Column(
              children: [
                _infoRow('Developer', game.developer),
                _infoRow('Publisher', game.publisher),
                _infoRow('Release', game.released),
                _infoRow('Genre', game.genre),
                _infoRow('Size', game.size),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _infoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 9),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label.toUpperCase(), style: const TextStyle(fontFamily: 'Share Tech Mono', fontSize: 9, color: CyberColors.text3, letterSpacing: 1.5)),
          const SizedBox(width: 12),
          Expanded(child: Text(value, textAlign: TextAlign.right, style: const TextStyle(fontFamily: 'JetBrains Mono', fontSize: 12, color: CyberColors.text2))),
        ],
      ),
    );
  }
}

// Paste this at the absolute bottom of detail_body.dart
class PlayTriangleClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.moveTo(0, 0); // Top left
    path.lineTo(size.width, size.height / 2); // Middle right
    path.lineTo(0, size.height); // Bottom left
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class _PlayButtonPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Draw the square border box
    final borderPaint = Paint()
      ..color = CyberColors.green
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    final fillPaint = Paint()
      ..color = CyberColors.green.withOpacity(0.15)
      ..style = PaintingStyle.fill;

    final rect = Rect.fromLTWH(0, 0, size.width, size.height);
    canvas.drawRect(rect, fillPaint);
    canvas.drawRect(rect, borderPaint);

    // Draw the triangle centered inside
    final cx = size.width / 2 + 2; // slight right offset for optical centering
    final cy = size.height / 2;
    final tw = 22.0;
    final th = 28.0;

    final triPaint = Paint()
      ..color = CyberColors.green
      ..style = PaintingStyle.fill;

    final path = Path()
      ..moveTo(cx - tw / 2, cy - th / 2)
      ..lineTo(cx + tw / 2, cy)
      ..lineTo(cx - tw / 2, cy + th / 2)
      ..close();

    canvas.drawPath(path, triPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}