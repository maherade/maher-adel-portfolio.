import 'package:flutter/material.dart';
import 'package:unping_task/core/constants/app_colors.dart';
import 'package:unping_task/features/navigation/widgets/nav_bar.dart';

class NavDrawer extends StatelessWidget {
  final int selectedIndex;
  final void Function(double, int) onNavTap;

  const NavDrawer({
    super.key,
    required this.selectedIndex,
    required this.onNavTap,
  });

  @override
  Widget build(BuildContext context) {
    final cs = AppColors.of(context);

    return Drawer(
      backgroundColor: cs.surface,
      elevation: 16,
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 24, top: 32, bottom: 24),
              child: Row(
                children: [
                  Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      color: cs.accent,
                      borderRadius: BorderRadius.circular(7),
                    ),
                    alignment: Alignment.center,
                    child: const Text(
                      'MA',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 0.3,
                      ),
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: Icon(Icons.close_rounded, color: cs.textSecondary),
                  ),
                  const SizedBox(width: 12),
                ],
              ),
            ),
            Divider(color: cs.border, height: 1),
            const SizedBox(height: 16),
            ...NavBar.navItems.map(
              (item) => ListTile(
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 4,
                ),
                title: Text(
                  item.label,
                  style: TextStyle(
                    color: selectedIndex == item.index
                        ? cs.accent
                        : cs.textPrimary,
                    fontWeight: selectedIndex == item.index
                        ? FontWeight.w700
                        : FontWeight.w500,
                    fontSize: 16,
                  ),
                ),
                // trailing: selectedIndex == item.index
                //     ? Icon(Icons.circle, size: 8, color: cs.accent)
                //     : null,
                onTap: () => onNavTap(item.offset, item.index),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
