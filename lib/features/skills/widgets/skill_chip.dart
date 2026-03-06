import 'package:flutter/material.dart';
import 'package:unping_task/core/constants/app_colors.dart';

class SkillChip extends StatefulWidget {
  final String skill;

  const SkillChip({super.key, required this.skill});

  @override
  State<SkillChip> createState() => _SkillChipState();
}

class _SkillChipState extends State<SkillChip> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final cs = AppColors.of(context);
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 9),
        decoration: BoxDecoration(
          color: _hovered ? cs.accentWithOpacity(0.1) : cs.surface,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: _hovered ? cs.accentWithOpacity(0.5) : cs.border,
          ),
        ),
        child: Text(
          widget.skill,
          style: TextStyle(
            color: _hovered ? cs.accentLight : cs.textSecondary,
            fontSize: 13,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
