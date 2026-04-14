import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AppLinks {
  static const androidDownloadUrl = 'https://ryzxalaibcwffoamznrg.supabase.co/storage/v1/object/public/app-releases/Codexa-1.1.1.apk';
  static const developerWebsiteUrl = 'https://deepanshux.tech';
  static const githubRepoUrl = 'https://github.com/Deepanshu-ui-dev/Codexa-App';
  static const privacyUrl = 'https://github.com/Deepanshu-ui-dev/Codexa-App/blob/main/PRIVACY.md';
  static const linkedinUrl = 'https://linkedin.com/in/deepanshux';
}

const _kBg = Color(0xFF0A0E27);
const _kBgCard = Color(0xFF1A1F3A);
const _kAccent = Color(0xFF5B9FFF);
const _kAccentDark = Color(0xFF3D7FD5);
const _kBorder = Color(0x14FFFFFF);
const _kBorderMid = Color(0x20FFFFFF);
const _kTextPrimary = Color(0xFFFFFFFF);
const _kTextSecondary = Color(0xFFB0B8D4);
const _kTextMuted = Color(0xFF7A8399);
const _kTextHint = Color(0xFF5A6278);
const _kSuccess = Color(0xFF10B981);
const _kWarning = Color(0xFFF59E0B);

void main() {
  runApp(const MaterialApp(
    title: 'Codexa — Competitive Programming Hub',
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            _NavBar(
              onPortfolioTap: () => _launchUrl(AppLinks.developerWebsiteUrl),
              onGithubTap: () => _launchUrl(AppLinks.githubRepoUrl),
            ),
            _HeroSection(onDownload: () => _launchUrl(AppLinks.androidDownloadUrl)),
            _FeaturesSection(),
            _StatsSection(),
            _DownloadCTASection(onDownload: () => _launchUrl(AppLinks.androidDownloadUrl)),
            _Footer(
              onGitHubTap: () => _launchUrl(AppLinks.githubRepoUrl),
              onPrivacyTap: () => _launchUrl(AppLinks.privacyUrl),
              onLinkedInTap: () => _launchUrl(AppLinks.linkedinUrl),
            ),
          ],
        ),
      ),
    );
  }
}

class _NavBar extends StatelessWidget {
  final VoidCallback onPortfolioTap, onGithubTap;
  const _NavBar({required this.onPortfolioTap, required this.onGithubTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 20),
      decoration: BoxDecoration(border: Border(bottom: BorderSide(color: _kBorder, width: 1))),
      child: Row(
        children: [
          const _LogoWidget(size: 32),
          const Spacer(),
          _NavLink(label: 'GitHub', onTap: onGithubTap),
          const SizedBox(width: 20),
          _NavButton(label: 'Portfolio ↗', onTap: onPortfolioTap),
        ],
      ),
    );
  }
}

class _NavLink extends StatefulWidget {
  final String label;
  final VoidCallback onTap;
  const _NavLink({required this.label, required this.onTap});

  @override
  State<_NavLink> createState() => _NavLinkState();
}

class _NavLinkState extends State<_NavLink> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: Text(
          widget.label,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w500,
            color: _hovered ? _kAccent : _kTextSecondary,
            decoration: _hovered ? TextDecoration.underline : null,
          ),
        ),
      ),
    );
  }
}

class _NavButton extends StatefulWidget {
  final String label;
  final VoidCallback onTap;
  const _NavButton({required this.label, required this.onTap});

  @override
  State<_NavButton> createState() => _NavButtonState();
}

class _NavButtonState extends State<_NavButton> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: _hovered ? _kAccent.withOpacity(0.15) : const Color(0x0AFFFFFF),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: _hovered ? _kAccent.withOpacity(0.5) : _kBorderMid),
          ),
          child: Text(
            widget.label,
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: _hovered ? _kAccent : _kTextSecondary),
          ),
        ),
      ),
    );
  }
}

class _LogoWidget extends StatelessWidget {
  final double size;
  const _LogoWidget({required this.size});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(size * 0.3),
            gradient: const LinearGradient(colors: [_kAccent, _kAccentDark], begin: Alignment.topLeft, end: Alignment.bottomRight),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(size * 0.3),
            child: Image.asset('assets/images/Codexa.png', width: size, height: size, fit: BoxFit.cover),
          ),
        ),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Codexa', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: _kTextPrimary)),
            Text('Competitive Hub', style: TextStyle(fontSize: 9, fontWeight: FontWeight.w400, color: _kTextMuted)),
          ],
        ),
      ],
    );
  }
}

class _HeroSection extends StatelessWidget {
  final VoidCallback onDownload;
  const _HeroSection({required this.onDownload});

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final isMobile = w < 768;
    
    return Container(
      padding: EdgeInsets.symmetric(horizontal: isMobile ? 24 : 40, vertical: isMobile ? 60 : 100),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 800),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(color: _kAccent.withOpacity(0.1), borderRadius: BorderRadius.circular(100), border: Border.all(color: _kAccent.withOpacity(0.3))),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(width: 6, height: 6, decoration: const BoxDecoration(color: _kSuccess, shape: BoxShape.circle)),
                    const SizedBox(width: 8),
                    const Text('Version 1.1.1 — Live & Ready', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w500, color: _kAccent)),
                  ],
                ),
              ),
              const SizedBox(height: 32),
              Text('Track Your Competitive Programming Journey, Unified.', textAlign: TextAlign.center, style: TextStyle(fontSize: isMobile ? 36 : 52, fontWeight: FontWeight.w700, letterSpacing: -1.5, height: 1.2, color: _kTextPrimary)),
              const SizedBox(height: 20),
              Text('Monitor LeetCode, Codeforces, CodeChef, HackerRank and more — all in one beautiful dashboard with zero clutter.', textAlign: TextAlign.center, style: TextStyle(fontSize: 15, color: _kTextSecondary, height: 1.6, fontWeight: FontWeight.w400)),
              const SizedBox(height: 40),
              Wrap(
                spacing: 16,
                runSpacing: 16,
                alignment: WrapAlignment.center,
                children: [
                  _PrimaryButton(label: '📲 Download APK', onTap: onDownload),
                  _SecondaryButton(label: 'Learn More', onTap: () {}),
                ],
              ),
              const SizedBox(height: 24),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(color: _kWarning.withOpacity(0.08), borderRadius: BorderRadius.circular(8), border: Border.all(color: _kWarning.withOpacity(0.2))),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.info_outline_rounded, size: 14, color: _kWarning),
                    const SizedBox(width: 10),
                    Flexible(child: Text('Enable "Unknown Sources" in your browser settings', style: TextStyle(fontSize: 12, color: _kTextMuted, fontWeight: FontWeight.w400))),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PrimaryButton extends StatefulWidget {
  final String label;
  final VoidCallback onTap;
  const _PrimaryButton({required this.label, required this.onTap});

  @override
  State<_PrimaryButton> createState() => _PrimaryButtonState();
}

class _PrimaryButtonState extends State<_PrimaryButton> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedScale(
          scale: _hovered ? 1.05 : 1.0,
          duration: const Duration(milliseconds: 200),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
            decoration: BoxDecoration(
              gradient: const LinearGradient(colors: [_kAccent, _kAccentDark], begin: Alignment.topLeft, end: Alignment.bottomRight),
              borderRadius: BorderRadius.circular(12),
              boxShadow: [BoxShadow(color: _kAccent.withOpacity(0.3), blurRadius: 20, offset: const Offset(0, 8))],
            ),
            child: Text(widget.label, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.white)),
          ),
        ),
      ),
    );
  }
}

class _SecondaryButton extends StatefulWidget {
  final String label;
  final VoidCallback onTap;
  const _SecondaryButton({required this.label, required this.onTap});

  @override
  State<_SecondaryButton> createState() => _SecondaryButtonState();
}

class _SecondaryButtonState extends State<_SecondaryButton> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
          decoration: BoxDecoration(color: _hovered ? _kBgCard : const Color(0x0AFFFFFF), borderRadius: BorderRadius.circular(12), border: Border.all(color: _hovered ? _kAccent.withOpacity(0.5) : _kBorderMid, width: 1.5)),
          child: Text(widget.label, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: _hovered ? _kAccent : _kTextSecondary)),
        ),
      ),
    );
  }
}

class _FeaturesSection extends StatelessWidget {
  const _FeaturesSection();

  static const features = [
    ('📊', 'Multi-Platform Track', 'Monitor LeetCode, Codeforces, CodeChef'),
    ('📈', 'Progress Analytics', 'Visual graphs and detailed statistics'),
    ('⚡', 'Real-time Sync', 'Instant updates from all platforms'),
    ('🎯', 'Personalized Goals', 'Set targets and track improvement'),
    ('🏆', 'Leaderboards', 'Compare stats with other programmers'),
    ('📱', 'Offline Support', 'Access data without internet'),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 80),
      color: _kBgCard.withOpacity(0.3),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Column(
            children: [
              const Text('Powerful Features ✨', style: TextStyle(fontSize: 36, fontWeight: FontWeight.w700, color: _kTextPrimary)),
              const SizedBox(height: 16),
              Text('Everything you need to master competitive programming', style: TextStyle(fontSize: 16, color: _kTextSecondary, fontWeight: FontWeight.w400)),
              const SizedBox(height: 60),
              GridView.count(
                shrinkWrap: true,
                crossAxisCount: 3,
                childAspectRatio: 1.1,
                mainAxisSpacing: 32,
                crossAxisSpacing: 32,
                children: features.map((f) => _FeatureCard(emoji: f.$1, title: f.$2, description: f.$3)).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _FeatureCard extends StatefulWidget {
  final String emoji, title, description;
  const _FeatureCard({required this.emoji, required this.title, required this.description});

  @override
  State<_FeatureCard> createState() => _FeatureCardState();
}

class _FeatureCardState extends State<_FeatureCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(color: _hovered ? _kBgCard : _kBgCard.withOpacity(0.5), borderRadius: BorderRadius.circular(16), border: Border.all(color: _hovered ? _kAccent.withOpacity(0.3) : _kBorder)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.emoji, style: const TextStyle(fontSize: 32)),
            const SizedBox(height: 16),
            Text(widget.title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: _kTextPrimary)),
            const SizedBox(height: 8),
            Text(widget.description, style: TextStyle(fontSize: 13, color: _kTextMuted, fontWeight: FontWeight.w400, height: 1.5)),
          ],
        ),
      ),
    );
  }
}

class _StatsSection extends StatelessWidget {
  const _StatsSection();

  static const stats = [('5+', 'Platforms'), ('1.1K+', 'Users'), ('100K+', 'Tracked'), ('24/7', 'Sync')];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 60),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1000),
          child: GridView.count(
            shrinkWrap: true,
            crossAxisCount: 4,
            childAspectRatio: 1.2,
            mainAxisSpacing: 24,
            crossAxisSpacing: 24,
            children: stats.map((s) => _StatCard(number: s.$1, label: s.$2)).toList(),
          ),
        ),
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String number, label;
  const _StatCard({required this.number, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: _kBgCard.withOpacity(0.5), borderRadius: BorderRadius.circular(16), border: Border.all(color: _kBorder)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(number, style: const TextStyle(fontSize: 28, fontWeight: FontWeight.w700, color: _kAccent)),
          const SizedBox(height: 8),
          Text(label, textAlign: TextAlign.center, style: TextStyle(fontSize: 12, color: _kTextMuted, fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }
}

class _DownloadCTASection extends StatelessWidget {
  final VoidCallback onDownload;
  const _DownloadCTASection({required this.onDownload});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 80),
      color: _kBgCard.withOpacity(0.4),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 600),
          child: Column(
            children: [
              const Text('Ready to Get Started? 🚀', style: TextStyle(fontSize: 32, fontWeight: FontWeight.w700, color: _kTextPrimary)),
              const SizedBox(height: 16),
              Text('Download Codexa now and start tracking your competitive programming journey', textAlign: TextAlign.center, style: TextStyle(fontSize: 15, color: _kTextSecondary, height: 1.6)),
              const SizedBox(height: 40),
              _PrimaryButton(label: '📲 Download APK', onTap: onDownload),
            ],
          ),
        ),
      ),
    );
  }
}

class _Footer extends StatelessWidget {
  final VoidCallback onGitHubTap, onPrivacyTap, onLinkedInTap;
  const _Footer({required this.onGitHubTap, required this.onPrivacyTap, required this.onLinkedInTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 40),
      decoration: BoxDecoration(border: Border(top: BorderSide(color: _kBorder, width: 1))),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const _LogoWidget(size: 24),
                  Row(
                    spacing: 24,
                    children: [_FooterLink(label: 'GitHub', onTap: onGitHubTap), _FooterLink(label: 'Privacy', onTap: onPrivacyTap), _FooterLink(label: 'LinkedIn', onTap: onLinkedInTap)],
                  ),
                ],
              ),
              const SizedBox(height: 32),
              Container(height: 1, color: _kBorder),
              const SizedBox(height: 24),
              Column(
                children: [
                  Text('© 2026 Codexa. Built with ❤️ by Deepanshu Kaushik', style: TextStyle(fontSize: 12, color: _kTextMuted, fontWeight: FontWeight.w400)),
                  const SizedBox(height: 12),
                  Text('Empower your competitive programming journey • Track • Analyze • Improve', style: TextStyle(fontSize: 11, color: _kTextHint, fontWeight: FontWeight.w400)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

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
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: Text(widget.label, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: _hovered ? _kAccent : _kTextMuted, decoration: _hovered ? TextDecoration.underline : null)),
      ),
    );
  }
}
