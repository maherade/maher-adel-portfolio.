import 'package:flutter/material.dart';

/// Breakpoints and adaptive helpers for responsive layouts.
class AppResponsive {
  AppResponsive._();

  static const double _mobile = 650;
  static const double _tablet = 1100;

  static bool isMobile(BuildContext context) =>
      MediaQuery.sizeOf(context).width < _mobile;

  static bool isTablet(BuildContext context) {
    final w = MediaQuery.sizeOf(context).width;
    return w >= _mobile && w < _tablet;
  }

  static bool isDesktop(BuildContext context) =>
      MediaQuery.sizeOf(context).width >= _tablet;

  /// Horizontal section padding: 20 / 50 / 100
  static double hPad(BuildContext context) {
    final w = MediaQuery.sizeOf(context).width;
    if (w < _mobile) return 20;
    if (w < _tablet) return 50;
    return 100;
  }

  /// Vertical section padding: 70 / 90 / 110
  static double vPad(BuildContext context) {
    final w = MediaQuery.sizeOf(context).width;
    if (w < _mobile) return 70;
    if (w < _tablet) return 90;
    return 110;
  }

  /// Returns one of three values based on screen size.
  static T value<T>(
    BuildContext context, {
    required T mobile,
    required T tablet,
    required T desktop,
  }) {
    if (isMobile(context)) return mobile;
    if (isTablet(context)) return tablet;
    return desktop;
  }

  /// Hero heading font size: 38 / 54 / 68
  static double heroFontSize(BuildContext context) =>
      value(context, mobile: 36.0, tablet: 52.0, desktop: 68.0);

  /// Section title font size: 28 / 34 / 40
  static double sectionTitleSize(BuildContext context) =>
      value(context, mobile: 26.0, tablet: 32.0, desktop: 40.0);

  /// Body font size: 15 / 16 / 16
  static double bodySize(BuildContext context) =>
      value(context, mobile: 14.0, tablet: 15.0, desktop: 16.0);
}
