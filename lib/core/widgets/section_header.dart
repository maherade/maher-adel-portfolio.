import 'package:flutter/material.dart';
import 'package:unping_task/core/constants/app_colors.dart';
import 'package:unping_task/core/utils/responsive.dart';

class SectionHeader extends StatelessWidget {
  final String tag;
  final String title;
  final String? subtitle;

  const SectionHeader({
    super.key,
    required this.tag,
    required this.title,
    this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    final cs = AppColors.of(context);
    final titleSize = AppResponsive.sectionTitleSize(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Accent tag badge
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
          decoration: BoxDecoration(
            color: cs.accentWithOpacity(0.1),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: cs.accentWithOpacity(0.3)),
          ),
          child: Text(
            tag,
            style: TextStyle(
              color: cs.accentLight,
              fontSize: 11,
              fontWeight: FontWeight.w700,
              letterSpacing: 1.4,
            ),
          ),
        ),
        const SizedBox(height: 16),
        Text(
          title,
          style: TextStyle(
            color: cs.textPrimary,
            fontSize: titleSize,
            fontWeight: FontWeight.w800,
            letterSpacing: -1.2,
            height: 1.1,
          ),
        ),
        if (subtitle != null) ...[
          const SizedBox(height: 12),
          Text(
            subtitle!,
            style: TextStyle(
              color: cs.textSecondary,
              fontSize: AppResponsive.bodySize(context),
              height: 1.7,
            ),
          ),
        ],
      ],
    );
  }
}
