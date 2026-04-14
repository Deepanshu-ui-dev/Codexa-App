import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

// ─── Constants ──────────────────────────────────────────────────────────────
class AppLinks {
  static const androidDownloadUrl = 'https://ryzxalaibcwffoamznrg.supabase.co/storage/v1/object/public/app-releases/Codexa-1.1.1.apk';
  static const developerWebsiteUrl = 'https://deepanshux.tech';
  static const githubRepoUrl = 'https://github.com/Deepanshu-ui-dev/Codexa-App';
  static const privacyUrl = 'https://github.com/Deepanshu-ui-dev/Codexa-App/blob/main/PRIVACY.md';
}

// ─── Theme Colors ────────────────────────────────────────────────────────────
const _kBg = Color(0xFF05080F);
const _kAccent = Color(0xFF4D7EFF);
const _kBorder = Color(0x0FFFFFFF);
const _kBorderMid = Color(0x14FFFFFF);
const _kTextPrimary = Color(0xFFF0F2FF);
const _kTextSecondary = Color(0x73FFFFFF);
const _kTextMuted = Color(0x40FFFFFF);
const _kTextHint = Color(0x29FFFFFF);

void main() {
  runApp(const MaterialApp(
    title: 'Codexa — Unified Competitive Programming',
    debugShowCheckedModeBanner: false,
    home: LandingScreen(),
  ));
}

class LandingScreen extends StatelessWidget {
  const LandingScreen({super.key});

  Future<void> _launchUrl(String url) async {
    final uri = Uri.tryParse(url);
    if (uri != null) await launchUrl(uri, mode: LaunchMode.externalApplication);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _kBg,
      body: Column(
        children: [
          _NavBar(
            onPortfolioTap: () => _launchUrl(AppLinks.developerWebsiteUrl),
          ),
          Expanded(
            child: _HeroSection(
              onDownload: () => _launchUrl(AppLinks.androidDownloadUrl),
            ),
          ),
          _Footer(
            onGitHubTap: () => _launchUrl(AppLinks.githubRepoUrl),
            onPrivacyTap: () => _launchUrl(AppLinks.privacyUrl),
          ),
        ],
      ),
    );
  }
}

// ─── Navbar ──────────────────────────────────────────────────────────────────
class _NavBar extends StatelessWidget {
  final VoidCallback onPortfolioTap;
  const _NavBar({required this.onPortfolioTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 16),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: _kBorder)),
      ),
      child: Row(
        children: [
          const _LogoWidget(size: 30, fontSize: 14),
          const Spacer(),
          _NavOutlineButton(label: 'Developer ↗', onTap: onPortfolioTap),
        ],
      ),
    );
  }
}

class _LogoWidget extends StatelessWidget {
  final double size;
  final double fontSize;
  const _LogoWidget({required this.size, required this.fontSize});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(size * 0.25),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(size * 0.25),
            child: Image.asset(
              'assets/images/Codexa.png',
              width: size,
              height: size,
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(width: 9),
        const Text('Codexa',
            style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                letterSpacing: -0.3,
                color: _kTextPrimary)),
      ],
    );
  }
}

class _NavOutlineButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  const _NavOutlineButton({required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
        decoration: BoxDecoration(
          color: const Color(0x0AFFFFFF),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: _kBorderMid),
        ),
        child: Text(label,
            style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: _kTextSecondary)),
      ),
    );
  }
}

// ─── Hero ────────────────────────────────────────────────────────────────────
class _HeroSection extends StatelessWidget {
  final VoidCallback onDownload;
  const _HeroSection({required this.onDownload});

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    return Center(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 64),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
                decoration: BoxDecoration(
                  color: _kAccent.withOpacity(0.07),
                  borderRadius: BorderRadius.circular(100),
                  border: Border.all(color: _kAccent.withOpacity(0.3)),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                        width: 6,
                        height: 6,
                        decoration: const BoxDecoration(
                            color: _kAccent, shape: BoxShape.circle)),
                    const SizedBox(width: 7),
                    const Text('Version 1.1.1 — now live',
                        style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF7FA5FF),
                            letterSpacing: 0.3)),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              Text(
                'Your competitive\nprogramming, unified.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: w > 600 ? 52 : 40,
                  fontWeight: FontWeight.w500,
                  letterSpacing: -2,
                  height: 1.07,
                  color: _kTextPrimary,
                ),
              ),
              const SizedBox(height: 18),
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 400),
                child: const Text(
                  'Track LeetCode, Codeforces, CodeChef and more — one clean dashboard, zero clutter.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 14,
                      color: _kTextMuted,
                      height: 1.75,
                      fontWeight: FontWeight.w400),
                ),
              ),
              const SizedBox(height: 40),
              _DownloadButton(onTap: onDownload),
              const SizedBox(height: 20),
              const _InstallHint(),
              const SizedBox(height: 48),
              const _PlatformRow(),
            ],
          ),
        ),
      ),
    );
  }
}

class _DownloadButton extends StatefulWidget {
  final VoidCallback onTap;
  const _DownloadButton({required this.onTap});

  @override
  State<_DownloadButton> createState() => _DownloadButtonState();
}

class _DownloadButtonState extends State<_DownloadButton> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedScale(
          scale: _hovered ? 1.04 : 1.0,
          duration: const Duration(milliseconds: 180),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 11),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: const [
                Icon(Icons.download_rounded, color: Color(0xFF0A0D18), size: 16),
                SizedBox(width: 8),
                Text('Download APK',
                    style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF0A0D18))),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _InstallHint extends StatelessWidget {
  const _InstallHint();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
      decoration: BoxDecoration(
        color: const Color(0x06FFFFFF),
        borderRadius: BorderRadius.circular(9),
        border: Border.all(color: _kBorder),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: const [
          Icon(Icons.info_outline_rounded,
              size: 13, color: Color(0x40FFFFFF)),
          SizedBox(width: 8),
          Text('Enable ', style: TextStyle(fontSize: 11, color: _kTextHint)),
          Text('Install from unknown sources',
              style: TextStyle(
                  fontSize: 11,
                  color: _kTextSecondary,
                  fontWeight: FontWeight.w500)),
          Text(' in your browser settings before installing',
              style: TextStyle(fontSize: 11, color: _kTextHint)),
        ],
      ),
    );
  }
}

class _PlatformRow extends StatelessWidget {
  const _PlatformRow();

  static const _platforms = [
    ('LeetCode', Color(0xFF4CAF50)),
    ('Codeforces', _kAccent),
    ('CodeChef', Color(0xFFF59E0B)),
    ('HackerRank', Color(0xFF06B6D4)),
    ('GitHub', Color(0x80FFFFFF)),
    ('GeeksforGeeks', Color(0xFF2E7D32)),
  ];

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      alignment: WrapAlignment.center,
      children: _platforms
          .map((p) => _PlatformChip(label: p.$1, color: p.$2))
          .toList(),
    );
  }
}

class _PlatformChip extends StatelessWidget {
  final String label;
  final Color color;
  const _PlatformChip({required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 5),
      decoration: BoxDecoration(
        color: const Color(0x05FFFFFF),
        borderRadius: BorderRadius.circular(7),
        border: Border.all(color: _kBorder),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
              width: 5,
              height: 5,
              decoration:
                  BoxDecoration(color: color, shape: BoxShape.circle)),
          const SizedBox(width: 6),
          Text(label,
              style: const TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w400,
                  color: _kTextHint)),
        ],
      ),
    );
  }
}

class _Footer extends StatelessWidget {
  final VoidCallback onGitHubTap;
  final VoidCallback onPrivacyTap;
  const _Footer({required this.onGitHubTap, required this.onPrivacyTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 15),
      decoration: const BoxDecoration(
        border: Border(top: BorderSide(color: _kBorder)),
      ),
      child: Row(
        children: [
          const _LogoWidget(size: 22, fontSize: 10),
          const Spacer(),
          const Text('© 2026 — built for developers',
              style: TextStyle(fontSize: 11, color: _kTextHint)),
          const Spacer(),
          GestureDetector(
            onTap: onGitHubTap,
            child: const Text('GitHub',
                style: TextStyle(fontSize: 11, color: Color(0x38FFFFFF))),
          ),
        ],
      ),
    );
  }
}
