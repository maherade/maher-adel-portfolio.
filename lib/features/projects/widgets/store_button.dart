import 'package:flutter/material.dart';
import 'package:unping_task/core/constants/app_colors.dart';

class StoreButton extends StatefulWidget {
  final String icon;
  final String label;
  final VoidCallback onTap;

  const StoreButton({
    super.key,
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  State<StoreButton> createState() => _StoreButtonState();
}

class _StoreButtonState extends State<StoreButton> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final cs = AppColors.of(context);
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          decoration: BoxDecoration(
            color: _hovered ? cs.accentWithOpacity(0.08) : cs.surfaceElevated,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: _hovered ? cs.accentWithOpacity(0.4) : cs.border,
            ),
          ),
          child: Row(
            children: [
              Image.asset(
                widget.icon,
                color: _hovered ? cs.accentLight : cs.textSecondary,
                height: 24,
                width: 24,
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Text(
                  widget.label,
                  style: TextStyle(
                    color: _hovered ? cs.textPrimary : cs.textSecondary,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Icon(
                Icons.arrow_forward_ios_rounded,
                color: _hovered ? cs.accentLight : cs.textMuted,
                size: 13,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
