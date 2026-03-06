import 'package:flutter/material.dart';
import 'package:unping_task/core/constants/app_colors.dart';
import 'package:unping_task/core/models/project_model.dart';

class ProjectCard extends StatefulWidget {
  final ProjectModel project;
  final VoidCallback onTap;

  const ProjectCard({super.key, required this.project, required this.onTap});

  @override
  State<ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<ProjectCard> {
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
          duration: const Duration(milliseconds: 220),
          decoration: BoxDecoration(
            color: _hovered ? cs.surfaceElevated : cs.surface,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: _hovered ? cs.accentWithOpacity(0.4) : cs.border,
            ),
            boxShadow: _hovered
                ? [
                    BoxShadow(
                      color: cs.accentWithOpacity(0.08),
                      blurRadius: 28,
                      offset: const Offset(0, 10),
                    ),
                  ]
                : [],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _CardTop(cs: cs, project: widget.project, isHovered: _hovered),
              Padding(
                padding: const EdgeInsets.fromLTRB(22, 0, 22, 22),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _CardTitle(cs: cs, title: widget.project.title),
                    const SizedBox(height: 10),
                    _CardDescription(
                      cs: cs,
                      description: widget.project.description,
                    ),
                    const SizedBox(height: 18),
                    _TechRow(cs: cs, tags: widget.project.tech),
                  ],
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

class _CardTop extends StatelessWidget {
  final AppColors cs;
  final ProjectModel project;
  final bool isHovered;

  const _CardTop({
    required this.cs,
    required this.project,
    required this.isHovered,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(22, 18, 22, 14),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _CategoryBadge(cs: cs, category: project.category),
          Row(
            children: [
              _StatusDot(cs: cs, status: project.status),
              const SizedBox(width: 10),
              AnimatedRotation(
                turns: isHovered ? 0.05 : 0,
                duration: const Duration(milliseconds: 200),
                child: Icon(
                  Icons.north_east_rounded,
                  size: 15,
                  color: isHovered ? cs.accentLight : cs.textMuted,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _CategoryBadge extends StatelessWidget {
  final AppColors cs;
  final String category;
  const _CategoryBadge({required this.cs, required this.category});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 4),
      decoration: BoxDecoration(
        color: cs.accentWithOpacity(0.1),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Text(
        category.toUpperCase(),
        style: TextStyle(
          color: cs.accentLight,
          fontSize: 10,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.8,
        ),
      ),
    );
  }
}

class _StatusDot extends StatelessWidget {
  final AppColors cs;
  final String status;
  const _StatusDot({required this.cs, required this.status});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 6,
          height: 6,
          decoration: BoxDecoration(color: cs.success, shape: BoxShape.circle),
        ),
        const SizedBox(width: 5),
        Text(
          status,
          style: TextStyle(
            color: cs.success,
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

class _CardTitle extends StatelessWidget {
  final AppColors cs;
  final String title;
  const _CardTitle({required this.cs, required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
        color: cs.textPrimary,
        fontSize: 18,
        fontWeight: FontWeight.w700,
        height: 1.2,
      ),
    );
  }
}

class _CardDescription extends StatelessWidget {
  final AppColors cs;
  final String description;
  const _CardDescription({required this.cs, required this.description});

  @override
  Widget build(BuildContext context) {
    return Text(
      description,
      maxLines: 3,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(color: cs.textSecondary, fontSize: 13, height: 1.65),
    );
  }
}

class _TechRow extends StatelessWidget {
  final AppColors cs;
  final List<String> tags;
  const _TechRow({required this.cs, required this.tags});

  @override
  Widget build(BuildContext context) {
    final visible = tags.take(4).toList();
    final overflow = tags.length - visible.length;
    return Wrap(
      spacing: 6,
      runSpacing: 6,
      children: [
        ...visible.map(
          (t) => Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: cs.accentWithOpacity(0.07),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Text(
              t,
              style: TextStyle(
                color: cs.accentLight,
                fontSize: 11,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
        if (overflow > 0)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: cs.border,
              borderRadius: BorderRadius.circular(5),
            ),
            child: Text(
              '+$overflow',
              style: TextStyle(
                color: cs.textMuted,
                fontSize: 11,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
      ],
    );
  }
}
