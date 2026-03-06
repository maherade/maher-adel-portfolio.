import 'package:flutter/material.dart';
import 'package:unping_task/core/constants/app_colors.dart';
import 'package:unping_task/core/models/experience_model.dart';
import 'package:unping_task/core/utils/responsive.dart';
import 'package:unping_task/core/widgets/scroll_reveal.dart';
import 'package:unping_task/core/widgets/section_header.dart';

class ExperienceSection extends StatelessWidget {
  static const _experiences = [
    ExperienceModel(
      title: 'Flutter Developer',
      company: 'العلا للأعمال المحدودة (ABC Company)',
      period: 'Feb 2025 — Present',
      description:
          "Developed and maintained flagship e-commerce mobile applications for iOS and Android, including a multi-vendor platform serving a large number of users.\n"
          "Designed and enhanced a vendor dashboard within the mobile application, enabling vendors to efficiently manage products, inventory, and orders.\n"
          "Applied Clean Architecture and Clean Code principles to ensure the applications remain scalable, maintainable, and easy to extend.\n"
          "Contributed to improving the platform’s business workflow by integrating wholesale and half-wholesale purchasing models into a unified application experience, simplifying the ordering process for different customer segments.",
    ),
    ExperienceModel(
      title: 'Flutter Developer',
      company: 'TheDar.AI',
      period: 'Jan 2024 — Nov 2024',
      description:
          "Contributed to the development of Saytara, a delegate management solution designed for major supermarket chains, focusing on improving field operations, task management, and communication between delegates and management. Additionally, delivered Ufeed, a comprehensive web-based HR management system built using FlutterFlow and Firebase, enabling efficient management of employee data, internal processes, and administrative workflows through a modern and user-friendly interface.",
    ),
  ];

  const ExperienceSection({super.key});

  @override
  Widget build(BuildContext context) {
    final cs = AppColors.of(context);
    final mobile = AppResponsive.isMobile(context);

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
              tag: 'EXPERIENCE',
              title: "Where I've worked",
              subtitle: 'My professional journey in mobile development.',
            ),
          ),
          const SizedBox(height: 50),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (!mobile) _TimelineDots(cs: cs, count: _experiences.length),
              if (!mobile) const SizedBox(width: 28),
              Expanded(
                child: Column(
                  children: List.generate(
                    _experiences.length,
                    (index) => TweenAnimationBuilder<double>(
                      tween: Tween(begin: 0.0, end: 1.0),
                      duration: Duration(milliseconds: 450 + (index * 130)),
                      curve: Curves.easeOut,
                      builder: (_, value, child) => Opacity(
                        opacity: value,
                        child: Transform.translate(
                          offset: Offset(16 * (1 - value), 0),
                          child: child,
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(
                          bottom: index < _experiences.length - 1 ? 20 : 0,
                        ),
                        child: _ExperienceCard(
                          cs: cs,
                          experience: _experiences[index],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────

class _TimelineDots extends StatelessWidget {
  final AppColors cs;
  final int count;

  const _TimelineDots({required this.cs, required this.count});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(count, (i) {
        return Column(
          children: [
            Container(
              width: 12,
              height: 12,
              margin: const EdgeInsets.only(top: 20),
              decoration: BoxDecoration(
                color: cs.accent,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(color: cs.accentWithOpacity(0.4), blurRadius: 8),
                ],
              ),
            ),
            if (i < count)
              Container(
                width: 2,
                height: 108,
                margin: const EdgeInsets.symmetric(vertical: 4),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      cs.accentWithOpacity(0.5),
                      cs.accentWithOpacity(0.08),
                    ],
                  ),
                ),
              ),
          ],
        );
      }),
    );
  }
}

class _ExperienceCard extends StatelessWidget {
  final AppColors cs;
  final ExperienceModel experience;

  const _ExperienceCard({required this.cs, required this.experience});

  @override
  Widget build(BuildContext context) {
    final mobile = AppResponsive.isMobile(context);
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: cs.surfaceElevated,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: cs.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          mobile
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _CardTop(cs: cs, experience: experience),
                    const SizedBox(height: 8),
                    _PeriodBadge(cs: cs, period: experience.period),
                  ],
                )
              : Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: _CardTop(cs: cs, experience: experience),
                    ),
                    const SizedBox(width: 16),
                    _PeriodBadge(cs: cs, period: experience.period),
                  ],
                ),
          const SizedBox(height: 12),
          Text(
            experience.description,
            style: TextStyle(
              color: cs.textSecondary,
              fontSize: AppResponsive.bodySize(context) - 1,
              height: 1.75,
            ),
          ),
        ],
      ),
    );
  }
}

class _CardTop extends StatelessWidget {
  final AppColors cs;
  final ExperienceModel experience;

  const _CardTop({required this.cs, required this.experience});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          experience.title,
          style: TextStyle(
            color: cs.textPrimary,
            fontSize: 17,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 3),
        Text(
          experience.company,
          style: TextStyle(
            color: cs.accentLight,
            fontSize: 13,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

class _PeriodBadge extends StatelessWidget {
  final AppColors cs;
  final String period;

  const _PeriodBadge({required this.cs, required this.period});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: cs.accentWithOpacity(0.08),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: cs.accentWithOpacity(0.2)),
      ),
      child: Text(
        period,
        style: TextStyle(
          color: cs.textSecondary,
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
