import 'package:flutter/material.dart';
import 'package:unping_task/core/constants/app_colors.dart';
import 'package:unping_task/core/utils/cv_download.dart';
import 'package:unping_task/core/utils/responsive.dart';
import 'package:unping_task/generated/assets.dart';

class HeroSection extends StatelessWidget {
  final AnimationController heroAnimController;
  final AnimationController fadeController;
  final VoidCallback onGetInTouch;

  const HeroSection({
    super.key,
    required this.heroAnimController,
    required this.fadeController,
    required this.onGetInTouch,
  });

  @override
  Widget build(BuildContext context) {
    final cs = AppColors.of(context);
    final mobile = AppResponsive.isMobile(context);

    return Container(
      padding: EdgeInsets.fromLTRB(
        AppResponsive.hPad(context),
        mobile ? 96 : 120,
        AppResponsive.hPad(context),
        0, // Reduced bottom gap to bring About Section closer
      ),
      child: Stack(
        children: [
          // Subtle glow orb
          Positioned(
            top: 0,
            left: -100,
            child: IgnorePointer(
              child: Container(
                width: 500,
                height: 500,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [cs.accentWithOpacity(0.1), Colors.transparent],
                  ),
                ),
              ),
            ),
          ),
          // Main content: two-column on desktop, single-column on mobile
          mobile
              ? _MobileLayout(
                  cs: cs,
                  heroAnimController: heroAnimController,
                  context: context,
                  onGetInTouch: onGetInTouch,
                )
              : _DesktopLayout(
                  cs: cs,
                  heroAnimController: heroAnimController,
                  context: context,
                  onGetInTouch: onGetInTouch,
                ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Desktop: Row — text left, image right
// ─────────────────────────────────────────────────────────────────────────────

class _DesktopLayout extends StatelessWidget {
  final AppColors cs;
  final AnimationController heroAnimController;
  final BuildContext context;
  final VoidCallback onGetInTouch;

  const _DesktopLayout({
    required this.cs,
    required this.heroAnimController,
    required this.context,
    required this.onGetInTouch,
  });

  @override
  Widget build(_) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // ── Left: text content
        Expanded(
          flex: 6,
          child: _HeroText(
            cs: cs,
            controller: heroAnimController,
            context: context,
            onGetInTouch: onGetInTouch,
          ),
        ),
        const SizedBox(width: 60),
        // ── Right: profile image
        Expanded(
          flex: 4,
          child: _AnimatedFade(
            controller: heroAnimController,
            interval: 0.3,
            child: _ProfileImage(cs: cs),
          ),
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Mobile: single column — text then image
// ─────────────────────────────────────────────────────────────────────────────

class _MobileLayout extends StatelessWidget {
  final AppColors cs;
  final AnimationController heroAnimController;
  final BuildContext context;
  final VoidCallback onGetInTouch;

  const _MobileLayout({
    required this.cs,
    required this.heroAnimController,
    required this.context,
    required this.onGetInTouch,
  });

  @override
  Widget build(_) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _HeroText(
          cs: cs,
          controller: heroAnimController,
          context: context,
          onGetInTouch: onGetInTouch,
        ),
        const SizedBox(height: 40),
        _AnimatedFade(
          controller: heroAnimController,
          interval: 0.6,
          child: _ProfileImage(cs: cs),
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Shared hero text block
// ─────────────────────────────────────────────────────────────────────────────

class _HeroText extends StatelessWidget {
  final AppColors cs;
  final AnimationController controller;
  final BuildContext context;
  final VoidCallback onGetInTouch;

  const _HeroText({
    required this.cs,
    required this.controller,
    required this.context,
    required this.onGetInTouch,
  });

  @override
  Widget build(_) {
    final mobile = AppResponsive.isMobile(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _AnimatedFade(
          controller: controller,
          interval: 0.0,
          child: _StatusBadge(cs: cs),
        ),
        SizedBox(height: mobile ? 20 : 28),
        _AnimatedFade(
          controller: controller,
          interval: 0.15,
          child: _HeroHeading(cs: cs, context: context),
        ),
        SizedBox(height: mobile ? 16 : 24),
        _AnimatedFade(
          controller: controller,
          interval: 0.35,
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 560),
            child: Text(
              "I engineer high-performance, user-centric mobile applications "
              "using Flutter. Passionate about scalable architecture, exceptional code quality, and delivering seamless cross-platform experiences.",
              style: TextStyle(
                color: cs.textSecondary,
                fontSize: AppResponsive.bodySize(context) + 1,
                height: 1.7,
              ),
            ),
          ),
        ),
        SizedBox(height: mobile ? 32 : 48),
        _AnimatedFade(
          controller: controller,
          interval: 0.5,
          child: Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              _PrimaryButton(
                cs: cs,
                label: 'View My Work',
                onPressed: onGetInTouch,
              ),
              _OutlineButton(
                cs: cs,
                label: 'Download CV',
                icon: Icons.file_download_outlined,
                onPressed: downloadCv,
              ),
            ],
          ),
        ),
        SizedBox(height: mobile ? 48 : 60),
        _AnimatedFade(
          controller: controller,
          interval: 0.65,
          child: _HeroStats(cs: cs),
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Profile image card (moved from About)
// ─────────────────────────────────────────────────────────────────────────────

class _ProfileImage extends StatelessWidget {
  final AppColors cs;
  const _ProfileImage({required this.cs});

  @override
  Widget build(BuildContext context) {
    final mobile = AppResponsive.isMobile(context);
    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: mobile ? 280 : 360),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(24),
          child: Stack(
            children: [
              Image.asset(
                Assets.imagesMyImage,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              // Gradient name tag at the bottom
              // Positioned(
              //   bottom: 0,
              //   left: 0,
              //   right: 0,
              //   child: Container(
              //     padding: const EdgeInsets.all(20),
              //     decoration: BoxDecoration(
              //       gradient: LinearGradient(
              //         begin: Alignment.bottomCenter,
              //         end: Alignment.topCenter,
              //         colors: [
              //           Colors.black.withValues(alpha: 0.8),
              //           Colors.transparent,
              //         ],
              //       ),
              //     ),
              //     child: Column(
              //       crossAxisAlignment: CrossAxisAlignment.start,
              //       children: [
              //         const Text(
              //           'Maher Adel',
              //           style: TextStyle(
              //             color: Colors.white,
              //             fontSize: 18,
              //             fontWeight: FontWeight.w700,
              //           ),
              //         ),
              //         const SizedBox(height: 2),
              //         Text(
              //           'Flutter Developer',
              //           style: TextStyle(
              //             color: cs.accentLight,
              //             fontSize: 13,
              //             fontWeight: FontWeight.w500,
              //           ),
              //         ),
              //       ],
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Animation helper
// ─────────────────────────────────────────────────────────────────────────────

class _AnimatedFade extends StatelessWidget {
  final AnimationController controller;
  final double interval;
  final Widget child;

  const _AnimatedFade({
    required this.controller,
    required this.interval,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: CurvedAnimation(
        parent: controller,
        curve: Interval(interval, 1.0, curve: Curves.easeOut),
      ),
      child: SlideTransition(
        position: Tween<Offset>(begin: const Offset(0, 0.14), end: Offset.zero)
            .animate(
              CurvedAnimation(
                parent: controller,
                curve: Interval(interval, 1.0, curve: Curves.easeOut),
              ),
            ),
        child: child,
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Sub-widgets
// ─────────────────────────────────────────────────────────────────────────────

class _StatusBadge extends StatelessWidget {
  final AppColors cs;
  const _StatusBadge({required this.cs});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(color: cs.success, shape: BoxShape.circle),
        ),
        const SizedBox(width: 8),
        Text(
          'Available for new projects',
          style: TextStyle(
            color: cs.textSecondary,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

class _HeroHeading extends StatelessWidget {
  final AppColors cs;
  final BuildContext context;
  const _HeroHeading({required this.cs, required this.context});

  @override
  Widget build(_) {
    final fontSize = AppResponsive.heroFontSize(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: "Hi, I'm ",
                style: TextStyle(
                  color: cs.textPrimary,
                  fontSize: fontSize,
                  fontWeight: FontWeight.w800,
                  letterSpacing: -2,
                  height: .7,
                ),
              ),
              WidgetSpan(
                child: ShaderMask(
                  shaderCallback: (bounds) => LinearGradient(
                    colors: [cs.accent, cs.accentLight],
                  ).createShader(bounds),
                  child: Text(
                    'Maher Adel',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: fontSize,
                      fontWeight: FontWeight.w800,
                      letterSpacing: -2,
                      height: .8,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 16,),
        Text(
          'Flutter Developer',
          style: TextStyle(
            color: cs.textMuted,
            fontSize: fontSize * 0.78,
            fontWeight: FontWeight.w700,
            letterSpacing: -1.5,
            height: 1.1,
          ),
        ),
      ],
    );
  }
}

class _PrimaryButton extends StatefulWidget {
  final AppColors cs;
  final String label;
  final VoidCallback onPressed;

  const _PrimaryButton({
    required this.cs,
    required this.label,
    required this.onPressed,
  });

  @override
  State<_PrimaryButton> createState() => _PrimaryButtonState();
}

class _PrimaryButtonState extends State<_PrimaryButton> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final cs = widget.cs;
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onPressed,
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
          child: Text(
            widget.label,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 15,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}

class _OutlineButton extends StatefulWidget {
  final AppColors cs;
  final String label;
  final IconData icon;
  final VoidCallback onPressed;

  const _OutlineButton({
    required this.cs,
    required this.label,
    required this.icon,
    required this.onPressed,
  });

  @override
  State<_OutlineButton> createState() => _OutlineButtonState();
}

class _OutlineButtonState extends State<_OutlineButton> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final cs = widget.cs;
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onPressed,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 15),
          decoration: BoxDecoration(
            color: _hovered ? cs.surfaceElevated : Colors.transparent,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: _hovered ? cs.accent : cs.border,
              width: 1.5,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                widget.icon,
                size: 16,
                color: _hovered ? cs.accentLight : cs.textSecondary,
              ),
              const SizedBox(width: 8),
              Text(
                widget.label,
                style: TextStyle(
                  color: _hovered ? cs.textPrimary : cs.textSecondary,
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _HeroStats extends StatelessWidget {
  final AppColors cs;
  const _HeroStats({required this.cs});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 0,
      runSpacing: 16,
      children: [
        _StatItem(cs: cs, value: '2+', label: 'Years'),
        _StatDivider(cs: cs),
        _StatItem(cs: cs, value: '5+', label: 'Apps'),
        _StatDivider(cs: cs),
        _StatItem(cs: cs, value: '2', label: 'Companies'),
      ],
    );
  }
}

class _StatItem extends StatelessWidget {
  final AppColors cs;
  final String value;
  final String label;
  const _StatItem({required this.cs, required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ShaderMask(
          shaderCallback: (bounds) => LinearGradient(
            colors: [cs.accent, cs.accentLight],
          ).createShader(bounds),
          child: Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 30,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
        const SizedBox(height: 2),
        Text(
          label,
          style: TextStyle(
            color: cs.textMuted,
            fontSize: 13,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

class _StatDivider extends StatelessWidget {
  final AppColors cs;
  const _StatDivider({required this.cs});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 36,
      width: 1,
      margin: const EdgeInsets.symmetric(horizontal: 28),
      color: cs.border,
    );
  }
}
