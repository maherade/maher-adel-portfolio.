import 'package:flutter/material.dart';
import 'package:unping_task/core/constants/app_colors.dart';
import 'package:unping_task/core/providers/theme_provider.dart';
import 'package:unping_task/core/utils/responsive.dart';

class NavBar extends StatefulWidget {
  final int selectedIndex;
  final void Function(double offset, int index) onNavTap;
  final ValueNotifier<double> scrollOffset;

  static const navItems = [
    NavItem(label: 'About', offset: 0, index: 0),
    NavItem(label: 'Skills', offset: 1100, index: 1),
    NavItem(label: 'Experience', offset: 2000, index: 2),
    NavItem(label: 'Projects', offset: 3100, index: 3),
    NavItem(label: 'Contact', offset: 4200, index: 4),
  ];

  const NavBar({
    super.key,
    required this.selectedIndex,
    required this.onNavTap,
    required this.scrollOffset,
  });

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  bool _scrolled = false;

  @override
  void initState() {
    super.initState();
    widget.scrollOffset.addListener(_onScroll);
  }

  void _onScroll() {
    final isScrolled = widget.scrollOffset.value > 20;
    if (isScrolled != _scrolled) {
      setState(() => _scrolled = isScrolled);
    }
  }

  @override
  void dispose() {
    widget.scrollOffset.removeListener(_onScroll);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cs = AppColors.of(context);
    final mobile = AppResponsive.isMobile(context);

    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        padding: EdgeInsets.symmetric(
          horizontal: AppResponsive.hPad(context),
          vertical: 16,
        ),
        decoration: BoxDecoration(
          color: cs.background.withValues(alpha: _scrolled ? 0.96 : 0.85),
          border: Border(
            bottom: BorderSide(
              color: _scrolled ? cs.border : cs.border.withValues(alpha: 0.4),
              width: _scrolled ? 1 : 0.5,
            ),
          ),
          boxShadow: _scrolled
              ? [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.12),
                    blurRadius: 16,
                    offset: const Offset(0, 4),
                  ),
                ]
              : [],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _Logo(cs: cs),
            if (mobile)
              Row(
                children: [
                  _ThemeToggle(cs: cs),
                  const SizedBox(width: 4),
                  _HamburgerButton(cs: cs),
                ],
              )
            else
              Row(
                children: [
                  ...NavBar.navItems.map(
                    (item) => _NavButton(
                      cs: cs,
                      label: item.label,
                      isSelected: widget.selectedIndex == item.index,
                      delay: item.index * 80,
                      onTap: () => widget.onNavTap(item.offset, item.index),
                    ),
                  ),
                  const SizedBox(width: 12),
                  _ThemeToggle(cs: cs),
                ],
              ),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Data model
// ─────────────────────────────────────────────────────────────────────────────

class NavItem {
  final String label;
  final double offset;
  final int index;
  const NavItem({
    required this.label,
    required this.offset,
    required this.index,
  });
}

// ─────────────────────────────────────────────────────────────────────────────
// Internal widgets
// ─────────────────────────────────────────────────────────────────────────────

class _Logo extends StatelessWidget {
  final AppColors cs;
  const _Logo({required this.cs});

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: const Duration(milliseconds: 700),
      builder: (_, value, child) => Opacity(
        opacity: value,
        child: Transform.translate(
          offset: Offset(-16 * (1 - value), 0),
          child: child,
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [cs.accent, cs.accentLight],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: cs.accent.withValues(alpha: 0.3),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            alignment: Alignment.center,
            child: const Text(
              'MA',
              style: TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.w800,
                letterSpacing: 0.5,
              ),
            ),
          ),
          if (!AppResponsive.isMobile(context)) ...[
            const SizedBox(width: 10),
            Text(
              'Maher Adel',
              style: TextStyle(
                color: cs.textPrimary,
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _ThemeToggle extends StatelessWidget {
  final AppColors cs;
  const _ThemeToggle({required this.cs});

  @override
  Widget build(BuildContext context) {
    final isDark = ThemeProvider.of(context).isDark;
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: ThemeProvider.of(context).toggle,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          width: 44,
          height: 26,
          padding: const EdgeInsets.all(3),
          decoration: BoxDecoration(
            color: isDark ? cs.accent : cs.border,
            borderRadius: BorderRadius.circular(13),
          ),
          child: AnimatedAlign(
            duration: const Duration(milliseconds: 250),
            curve: Curves.easeInOut,
            alignment: isDark ? Alignment.centerRight : Alignment.centerLeft,
            child: Container(
              width: 20,
              height: 20,
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: Icon(
                isDark ? Icons.nightlight_round : Icons.wb_sunny_rounded,
                size: 13,
                color: isDark
                    ? const Color(0xFF7C3AED)
                    : const Color(0xFFF59E0B),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _HamburgerButton extends StatelessWidget {
  final AppColors cs;

  const _HamburgerButton({required this.cs});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.menu_rounded, color: cs.textPrimary, size: 24),
      onPressed: () {
        Scaffold.of(context).openEndDrawer();
      },
    );
  }
}

class _NavButton extends StatefulWidget {
  final AppColors cs;
  final String label;
  final bool isSelected;
  final int delay;
  final VoidCallback onTap;

  const _NavButton({
    required this.cs,
    required this.label,
    required this.isSelected,
    required this.delay,
    required this.onTap,
  });

  @override
  State<_NavButton> createState() => _NavButtonState();
}

class _NavButtonState extends State<_NavButton> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final cs = widget.cs;
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: Duration(milliseconds: 600 + widget.delay),
      builder: (_, value, child) => Opacity(
        opacity: value,
        child: Transform.translate(
          offset: Offset(0, -8 * (1 - value)),
          child: child,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 2),
        child: MouseRegion(
          onEnter: (_) => setState(() => _hovered = true),
          onExit: (_) => setState(() => _hovered = false),
          child: GestureDetector(
            onTap: widget.onTap,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 180),
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
              decoration: BoxDecoration(
                color: widget.isSelected
                    ? cs.accentWithOpacity(0.12)
                    : _hovered
                    ? cs.surfaceElevated
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                widget.label,
                style: TextStyle(
                  color: widget.isSelected
                      ? cs.accentLight
                      : _hovered
                      ? cs.textPrimary
                      : cs.textSecondary,
                  fontSize: 14,
                  fontWeight: widget.isSelected
                      ? FontWeight.w600
                      : FontWeight.w400,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
