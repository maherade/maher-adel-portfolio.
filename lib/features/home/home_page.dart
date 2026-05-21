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
  final GlobalKey aboutSectionKey = GlobalKey();
  final GlobalKey skillsSectionKey = GlobalKey();
  final GlobalKey experienceSectionKey = GlobalKey();
  final GlobalKey projectsSectionKey = GlobalKey();
  final GlobalKey contactSectionKey = GlobalKey();

  late AnimationController _heroAnimController;
  late AnimationController _fadeController;
  late final List<GlobalKey> sectionKeys;

  int _selectedIndex = 0;

  static const double _navScrollPadding = 88;

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

    sectionKeys = [
      aboutSectionKey,
      skillsSectionKey,
      experienceSectionKey,
      projectsSectionKey,
      contactSectionKey,
    ];

    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    final scrollPos = _scrollController.offset;
    _scrollOffset.value = scrollPos;

    int activeIndex = _selectedIndex;
    final isAtBottom =
        _scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 2;

    if (isAtBottom) {
      activeIndex = sectionKeys.length - 1;
    } else {
      for (int i = 0; i < sectionKeys.length; i++) {
        final sectionContext = sectionKeys[i].currentContext;
        if (sectionContext == null) {
          continue;
        }

        final renderBox = sectionContext.findRenderObject() as RenderBox?;
        if (renderBox == null || !renderBox.attached) {
          continue;
        }

        final sectionTop = renderBox.localToGlobal(Offset.zero).dy;
        if (sectionTop <= _navScrollPadding + 24) {
          activeIndex = i;
        }
      }
    }

    if (_selectedIndex != activeIndex) {
      setState(() => _selectedIndex = activeIndex);
    }
  }

  void _scrollToSection(int index) {
    if (!_scrollController.hasClients ||
        index < 0 ||
        index >= sectionKeys.length) {
      return;
    }

    final sectionContext = sectionKeys[index].currentContext;
    if (sectionContext == null) {
      return;
    }

    final renderBox = sectionContext.findRenderObject() as RenderBox?;
    if (renderBox == null || !renderBox.attached) {
      return;
    }

    final targetOffset =
        _scrollController.offset +
        renderBox.localToGlobal(Offset.zero).dy -
        _navScrollPadding;
    final clampedOffset = targetOffset.clamp(
      0.0,
      _scrollController.position.maxScrollExtent,
    );

    _scrollController.animateTo(
      clampedOffset,
      duration: const Duration(milliseconds: 800),
      curve: Curves.easeInOut,
    );
  }

  void _onNavTap(int index) {
    setState(() => _selectedIndex = index);
    _scrollToSection(index);
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
          onNavTap: (index) {
            _onNavTap(index);
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
                    onGetInTouch: () => _scrollToSection(4),
                  ),
                  KeyedSubtree(
                    key: aboutSectionKey,
                    child: const AboutSection(),
                  ),
                  KeyedSubtree(
                    key: skillsSectionKey,
                    child: const SkillsSection(),
                  ),
                  KeyedSubtree(
                    key: experienceSectionKey,
                    child: const ExperienceSection(),
                  ),
                  KeyedSubtree(
                    key: projectsSectionKey,
                    child: const ProjectsSection(),
                  ),
                  KeyedSubtree(
                    key: contactSectionKey,
                    child: const ContactSection(),
                  ),
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
