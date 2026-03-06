import 'package:flutter/material.dart';
import 'package:unping_task/core/providers/scroll_offset_provider.dart';

/// Wraps [child] and reveals it with a fade + translate animation
/// the first time it scrolls into the visible viewport.
///
/// Uses the [ScrollOffsetProvider] to listen for scroll events without
/// causing any extra widget rebuilds.
class ScrollReveal extends StatefulWidget {
  final Widget child;

  /// How long to wait after becoming visible before starting the animation.
  final Duration delay;

  /// Starting offset for the slide animation (fractional).
  /// Default `Offset(0, 0.06)` slides up.
  final Offset slideBegin;

  /// Duration of the reveal animation.
  final Duration duration;

  const ScrollReveal({
    super.key,
    required this.child,
    this.delay = Duration.zero,
    this.slideBegin = const Offset(0, 0.06),
    this.duration = const Duration(milliseconds: 650),
  });

  @override
  State<ScrollReveal> createState() => _ScrollRevealState();
}

class _ScrollRevealState extends State<ScrollReveal>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _fade;
  late final Animation<Offset> _slide;

  bool _triggered = false;
  ValueNotifier<double>? _scrollNotifier;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration);
    _fade = CurvedAnimation(parent: _controller, curve: Curves.easeOut);
    _slide = Tween<Offset>(
      begin: widget.slideBegin,
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    // Schedule after first frame so RenderBox is attached.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      _subscribeToScroll();
      _checkVisibility(); // Fire immediately if widget starts visible
    });
  }

  void _subscribeToScroll() {
    _scrollNotifier = ScrollOffsetProvider.notifierOf(context);
    _scrollNotifier!.addListener(_checkVisibility);
  }

  void _checkVisibility() {
    if (_triggered || !mounted) return;

    final renderBox = context.findRenderObject() as RenderBox?;
    if (renderBox == null || !renderBox.attached) return;

    final screenH = MediaQuery.sizeOf(context).height;
    final topOfWidget = renderBox.localToGlobal(Offset.zero).dy;

    // Trigger when the widget top is within 90% of the viewport height
    if (topOfWidget < screenH * 0.92) {
      _triggered = true;
      _scrollNotifier?.removeListener(_checkVisibility);
      Future.delayed(widget.delay, () {
        if (mounted) _controller.forward();
      });
    }
  }

  @override
  void dispose() {
    _scrollNotifier?.removeListener(_checkVisibility);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fade,
      child: SlideTransition(position: _slide, child: widget.child),
    );
  }
}
