import 'package:flutter/material.dart';

/// Shares the raw scroll offset value via a [ValueNotifier].
/// Uses [getInheritedWidgetOfExactType] (not [dependOnInheritedWidgetOfExactType])
/// so reading the notifier does NOT cause widget rebuilds.
class ScrollOffsetProvider extends InheritedWidget {
  final ValueNotifier<double> notifier;

  const ScrollOffsetProvider({
    super.key,
    required this.notifier,
    required super.child,
  });

  /// Returns the [ValueNotifier] WITHOUT registering a rebuild dependency.
  static ValueNotifier<double> notifierOf(BuildContext context) {
    return context
        .getInheritedWidgetOfExactType<ScrollOffsetProvider>()!
        .notifier;
  }

  @override
  bool updateShouldNotify(ScrollOffsetProvider old) => notifier != old.notifier;
}
