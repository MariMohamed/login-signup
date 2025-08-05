import 'package:flutter/material.dart';

class ScaledAnimation extends StatefulWidget {
  const ScaledAnimation({super.key, required this.child, this.duration});
  final Widget child;
  final Duration? duration;
  @override
  State<ScaledAnimation> createState() => _ScaleAnimationState();
}

class _ScaleAnimationState extends State<ScaledAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> translateAnimation;
  late Animation<double> fadeAnimation;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: widget.duration ?? Duration(milliseconds: 820),
    );
    translateAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(parent: controller, curve: Curves.bounceOut));

    fadeAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(parent: controller, curve: Curves.bounceOut));
    startAnimation();
  }

  void startAnimation() {
    controller
      ..reset()
      ..forward();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: fadeAnimation,
      child: ScaleTransition(scale: translateAnimation, child: widget.child),
    );
  }
}
