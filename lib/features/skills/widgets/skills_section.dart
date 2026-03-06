import 'package:flutter/material.dart';
import 'package:unping_task/core/constants/app_colors.dart';
import 'package:unping_task/core/utils/responsive.dart';
import 'package:unping_task/core/widgets/scroll_reveal.dart';
import 'package:unping_task/core/widgets/section_header.dart';
import 'package:unping_task/features/skills/widgets/skill_chip.dart';

class SkillsSection extends StatelessWidget {
  static const _categories = [
    _SkillCategory(
      label: 'Mobile',
      icon: Icons.phone_android,
      skills: ['Flutter', 'Dart', 'Mobile Application Development'],
    ),
    _SkillCategory(
      label: 'Architecture',
      icon: Icons.architecture,
      skills: ['Bloc & Cubit', 'MVVM', 'Clean Architecture'],
    ),
    _SkillCategory(
      label: 'Backend & APIs',
      icon: Icons.cloud_outlined,
      skills: [
        'Firebase',
        'REST APIs',
        'Dio',
        'Pusher',
        'FCM Notifications',
        'Postman',
      ],
    ),
    _SkillCategory(
      label: 'DevOps & Tools',
      icon: Icons.build_outlined,
      skills: ['Git & GitHub', 'CI/CD', 'Figma', 'Google Maps'],
    ),
    _SkillCategory(
      label: 'Domain',
      icon: Icons.category_outlined,
      skills: ['E-commerce', 'Workflow Management', 'Product Development'],
    ),
    _SkillCategory(
      label: 'Soft Skills',
      icon: Icons.people_outline,
      skills: [
        'Collaboration',
        'Communication',
        'Problem-solving',
        'Quality Assurance',
        'Adaptability',
      ],
    ),
  ];

  const SkillsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final cs = AppColors.of(context);
    final mobile = AppResponsive.isMobile(context);
    final cardWidth = AppResponsive.value<double>(
      context,
      mobile: double.infinity,
      tablet: 280,
      desktop: 280,
    );

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: AppResponsive.hPad(context),
        vertical: AppResponsive.vPad(context),
      ),
      color: cs.surface,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const ScrollReveal(
            child: SectionHeader(
              tag: 'SKILLS',
              title: 'What I work with',
              subtitle: 'Technologies and tools I use to bring ideas to life.',
            ),
          ),
          const SizedBox(height: 50),
          mobile
              ? Column(
                  children: List.generate(
                    _categories.length,
                    (i) => ScrollReveal(
                      delay: Duration(milliseconds: i * 80),
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: _CategoryCard(
                          cs: cs,
                          category: _categories[i],
                          width: cardWidth,
                        ),
                      ),
                    ),
                  ),
                )
              : Wrap(
                  spacing: 20,
                  runSpacing: 20,
                  children: List.generate(
                    _categories.length,
                    (i) => TweenAnimationBuilder<double>(
                      tween: Tween(begin: 0.0, end: 1.0),
                      duration: Duration(milliseconds: 400 + (i * 80)),
                      curve: Curves.easeOut,
                      builder: (_, value, child) => Opacity(
                        opacity: value,
                        child: Transform.translate(
                          offset: Offset(0, 16 * (1 - value)),
                          child: child,
                        ),
                      ),
                      child: _CategoryCard(
                        cs: cs,
                        category: _categories[i],
                        width: cardWidth,
                      ),
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────

class _SkillCategory {
  final String label;
  final IconData icon;
  final List<String> skills;

  const _SkillCategory({
    required this.label,
    required this.icon,
    required this.skills,
  });
}

class _CategoryCard extends StatelessWidget {
  final AppColors cs;
  final _SkillCategory category;
  final double width;

  const _CategoryCard({
    required this.cs,
    required this.category,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: cs.surfaceElevated,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: cs.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: cs.accentWithOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(category.icon, size: 15, color: cs.accentLight),
              ),
              const SizedBox(width: 10),
              Text(
                category.label,
                style: TextStyle(
                  color: cs.textPrimary,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: category.skills.map((s) => SkillChip(skill: s)).toList(),
          ),
        ],
      ),
    );
  }
}
