import 'package:flutter/material.dart';

/// Propagates theme toggle capability throughout the widget tree
/// without requiring explicit callback passing.
class ThemeProvider extends InheritedWidget {
  final ThemeMode mode;
  final VoidCallback toggle;

  const ThemeProvider({
    super.key,
    required this.mode,
    required this.toggle,
    required super.child,
  });

  static ThemeProvider of(BuildContext context) {
    final result = context.dependOnInheritedWidgetOfExactType<ThemeProvider>();
    assert(result != null, 'No ThemeProvider found in widget tree');
    return result!;
  }

  bool get isDark => mode == ThemeMode.dark;

  @override
  bool updateShouldNotify(ThemeProvider oldWidget) => mode != oldWidget.mode;
}
