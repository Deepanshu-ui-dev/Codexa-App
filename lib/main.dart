import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

// ─── App Links ────────────────────────────────────────────────────────────────
class AppLinks {
  static const androidDownloadUrl =
      'https://ryzxalaibcwffoamznrg.supabase.co/storage/v1/object/public/app-releases/Codexa-1.1.1.apk';
  static const developerWebsiteUrl = 'https://deepanshux.tech';
  static const githubRepoUrl =
      'https://github.com/Deepanshu-ui-dev/Codexa-App';
  static const privacyUrl =
      'https://github.com/Deepanshu-ui-dev/Codexa-App/blob/main/PRIVACY.md';
}

// ─── Design Tokens ────────────────────────────────────────────────────────────
const _kBg            = Color(0xFF05080F);
const _kSurface       = Color(0xFF0C1020);
const _kAccent        = Color(0xFF4D7EFF);
const _kAccentLight   = Color(0xFF7FA5FF);
const _kAccentGlow    = Color(0x1A4D7EFF);
const _kBorderSub     = Color(0x18FFFFFF);
const _kBorderFaint   = Color(0x0CFFFFFF);
const _kTextPrimary   = Color(0xFFF0F2FF);
const _kTextSecondary = Color(0x99FFFFFF);
const _kTextMuted     = Color(0x55FFFFFF);
const _kTextHint      = Color(0x30FFFFFF);

// ─── Spacing ──────────────────────────────────────────────────────────────────
class _S {
  static const xs  = 4.0;
  static const sm  = 8.0;
  static const md  = 16.0;
  static const lg  = 24.0;
  static const xl  = 32.0;
  static const xxl = 48.0;
  static const xxxl = 80.0;
}

// ─── Breakpoints ─────────────────────────────────────────────────────────────
class _BP {
  static bool isMobile(double w)  => w < 700;
  static bool isTablet(double w)  => w >= 700 && w < 1100;
  static bool isDesktop(double w) => w >= 1100;
  static double hPad(double w)    => isMobile(w) ? _S.md : _S.lg;
}

Future<void> _launch(String url) async {
  final uri = Uri.tryParse(url);
  if (uri != null) await launchUrl(uri, mode: LaunchMode.externalApplication);
}

// ─── Entry ────────────────────────────────────────────────────────────────────
void main() {
  runApp(const MaterialApp(
    title: 'Codexa — Unified Competitive Programming',
    debugShowCheckedModeBanner: false,
    home: LandingScreen(),
  ));
}

// ─── Root Screen ──────────────────────────────────────────────────────────────
class LandingScreen extends StatelessWidget {
  const LandingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _kBg,
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _NavBar(onPortfolioTap: () => _launch(AppLinks.developerWebsiteUrl)),
                _HeroSection(onDownload: () => _launch(AppLinks.androidDownloadUrl)),
                const _PlatformsSection(),
                _Footer(
                  onGitHubTap: () => _launch(AppLinks.githubRepoUrl),
                  onPrivacyTap: () => _launch(AppLinks.privacyUrl),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

// ─── NavBar ───────────────────────────────────────────────────────────────────
class _NavBar extends StatelessWidget {
  final VoidCallback onPortfolioTap;
  const _NavBar({required this.onPortfolioTap});

  @override
  Widget build(BuildContext context) {
    final w         = MediaQuery.of(context).size.width;
    final topPad    = MediaQuery.of(context).viewPadding.top;
    final hPad      = _BP.hPad(w);
    final iconSize  = _BP.isMobile(w) ? 26.0 : 30.0;

    return Container(
      padding: EdgeInsets.fromLTRB(hPad, topPad + 14, hPad, 14),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: _kBorderFaint)),
      ),
      child: Row(
        children: [
          _Logo(iconSize: iconSize),
          const Spacer(),
          _GhostButton(label: 'Developer ↗', onTap: onPortfolioTap),
        ],
      ),
    );
  }
}

// ─── Logo ─────────────────────────────────────────────────────────────────────
class _Logo extends StatelessWidget {
  final double iconSize;
  const _Logo({required this.iconSize});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(iconSize * 0.22),
          child: Image.asset(
            'assets/images/Codexa.png',
            width: iconSize,
            height: iconSize,
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(width: 10),
        Text(
          'Codexa',
          style: TextStyle(
            fontSize: iconSize * 0.52,
            fontWeight: FontWeight.w600,
            letterSpacing: -0.5,
            color: _kTextPrimary,
          ),
        ),
      ],
    );
  }
}

// ─── Ghost Button ─────────────────────────────────────────────────────────────
class _GhostButton extends StatefulWidget {
  final String label;
  final VoidCallback onTap;
  const _GhostButton({required this.label, required this.onTap});

  @override
  State<_GhostButton> createState() => _GhostButtonState();
}

class _GhostButtonState extends State<_GhostButton> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit:  (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          decoration: BoxDecoration(
            color: _hovered
                ? const Color(0x12FFFFFF)
                : const Color(0x07FFFFFF),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: _hovered ? _kBorderSub : _kBorderFaint,
            ),
          ),
          child: Text(
            widget.label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: _hovered ? _kTextSecondary : _kTextMuted,
            ),
          ),
        ),
      ),
    );
  }
}

// ─── Hero Section ─────────────────────────────────────────────────────────────
class _HeroSection extends StatelessWidget {
  final VoidCallback onDownload;
  const _HeroSection({required this.onDownload});

  @override
  Widget build(BuildContext context) {
    final w          = MediaQuery.of(context).size.width;
    final isMobile   = _BP.isMobile(w);
    final isDesktop  = _BP.isDesktop(w);
    final hPad       = _BP.hPad(w);

    final double topPad    = isMobile ? _S.xl : isDesktop ? _S.xxxl : _S.xxl;
    final double botPad    = isMobile ? _S.xl : _S.xxl;
    final double titleSize = isMobile ? 36.0 : isDesktop ? 64.0 : 48.0;

    return Stack(
      alignment: Alignment.topCenter,
      children: [
        // Subtle glow behind headline
        Positioned(
          top: topPad,
          child: Container(
            width: 480,
            height: 280,
            decoration: BoxDecoration(
              gradient: RadialGradient(
                colors: [
                  _kAccent.withOpacity(0.10),
                  Colors.transparent,
                ],
                radius: 0.85,
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(hPad, topPad, hPad, botPad),
          child: Column(
            children: [
              const _VersionBadge(),
              const SizedBox(height: 20),
              _Headline(titleSize: titleSize, isMobile: isMobile),
              const SizedBox(height: 16),
              _Subtitle(isMobile: isMobile),
              SizedBox(height: isMobile ? _S.xl : 36.0),
              _DownloadButton(onTap: onDownload, isMobile: isMobile),
              const SizedBox(height: 12),
              const _InstallHint(),
            ],
          ),
        ),
      ],
    );
  }
}

// ─── Headline ─────────────────────────────────────────────────────────────────
class _Headline extends StatelessWidget {
  final double titleSize;
  final bool isMobile;
  const _Headline({required this.titleSize, required this.isMobile});

  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        style: TextStyle(
          fontSize: titleSize,
          fontWeight: FontWeight.w700,
          letterSpacing: isMobile ? -1.5 : -2.5,
          height: 1.08,
        ),
        children: const [
          TextSpan(
            text: 'Your competitive\n',
            style: TextStyle(color: _kTextPrimary),
          ),
          TextSpan(
            text: 'programming, ',
            style: TextStyle(color: _kTextMuted),
          ),
          TextSpan(
            text: 'unified.',
            style: TextStyle(color: _kTextPrimary),
          ),
        ],
      ),
    );
  }
}

// ─── Subtitle ────────────────────────────────────────────────────────────────
class _Subtitle extends StatelessWidget {
  final bool isMobile;
  const _Subtitle({required this.isMobile});

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxWidth: isMobile ? double.infinity : 400,
      ),
      child: Text(
        'Track LeetCode, Codeforces, CodeChef and more — one clean dashboard, zero clutter.',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: isMobile ? 14.0 : 15.0,
          color: _kTextMuted,
          height: 1.8,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }
}

// ─── Version Badge ────────────────────────────────────────────────────────────
class _VersionBadge extends StatelessWidget {
  const _VersionBadge();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
      decoration: BoxDecoration(
        color: _kAccentGlow,
        borderRadius: BorderRadius.circular(100),
        border: Border.all(color: _kAccent.withOpacity(0.28)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Pulsing dot
          Container(
            width: 5,
            height: 5,
            decoration: const BoxDecoration(
              color: _kAccent,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 14),
          const Text(
            'Version 1.1.1 — now live',
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w500,
              color: _kAccentLight,
              letterSpacing: 0.4,
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Download Button ──────────────────────────────────────────────────────────
class _DownloadButton extends StatefulWidget {
  final VoidCallback onTap;
  final bool isMobile;
  const _DownloadButton({required this.onTap, required this.isMobile});

  @override
  State<_DownloadButton> createState() => _DownloadButtonState();
}

class _DownloadButtonState extends State<_DownloadButton> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final fullWidth = _BP.isMobile(w);

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit:  (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedScale(
          scale: _hovered ? 1.025 : 1.0,
          duration: const Duration(milliseconds: 160),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 150),
            width: fullWidth ? double.infinity : null,
            padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 15),
            decoration: BoxDecoration(
              color: _hovered ? const Color(0xFFF5F7FF) : Colors.white,
              borderRadius: BorderRadius.circular(11),
              boxShadow: [
                BoxShadow(
                  color: _kAccent.withOpacity(_hovered ? 0.28 : 0.14),
                  blurRadius: _hovered ? 28 : 14,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              mainAxisSize: fullWidth ? MainAxisSize.max : MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(Icons.download_rounded, color: Color(0xFF060A1A), size: 17),
                SizedBox(width: 14),
                Text(
                  'Download for Android',
                  style: TextStyle(
                    fontSize: 13.5,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF060A1A),
                    letterSpacing: -0.2,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ─── Install Hint ─────────────────────────────────────────────────────────────
class _InstallHint extends StatelessWidget {
  const _InstallHint();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 9),
      decoration: BoxDecoration(
        color: const Color(0x05FFFFFF),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: _kBorderFaint),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: const [
          Icon(Icons.info_outline_rounded, size: 12, color: _kTextMuted),
          SizedBox(width: 14),
          Flexible(
            child: Text.rich(
              TextSpan(
                style: TextStyle(fontSize: 11, height: 1.5),
                children: [
                  TextSpan(
                    text: 'Enable ',
                    style: TextStyle(color: _kTextHint),
                  ),
                  TextSpan(
                    text: 'Install from unknown sources',
                    style: TextStyle(
                      color: _kTextSecondary,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  TextSpan(
                    text: ' in Settings before installing',
                    style: TextStyle(color: _kTextHint),
                  ),
                ],
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Platforms Section ────────────────────────────────────────────────────────
class _PlatformsSection extends StatelessWidget {
  const _PlatformsSection();

  static const _items = [
    ('LeetCode',      Color(0xFF4CAF50)),
    ('Codeforces',    _kAccent),
    ('CodeChef',      Color(0xFFF59E0B)),
    ('HackerRank',    Color(0xFF06B6D4)),
    ('GitHub',        Color(0x80FFFFFF)),
    ('GeeksforGeeks', Color(0xFF4CAF50)),
  ];

  @override
  Widget build(BuildContext context) {
    final w        = MediaQuery.of(context).size.width;
    final hPad     = _BP.hPad(w);
    final isMobile = _BP.isMobile(w);

    return Padding(
      padding: EdgeInsets.fromLTRB(hPad, 0, hPad, isMobile ? _S.xl : _S.xxl),
      child: Column(
        children: [
          Row(children: const [
            Expanded(child: Divider(color: _kBorderFaint, thickness: 0.5)),
            SizedBox(width: 14),
            Text(
              'supported platforms',
              style: TextStyle(fontSize: 11, color: _kTextHint, letterSpacing: 0.3),
            ),
            SizedBox(width: 14),
            Expanded(child: Divider(color: _kBorderFaint, thickness: 0.5)),
          ]),
          const SizedBox(height: 14),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            alignment: WrapAlignment.center,
            children: _items
                .map((p) => _Chip(label: p.$1, dot: p.$2))
                .toList(),
          ),
        ],
      ),
    );
  }
}

class _Chip extends StatelessWidget {
  final String label;
  final Color dot;
  const _Chip({required this.label, required this.dot});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
      decoration: BoxDecoration(
        color: const Color(0x06FFFFFF),
        borderRadius: BorderRadius.circular(7),
        border: Border.all(color: _kBorderFaint),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 5,
            height: 5,
            decoration: BoxDecoration(color: dot, shape: BoxShape.circle),
          ),
          const SizedBox(width: 10),
          Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: _kTextMuted,
              letterSpacing: 0.1,
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Footer ───────────────────────────────────────────────────────────────────
class _Footer extends StatelessWidget {
  final VoidCallback onGitHubTap;
  final VoidCallback onPrivacyTap;
  const _Footer({required this.onGitHubTap, required this.onPrivacyTap});

  @override
  Widget build(BuildContext context) {
    final w         = MediaQuery.of(context).size.width;
    final isMobile  = _BP.isMobile(w);
    final hPad      = _BP.hPad(w);
    final bottomSafe = MediaQuery.of(context).padding.bottom;

    return Container(
      padding: EdgeInsets.fromLTRB(hPad, 14, hPad, bottomSafe + _S.md),
      decoration: const BoxDecoration(
        border: Border(top: BorderSide(color: _kBorderFaint)),
      ),
      child: isMobile
          ? _FooterMobile(onGitHubTap: onGitHubTap, onPrivacyTap: onPrivacyTap)
          : _FooterDesktop(onGitHubTap: onGitHubTap, onPrivacyTap: onPrivacyTap),
    );
  }
}

class _FooterMobile extends StatelessWidget {
  final VoidCallback onGitHubTap;
  final VoidCallback onPrivacyTap;
  const _FooterMobile({required this.onGitHubTap, required this.onPrivacyTap});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const _Logo(iconSize: 22),
        const SizedBox(height: 8),
        Wrap(
          alignment: WrapAlignment.center,
          spacing: 18,
          runSpacing: 4,
          children: [
            _FooterLink(label: 'GitHub',  onTap: onGitHubTap),
           
          ],
        ),
        const SizedBox(height: 8),
        const Text(
          '© 2026 — built for developers',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 11, color: _kTextHint),
        ),
      ],
    );
  }
}

class _FooterDesktop extends StatelessWidget {
  final VoidCallback onGitHubTap;
  final VoidCallback onPrivacyTap;
  const _FooterDesktop({required this.onGitHubTap, required this.onPrivacyTap});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const _Logo(iconSize: 22),
        const Spacer(),
        const Text(
          '© 2026 — built for developers',
          style: TextStyle(fontSize: 11, color: _kTextHint),
        ),
        const Spacer(),
        _FooterLink(label: 'GitHub',  onTap: onGitHubTap),
        const SizedBox(width: 16),
       
      ],
    );
  }
}

// ─── Footer Link ──────────────────────────────────────────────────────────────
class _FooterLink extends StatefulWidget {
  final String label;
  final VoidCallback onTap;
  const _FooterLink({required this.label, required this.onTap});

  @override
  State<_FooterLink> createState() => _FooterLinkState();
}

class _FooterLinkState extends State<_FooterLink> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit:  (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedDefaultTextStyle(
          duration: const Duration(milliseconds: 150),
          style: TextStyle(
            fontSize: 11,
            color: _hovered ? _kTextSecondary : _kTextHint,
          ),
          child: Text(widget.label),
        ),
      ),
    );
  }
}