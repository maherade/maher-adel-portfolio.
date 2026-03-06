import 'package:flutter/material.dart';

/// Theme-aware color scheme for the portfolio.
/// Use [AppColors.of(context)] inside widgets.
@immutable
class AppColors extends ThemeExtension<AppColors> {
  final Color background;
  final Color surface;
  final Color surfaceElevated;
  final Color accent;
  final Color accentLight;
  final Color textPrimary;
  final Color textSecondary;
  final Color textMuted;
  final Color border;
  final Color success;
  final bool isDark;

  const AppColors({
    required this.background,
    required this.surface,
    required this.surfaceElevated,
    required this.accent,
    required this.accentLight,
    required this.textPrimary,
    required this.textSecondary,
    required this.textMuted,
    required this.border,
    required this.success,
    required this.isDark,
  });

  /// Retrieve the current theme's colors from context.
  static AppColors of(BuildContext context) =>
      Theme.of(context).extension<AppColors>()!;

  Color accentWithOpacity(double opacity) => accent.withValues(alpha: opacity);
  Color surfaceWithOpacity(double opacity) =>
      surface.withValues(alpha: opacity);

  // ── Dark theme ──────────────────────────────────────────────────────────────
  static const AppColors dark = AppColors(
    background: Color(0xFF0E0E10),
    surface: Color(0xFF161618),
    surfaceElevated: Color(0xFF1E1E22),
    accent: Color(0xFF8B5CF6),
    accentLight: Color(0xFFC4B5FD),
    textPrimary: Color(0xFFF1F1F3),
    textSecondary: Color(0xFF9CA3AF),
    textMuted: Color(0xFF4B5563),
    border: Color(0xFF2A2A2F),
    success: Color(0xFF34D399),
    isDark: true,
  );

  // ── Light theme ─────────────────────────────────────────────────────────────
  static const AppColors light = AppColors(
    background: Color(0xFFF4F4F8),
    surface: Color(0xFFFFFFFF),
    surfaceElevated: Color(0xFFEBEBF2),
    accent: Color(0xFF7C3AED),
    accentLight: Color(0xFF5B21B6),
    textPrimary: Color(0xFF0F0F12),
    textSecondary: Color(0xFF374151),
    textMuted: Color(0xFF9CA3AF),
    border: Color(0xFFD1D5DB),
    success: Color(0xFF059669),
    isDark: false,
  );

  @override
  AppColors copyWith({
    Color? background,
    Color? surface,
    Color? surfaceElevated,
    Color? accent,
    Color? accentLight,
    Color? textPrimary,
    Color? textSecondary,
    Color? textMuted,
    Color? border,
    Color? success,
    bool? isDark,
  }) {
    return AppColors(
      background: background ?? this.background,
      surface: surface ?? this.surface,
      surfaceElevated: surfaceElevated ?? this.surfaceElevated,
      accent: accent ?? this.accent,
      accentLight: accentLight ?? this.accentLight,
      textPrimary: textPrimary ?? this.textPrimary,
      textSecondary: textSecondary ?? this.textSecondary,
      textMuted: textMuted ?? this.textMuted,
      border: border ?? this.border,
      success: success ?? this.success,
      isDark: isDark ?? this.isDark,
    );
  }

  @override
  AppColors lerp(AppColors? other, double t) {
    if (other is! AppColors) return this;
    return AppColors(
      background: Color.lerp(background, other.background, t)!,
      surface: Color.lerp(surface, other.surface, t)!,
      surfaceElevated: Color.lerp(surfaceElevated, other.surfaceElevated, t)!,
      accent: Color.lerp(accent, other.accent, t)!,
      accentLight: Color.lerp(accentLight, other.accentLight, t)!,
      textPrimary: Color.lerp(textPrimary, other.textPrimary, t)!,
      textSecondary: Color.lerp(textSecondary, other.textSecondary, t)!,
      textMuted: Color.lerp(textMuted, other.textMuted, t)!,
      border: Color.lerp(border, other.border, t)!,
      success: Color.lerp(success, other.success, t)!,
      isDark: t < 0.5 ? isDark : other.isDark,
    );
  }
}
