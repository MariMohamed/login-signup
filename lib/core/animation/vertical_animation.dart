import 'package:flutter/material.dart';

class VerticalAnimation extends StatefulWidget {
  const VerticalAnimation({super.key, required this.child, this.animation});
  final Widget child;
  final Animation<double>? animation;
  @override
  State<VerticalAnimation> createState() => _VerticalAnimationState();
}

class _VerticalAnimationState extends State<VerticalAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<Offset> translateAnimation;
  late Animation<double> fadeAnimation;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 420),
    );
    translateAnimation =
        Tween<Offset>(
          //
          begin: const Offset(0, 1),
          end: Offset.zero,
        ).animate(
          //
          CurvedAnimation(parent: controller, curve: Curves.easeIn),
        );
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
    return SlideTransition(position: translateAnimation, child: widget.child);
  }
}
