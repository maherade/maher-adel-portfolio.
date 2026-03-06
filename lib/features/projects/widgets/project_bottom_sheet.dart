import 'package:flutter/material.dart';
import 'package:unping_task/core/constants/app_colors.dart';
import 'package:unping_task/core/models/project_model.dart';
import 'package:unping_task/features/projects/widgets/store_button.dart';
import 'package:unping_task/generated/assets.dart';
import 'package:url_launcher/url_launcher.dart';

class ProjectDialog extends StatelessWidget {
  final ProjectModel project;

  const ProjectDialog({super.key, required this.project});

  @override
  Widget build(BuildContext context) {
    final cs = AppColors.of(context);

    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 560),
        child: Container(
          decoration: BoxDecoration(
            color: cs.surface,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: cs.border),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.4),
                blurRadius: 40,
                offset: const Offset(0, 20),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ── Header ──────────────────────────────────────────────────
              _DialogHeader(cs: cs, project: project),
              // ── Scrollable body ─────────────────────────────────────────
              Flexible(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(28, 0, 28, 28),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Description
                      Text(
                        project.description,
                        style: TextStyle(
                          color: cs.textSecondary,
                          fontSize: 15,
                          height: 1.75,
                        ),
                      ),
                      const SizedBox(height: 24),
                      // Tech tags
                      Text(
                        'Technologies',
                        style: TextStyle(
                          color: cs.textPrimary,
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.5,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: project.tech.map((t) {
                          return Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 5,
                            ),
                            decoration: BoxDecoration(
                              color: cs.accentWithOpacity(0.08),
                              borderRadius: BorderRadius.circular(6),
                              border: Border.all(
                                color: cs.accentWithOpacity(0.2),
                              ),
                            ),
                            child: Text(
                              t,
                              style: TextStyle(
                                color: cs.accentLight,
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                      // Store buttons
                      if (project.playStoreUrl != null ||
                          project.appStoreUrl != null) ...[
                        const SizedBox(height: 28),
                        Text(
                          'Available on',
                          style: TextStyle(
                            color: cs.textPrimary,
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.5,
                          ),
                        ),
                        const SizedBox(height: 12),
                      ],
                      if (project.playStoreUrl != null)
                        StoreButton(
                          icon: Assets.imagesGooglePlay,
                          label: 'Google Play Store',
                          onTap: () =>
                              launchUrl(Uri.parse(project.playStoreUrl!)),
                        ),
                      if (project.playStoreUrl != null &&
                          project.appStoreUrl != null)
                        const SizedBox(height: 10),
                      if (project.appStoreUrl != null)
                        StoreButton(
                          icon: Assets.imagesAppStore,
                          label: 'Apple App Store',
                          onTap: () =>
                              launchUrl(Uri.parse(project.appStoreUrl!)),
                        ),
                      // Web link
                      if (project.webUrl != null) ...[
                        const SizedBox(height: 28),
                        Text(
                          'Visit',
                          style: TextStyle(
                            color: cs.textPrimary,
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.5,
                          ),
                        ),
                        const SizedBox(height: 12),
                        _WebButton(cs: cs, url: project.webUrl!),
                      ],
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Header
// ─────────────────────────────────────────────────────────────────────────────

class _DialogHeader extends StatelessWidget {
  final AppColors cs;
  final ProjectModel project;

  const _DialogHeader({required this.cs, required this.project});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(28, 24, 20, 20),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: cs.border)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Category badge
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 9,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: cs.accentWithOpacity(0.1),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Text(
                    project.category.toUpperCase(),
                    style: TextStyle(
                      color: cs.accentLight,
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.8,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                // Project title
                Text(
                  project.title,
                  style: TextStyle(
                    color: cs.textPrimary,
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    height: 1.2,
                  ),
                ),
                const SizedBox(height: 4),
                // Live status
                Row(
                  children: [
                    Container(
                      width: 6,
                      height: 6,
                      decoration: BoxDecoration(
                        color: cs.success,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      project.status,
                      style: TextStyle(
                        color: cs.success,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          // Close button
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.close_rounded, size: 18),
            style: IconButton.styleFrom(
              backgroundColor: cs.surfaceElevated,
              foregroundColor: cs.textSecondary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              padding: const EdgeInsets.all(8),
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Web link button
// ─────────────────────────────────────────────────────────────────────────────

class _WebButton extends StatefulWidget {
  final AppColors cs;
  final String url;
  const _WebButton({required this.cs, required this.url});

  @override
  State<_WebButton> createState() => _WebButtonState();
}

class _WebButtonState extends State<_WebButton> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final cs = widget.cs;
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => launchUrl(
          Uri.parse(widget.url),
          mode: LaunchMode.externalApplication,
        ),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
          decoration: BoxDecoration(
            color: _hovered ? cs.accentWithOpacity(0.07) : cs.surfaceElevated,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: _hovered ? cs.accentWithOpacity(0.4) : cs.border,
            ),
          ),
          child: Row(
            children: [
              Icon(
                Icons.language_rounded,
                size: 18,
                color: _hovered ? cs.accentLight : cs.textSecondary,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  widget.url,
                  style: TextStyle(
                    color: _hovered ? cs.accentLight : cs.textSecondary,
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Icon(
                Icons.north_east_rounded,
                size: 13,
                color: _hovered ? cs.accentLight : cs.textMuted,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
