import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

// ─── Constants ───────────────────────────────────────────────────────────────
class AppLinks {
  static const androidDownloadUrl =
      'https://ryzxalaibcwffoamznrg.supabase.co/storage/v1/object/public/app-releases/Codexa-1.1.1.apk';
  static const developerWebsiteUrl = 'https://deepanshux.tech';
  static const githubRepoUrl = 'https://github.com/Deepanshu-ui-dev/Codexa-App';
  static const privacyUrl =
      'https://github.com/Deepanshu-ui-dev/Codexa-App/blob/main/PRIVACY.md';
}

// ─── Theme ───────────────────────────────────────────────────────────────────
const _kBg            = Color(0xFF05080F);
const _kAccent        = Color(0xFF4D7EFF);
const _kAccentLight   = Color(0xFF7FA5FF);
const _kBorderSub     = Color(0x14FFFFFF);
const _kBorderFaint   = Color(0x0AFFFFFF);
const _kTextPrimary   = Color(0xFFF0F2FF);
const _kTextSecondary = Color(0x70FFFFFF);
const _kTextMuted     = Color(0x45FFFFFF);
const _kTextHint      = Color(0x28FFFFFF);

// ─── Breakpoints ─────────────────────────────────────────────────────────────
class _BP {
  static bool isMobile(double w)  => w < 480;
  static bool isTablet(double w)  => w >= 480 && w < 900;
  static bool isDesktop(double w) => w >= 900;
}

Future<void> _launch(String url) async {
  final uri = Uri.tryParse(url);
  if (uri != null) await launchUrl(uri, mode: LaunchMode.externalApplication);
}

// ─── App ─────────────────────────────────────────────────────────────────────
void main() {
  runApp(const MaterialApp(
    title: 'Codexa — Unified Competitive Programming',
    debugShowCheckedModeBanner: false,
    home: LandingScreen(),
  ));
}

class LandingScreen extends StatelessWidget {
  const LandingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _kBg,
      body: SingleChildScrollView(
        child: Column(
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
      ),
    );
  }
}

// ─── Navbar ──────────────────────────────────────────────────────────────────
class _NavBar extends StatelessWidget {
  final VoidCallback onPortfolioTap;
  const _NavBar({required this.onPortfolioTap, super.key});

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final hPad = _BP.isMobile(w) ? 16.0 : 28.0;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: hPad, vertical: 16),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: _kBorderFaint)),
      ),
      child: Row(
        children: [
          _Logo(iconSize: _BP.isMobile(w) ? 26.0 : 30.0),
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
  const _Logo({required this.iconSize, super.key});

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
            fontSize: iconSize * 0.5,
            fontWeight: FontWeight.w600,
            letterSpacing: -0.4,
            color: _kTextPrimary,
          ),
        ),
      ],
    );
  }
}

// ─── Ghost button ─────────────────────────────────────────────────────────────
class _GhostButton extends StatefulWidget {
  final String label;
  final VoidCallback onTap;
  const _GhostButton({required this.label, required this.onTap, super.key});

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
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 7),
          decoration: BoxDecoration(
            color: _hovered ? const Color(0x10FFFFFF) : const Color(0x07FFFFFF),
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

// ─── Hero ─────────────────────────────────────────────────────────────────────
class _HeroSection extends StatelessWidget {
  final VoidCallback onDownload;
  const _HeroSection({required this.onDownload, super.key});

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final isMobile  = _BP.isMobile(w);
    final isDesktop = _BP.isDesktop(w);

    final double hPad     = isMobile ? 20.0 : 28.0;
    final double topPad   = isMobile ? 52.0 : isDesktop ? 100.0 : 80.0;
    final double titleSize = isMobile ? 34.0 : isDesktop ? 64.0 : 48.0;
    final double subtitleSize = isMobile ? 14.0 : 15.0;
    final double maxSubtitleWidth = isMobile ? double.infinity : 420.0;

    return Padding(
      padding: EdgeInsets.fromLTRB(hPad, topPad, hPad, 28),
      child: Column(
        children: [
          _VersionBadge(),
          const SizedBox(height: 20),
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              style: TextStyle(
                fontSize: titleSize,
                fontWeight: FontWeight.w600,
                letterSpacing: isMobile ? -1.5 : -2.5,
                height: 1.05,
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
          ),
          const SizedBox(height: 14),
          ConstrainedBox(
            constraints: BoxConstraints(maxWidth: maxSubtitleWidth),
            child: Text(
              'Track LeetCode, Codeforces, CodeChef and more — one clean dashboard, zero clutter.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: subtitleSize,
                color: _kTextMuted,
                height: 1.75,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          SizedBox(height: isMobile ? 28.0 : 34.0),
          _DownloadButton(onTap: onDownload),
          const SizedBox(height: 14),
          // On very small screens, wrap the hint text
          isMobile ? const _InstallHintWrapped() : const _InstallHint(),
        ],
      ),
    );
  }
}

// ─── Version badge ────────────────────────────────────────────────────────────
class _VersionBadge extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
      decoration: BoxDecoration(
        color: _kAccent.withOpacity(0.09),
        borderRadius: BorderRadius.circular(100),
        border: Border.all(color: _kAccent.withOpacity(0.25)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 5,
            height: 5,
            decoration: const BoxDecoration(
              color: _kAccent,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 8),
          const Text(
            'Version 1.1.1 — now live',
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w500,
              color: _kAccentLight,
              letterSpacing: 0.3,
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Download button ──────────────────────────────────────────────────────────
class _DownloadButton extends StatefulWidget {
  final VoidCallback onTap;
  const _DownloadButton({required this.onTap, super.key});

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
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedScale(
          scale: _hovered ? 1.03 : 1.0,
          duration: const Duration(milliseconds: 160),
          child: Container(
            width: fullWidth ? double.infinity : null,
            padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 14),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisSize: fullWidth ? MainAxisSize.max : MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(Icons.download_rounded, color: Color(0xFF0A0D18), size: 16),
                SizedBox(width: 9),
                Text(
                  'Download for Android',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF0A0D18),
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

// ─── Install hint (single row — tablet/desktop) ───────────────────────────────
class _InstallHint extends StatelessWidget {
  const _InstallHint({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 9),
      decoration: BoxDecoration(
        color: const Color(0x05FFFFFF),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: _kBorderFaint),
      ),
      child: const Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.info_outline_rounded, size: 12, color: _kTextMuted),
          SizedBox(width: 8),
          Text('Enable ', style: TextStyle(fontSize: 11, color: _kTextHint)),
          Text(
            'Install from unknown sources',
            style: TextStyle(
              fontSize: 11,
              color: _kTextSecondary,
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(' before installing',
              style: TextStyle(fontSize: 11, color: _kTextHint)),
        ],
      ),
    );
  }
}

// ─── Install hint (wrapped — mobile) ─────────────────────────────────────────
class _InstallHintWrapped extends StatelessWidget {
  const _InstallHintWrapped({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: const Color(0x05FFFFFF),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: _kBorderFaint),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Padding(
            padding: EdgeInsets.only(top: 1),
            child: Icon(Icons.info_outline_rounded, size: 12, color: _kTextMuted),
          ),
          SizedBox(width: 8),
          Expanded(
            child: Text.rich(
              TextSpan(
                style: TextStyle(fontSize: 11, height: 1.6),
                children: [
                  TextSpan(text: 'Enable ', style: TextStyle(color: _kTextHint)),
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
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Platforms Section ────────────────────────────────────────────────────────
class _PlatformsSection extends StatelessWidget {
  const _PlatformsSection({super.key});

  static const _items = [
    ('LeetCode', Color(0xFF4CAF50)),
    ('Codeforces', _kAccent),
    ('CodeChef', Color(0xFFF59E0B)),
    ('HackerRank', Color(0xFF06B6D4)),
    ('GitHub', Color(0x80FFFFFF)),
    ('GeeksforGeeks', Color(0xFF4CAF50)),
  ];

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final hPad = _BP.isMobile(w) ? 16.0 : 24.0;

    return Padding(
      padding: EdgeInsets.fromLTRB(hPad, 16, hPad, 40),
      child: Column(
        children: [
          Row(
            children: const [
              Expanded(child: Divider(color: _kBorderFaint, thickness: 0.5)),
              SizedBox(width: 14),
              Text(
                'supported platforms',
                style: TextStyle(fontSize: 11, color: _kTextHint),
              ),
              SizedBox(width: 14),
              Expanded(child: Divider(color: _kBorderFaint, thickness: 0.5)),
            ],
          ),
          const SizedBox(height: 20),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            alignment: WrapAlignment.center,
            children: _items.map((p) => _Chip(label: p.$1, dot: p.$2)).toList(),
          ),
        ],
      ),
    );
  }
}

class _Chip extends StatelessWidget {
  final String label;
  final Color dot;
  const _Chip({required this.label, required this.dot, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 6),
      decoration: BoxDecoration(
        color: const Color(0x05FFFFFF),
        borderRadius: BorderRadius.circular(6),
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
          const SizedBox(width: 7),
          Text(
            label,
            style: const TextStyle(
              fontSize: 11.5,
              fontWeight: FontWeight.w400,
              color: _kTextMuted,
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
  const _Footer({required this.onGitHubTap, required this.onPrivacyTap, super.key});

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final isMobile = _BP.isMobile(w);
    final hPad = isMobile ? 16.0 : 28.0;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: hPad, vertical: isMobile ? 20 : 16),
      decoration: const BoxDecoration(
        border: Border(top: BorderSide(color: _kBorderFaint)),
      ),
      child: isMobile
          ? _FooterMobile(
              onGitHubTap: onGitHubTap,
              onPrivacyTap: onPrivacyTap,
            )
          : _FooterDesktop(
              onGitHubTap: onGitHubTap,
              onPrivacyTap: onPrivacyTap,
            ),
    );
  }
}

class _FooterDesktop extends StatelessWidget {
  final VoidCallback onGitHubTap;
  final VoidCallback onPrivacyTap;
  const _FooterDesktop({required this.onGitHubTap, required this.onPrivacyTap, super.key});

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
        _FooterLink(label: 'GitHub', onTap: onGitHubTap),
        const SizedBox(width: 18),
        _FooterLink(label: 'Privacy', onTap: onPrivacyTap),
      ],
    );
  }
}

class _FooterMobile extends StatelessWidget {
  final VoidCallback onGitHubTap;
  final VoidCallback onPrivacyTap;
  const _FooterMobile({required this.onGitHubTap, required this.onPrivacyTap, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const _Logo(iconSize: 22),
        const SizedBox(height: 14),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _FooterLink(label: 'GitHub', onTap: onGitHubTap),
            const SizedBox(width: 20),
            _FooterLink(label: 'Privacy', onTap: onPrivacyTap),
          ],
        ),
        const SizedBox(height: 10),
        const Text(
          '© 2026 — built for developers',
          style: TextStyle(fontSize: 11, color: _kTextHint),
        ),
      ],
    );
  }
}

class _FooterLink extends StatefulWidget {
  final String label;
  final VoidCallback onTap;
  const _FooterLink({required this.label, required this.onTap, super.key});

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
      onExit: (_) => setState(() => _hovered = false),
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