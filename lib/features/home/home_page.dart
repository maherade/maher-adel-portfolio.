import 'package:flutter/material.dart';
import 'package:unping_task/core/providers/scroll_offset_provider.dart';
import 'package:unping_task/features/about/widgets/about_section.dart';
import 'package:unping_task/features/contact/widgets/contact_section.dart';
import 'package:unping_task/features/experience/widgets/experience_section.dart';
import 'package:unping_task/features/hero/widgets/hero_section.dart';
import 'package:unping_task/features/navigation/widgets/nav_bar.dart';
import 'package:unping_task/features/navigation/widgets/nav_drawer.dart';
import 'package:unping_task/features/projects/widgets/projects_section.dart';
import 'package:unping_task/features/skills/widgets/skills_section.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();
  final ValueNotifier<double> _scrollOffset = ValueNotifier(0);

  late AnimationController _heroAnimController;
  late AnimationController _fadeController;

  int _selectedIndex = 0;

  static const _sectionOffsets = <double>[0, 1100, 2000, 3100, 4200, 5000];

  @override
  void initState() {
    super.initState();

    _heroAnimController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..forward();

    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    )..forward();

    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    final scrollPos = _scrollController.offset;
    _scrollOffset.value = scrollPos;

    for (int i = 0; i < _sectionOffsets.length; i++) {
      final start = _sectionOffsets[i];
      final end = (i + 1 < _sectionOffsets.length)
          ? _sectionOffsets[i + 1]
          : double.infinity;

      if (scrollPos >= start && scrollPos < end) {
        if (_selectedIndex != i) {
          setState(() => _selectedIndex = i);
        }
        break;
      }
    }
  }

  void _scrollToSection(double offset) {
    _scrollController.animateTo(
      offset,
      duration: const Duration(milliseconds: 800),
      curve: Curves.easeInOut,
    );
  }

  void _onNavTap(double offset, int index) {
    setState(() => _selectedIndex = index);
    _scrollToSection(offset);
  }

  @override
  void dispose() {
    _heroAnimController.dispose();
    _fadeController.dispose();
    _scrollController.dispose();
    _scrollOffset.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScrollOffsetProvider(
      notifier: _scrollOffset,
      child: Scaffold(
        // ── Right-side drawer for mobile navigation ──────────────────────────
        endDrawer: NavDrawer(
          selectedIndex: _selectedIndex,
          onNavTap: (offset, index) {
            _onNavTap(offset, index);
            Navigator.pop(context); // close drawer
          },
        ),
        body: Stack(
          children: [
            SingleChildScrollView(
              controller: _scrollController,
              child: Column(
                children: [
                  HeroSection(
                    heroAnimController: _heroAnimController,
                    fadeController: _fadeController,
                    onGetInTouch: () => _scrollToSection(4000),
                  ),
                  const AboutSection(),
                  const SkillsSection(),
                  const ExperienceSection(),
                  const ProjectsSection(),
                  const ContactSection(),
                ],
              ),
            ),
            NavBar(
              selectedIndex: _selectedIndex,
              onNavTap: _onNavTap,
              scrollOffset: _scrollOffset,
            ),
          ],
        ),
      ),
    );
  }
}
