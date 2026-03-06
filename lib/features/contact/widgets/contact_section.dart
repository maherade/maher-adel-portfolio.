import 'package:flutter/material.dart';
import 'package:unping_task/core/constants/app_colors.dart';
import 'package:unping_task/core/utils/responsive.dart';
import 'package:unping_task/core/widgets/scroll_reveal.dart';
import 'package:unping_task/core/widgets/section_header.dart';
import 'package:unping_task/generated/assets.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactSection extends StatelessWidget {
  const ContactSection({super.key});

  static final _socialLinks = [
    _SocialLink(
      icon: Assets.imagesGithub,
      label: 'GitHub',
      handle: '@maherade',
      url: 'https://github.com/maherade',
    ),
    _SocialLink(
      icon: Assets.imagesLinkedin,
      label: 'LinkedIn',
      handle: 'Maher Adel',
      url: 'https://www.linkedin.com/in/maher-adel-234722191/',
    ),
    _SocialLink(
      icon: Assets.imagesMail,
      label: 'Email',
      handle: 'maheradel451@gmail.com',
      url: 'mailto:maheradel451@gmail.com',
    ),
    _SocialLink(
      icon: Assets.imagesTelephone,
      label: 'Phone',
      handle: '+20 155 458 3937',
      url: 'tel:+201554583937',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final cs = AppColors.of(context);
    final mobile = AppResponsive.isMobile(context);

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: AppResponsive.hPad(context),
        vertical: AppResponsive.vPad(context),
      ),
      child: mobile
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ScrollReveal(
                  child: _ContactInfo(cs: cs, socialLinks: _socialLinks),
                ),
              ],
            )
          : Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 4,
                  child: ScrollReveal(
                    slideBegin: const Offset(-0.06, 0),
                    child: _ContactInfo(cs: cs, socialLinks: []),
                  ),
                ),
                const SizedBox(width: 70),
                Expanded(
                  flex: 6,
                  child: ScrollReveal(
                    slideBegin: const Offset(0.06, 0),
                    delay: const Duration(milliseconds: 120),
                    child: _SocialList(cs: cs, links: _socialLinks),
                  ),
                ),
              ],
            ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────

class _SocialLink {
  final String icon;
  final String label;
  final String handle;
  final String url;

  const _SocialLink({
    required this.icon,
    required this.label,
    required this.handle,
    required this.url,
  });
}

class _ContactInfo extends StatelessWidget {
  final AppColors cs;
  final List<_SocialLink> socialLinks;
  const _ContactInfo({required this.cs, required this.socialLinks});

  @override
  Widget build(BuildContext context) {
    final mobile = AppResponsive.isMobile(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionHeader(
          tag: 'CONTACT',
          title: "Let's work\ntogether",
          subtitle:
              "I'm always open to discussing new projects, creative ideas, "
              "or opportunities to be part of your vision.",
        ),
        const SizedBox(height: 36),
        _EmailButton(cs: cs),
        if (mobile) ...[
          const SizedBox(height: 40),
          Text(
            'Find me online',
            style: TextStyle(
              color: cs.textPrimary,
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 16),
          _SocialList(cs: cs, links: ContactSection._socialLinks),
          const SizedBox(height: 40),
        ] else
          const SizedBox(height: 60),
        const _FooterNote(),
      ],
    );
  }
}

class _EmailButton extends StatefulWidget {
  final AppColors cs;
  const _EmailButton({required this.cs});

  @override
  State<_EmailButton> createState() => _EmailButtonState();
}

class _EmailButtonState extends State<_EmailButton> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final cs = widget.cs;
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => launchUrl(Uri.parse('mailto:maheradel451@gmail.com')),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 15),
          decoration: BoxDecoration(
            color: _hovered ? cs.accentLight : cs.accent,
            borderRadius: BorderRadius.circular(10),
            boxShadow: _hovered
                ? [
                    BoxShadow(
                      color: cs.accentWithOpacity(0.35),
                      blurRadius: 20,
                      offset: const Offset(0, 8),
                    ),
                  ]
                : [],
          ),
          child: const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.email_outlined, color: Colors.white, size: 17),
              SizedBox(width: 10),
              Text(
                'Say Hello',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SocialList extends StatelessWidget {
  final AppColors cs;
  final List<_SocialLink> links;
  const _SocialList({required this.cs, required this.links});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (!AppResponsive.isMobile(context)) ...[
          Text(
            'Find me online',
            style: TextStyle(
              color: cs.textPrimary,
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 20),
        ],
        ...links.asMap().entries.map(
          (e) => Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: ScrollReveal(
              slideBegin: const Offset(0.05, 0),
              delay: Duration(milliseconds: e.key * 80),
              child: _SocialCard(cs: cs, link: e.value),
            ),
          ),
        ),
      ],
    );
  }
}

class _SocialCard extends StatefulWidget {
  final AppColors cs;
  final _SocialLink link;
  const _SocialCard({required this.cs, required this.link});

  @override
  State<_SocialCard> createState() => _SocialCardState();
}

class _SocialCardState extends State<_SocialCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final cs = widget.cs;
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => launchUrl(Uri.parse(widget.link.url)),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: _hovered ? cs.accentWithOpacity(0.07) : cs.surface,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: _hovered ? cs.accentWithOpacity(0.35) : cs.border,
            ),
          ),
          child: Row(
            children: [
              Container(
                width: 38,
                height: 38,
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: cs.accentWithOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Image.asset(widget.link.icon, color: cs.accentLight),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.link.label,
                      style: TextStyle(
                        color: cs.textPrimary,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      widget.link.handle,
                      style: TextStyle(color: cs.textSecondary, fontSize: 12),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.north_east_rounded,
                size: 13,
                color: _hovered ? cs.accentLight : cs.textMuted,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _FooterNote extends StatelessWidget {
  const _FooterNote();

  @override
  Widget build(BuildContext context) {
    final cs = AppColors.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(height: 1, color: cs.border),
        const SizedBox(height: 20),
        Text(
          '© 2025 Maher Adel',
          style: TextStyle(
            color: cs.textMuted,
            fontSize: 13,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          'Designed & built with Flutter',
          style: TextStyle(color: cs.textMuted, fontSize: 12),
        ),
      ],
    );
  }
}
