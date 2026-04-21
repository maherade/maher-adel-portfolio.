import 'package:flutter/material.dart';
import 'package:unping_task/core/constants/app_colors.dart';
import 'package:unping_task/core/utils/responsive.dart';
import 'package:unping_task/core/widgets/scroll_reveal.dart';
import 'package:unping_task/core/widgets/section_header.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    final cs = AppColors.of(context);

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: AppResponsive.hPad(context),
        vertical: AppResponsive.vPad(context),
      ),
      child: ScrollReveal(child: _AboutContent(cs: cs)),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────

class _AboutContent extends StatelessWidget {
  final AppColors cs;
  const _AboutContent({required this.cs});

  @override
  Widget build(BuildContext context) {
    final mobile = AppResponsive.isMobile(context);

    return mobile
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SectionHeader(
                tag: 'ABOUT ME',
                title: 'Turning ideas\ninto realities',
                subtitle:
                    'Crafting high-quality cross-platform apps since 2023.',
              ),
              const SizedBox(height: 28),
              _AboutBody(cs: cs),
            ],
          )
        : Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Left: header
              Expanded(
                flex: 4,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SectionHeader(
                      tag: 'ABOUT ME',
                      title: 'Turning ideas\ninto realities',
                      subtitle:
                          'Crafting high-quality cross-platform apps since 2022.',
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 70),
              // Right: paragraphs + chips
              Expanded(flex: 6, child: _AboutBody(cs: cs)),
            ],
          );
  }
}

class _AboutBody extends StatelessWidget {
  final AppColors cs;
  const _AboutBody({required this.cs});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Hello! I'm Maher, a Mobile Developer specializing in Flutter. I focus on "
          "building high-quality cross-platform applications that combine strong "
          "performance with intuitive and engaging user experiences.",
          style: TextStyle(
            color: cs.textSecondary,
            fontSize: AppResponsive.bodySize(context),
            height: 1.8,
          ),
        ),
        const SizedBox(height: 14),
        Text(
          "I place strong emphasis on clean architecture, maintainable code, and "
          "scalable solutions. My work includes integrating modern technologies, "
          "developing real-time features, and building complex platforms such as "
          "multi-vendor systems while maintaining high standards of quality and performance.",
          style: TextStyle(
            color: cs.textSecondary,
            fontSize: AppResponsive.bodySize(context),
            height: 1.8,
          ),
        ),
        const SizedBox(height: 28),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: [
            _InfoChip(cs: cs, icon: Icons.location_on_outlined, label: 'Egypt'),
            _InfoChip(cs: cs, icon: Icons.work_outline, label: 'Open to work'),
            _InfoChip(
              cs: cs,
              icon: Icons.phone_android,
              label: 'Mobile focused',
            ),
            _InfoChip(cs: cs, icon: Icons.language, label: 'Arabic & English'),
          ],
        ),
      ],
    );
  }
}

class _InfoChip extends StatelessWidget {
  final AppColors cs;
  final IconData icon;
  final String label;

  const _InfoChip({required this.cs, required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 8),
      decoration: BoxDecoration(
        color: cs.surfaceElevated,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: cs.border),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: cs.accentLight),
          const SizedBox(width: 7),
          Text(
            label,
            style: TextStyle(
              color: cs.textSecondary,
              fontSize: 13,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
