import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:unping_task/core/constants/app_colors.dart';

class LoadingPage extends StatefulWidget {
  final VoidCallback onComplete;

  const LoadingPage({super.key, required this.onComplete});

  @override
  State<LoadingPage> createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _progressController;
  double _progress = 0.0;
  bool _isExiting = false;

  @override
  void initState() {
    super.initState();
    _progressController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2500),
    );

    _progressController.addListener(() {
      setState(() {
        _progress = _progressController.value;
      });
    });

    _progressController.forward().then((_) async {
      setState(() => _isExiting = true);
      await Future.delayed(const Duration(milliseconds: 600));
      widget.onComplete();
    });
  }

  @override
  void dispose() {
    _progressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cs = AppColors.dark; // Use dark for consistent startup feel
    return Scaffold(
      backgroundColor: cs.background,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Logo Container
            Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [cs.accent, cs.accentLight],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: cs.accent.withValues(alpha: 0.4),
                        blurRadius: 20,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  alignment: Alignment.center,
                  child: const Text(
                    'MA',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 1.5,
                    ),
                  ),
                )
                .animate(target: _isExiting ? 1 : 0)
                .scale(
                  begin: const Offset(1, 1),
                  end: const Offset(1.2, 1.2),
                  duration: 600.ms,
                  curve: Curves.easeIn,
                )
                .fadeOut(duration: 400.ms)
                .animate(
                  onPlay: (controller) => controller.repeat(reverse: true),
                )
                .shimmer(duration: 2.seconds, color: Colors.white24),

            const SizedBox(height: 48),

            // Progress Text
            SizedBox(
              width: 200,
              child:
                  Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'INITIALIZING',
                                style: TextStyle(
                                  color: cs.textSecondary,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: 2,
                                ),
                              ).animate().fadeIn(delay: 200.ms),
                              Text(
                                '${(_progress * 100).toInt()}%',
                                style: TextStyle(
                                  color: cs.accentLight,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w800,
                                  fontFamily: 'monospace',
                                ),
                              ).animate().fadeIn(delay: 400.ms),
                            ],
                          ),
                          const SizedBox(height: 12),
                          // Progress Bar
                          Stack(
                            children: [
                              Container(
                                height: 4,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: cs.surfaceElevated,
                                  borderRadius: BorderRadius.circular(2),
                                ),
                              ),
                              AnimatedContainer(
                                duration: const Duration(milliseconds: 100),
                                height: 4,
                                width: 200 * _progress,
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [cs.accent, cs.accentLight],
                                  ),
                                  borderRadius: BorderRadius.circular(2),
                                  boxShadow: [
                                    BoxShadow(
                                      color: cs.accent.withValues(alpha: 0.5),
                                      blurRadius: 10,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      )
                      .animate(target: _isExiting ? 1 : 0)
                      .fadeOut(duration: 300.ms, curve: Curves.easeIn),
            ),
          ],
        ),
      ),
    );
  }
}
