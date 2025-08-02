import 'package:flutter/material.dart';

///Adding Horizontal animation  to a given child, used in message bubble
class HorizontalAnimation extends StatefulWidget {
  final Widget child;

  ///reverse the animation to be Down To Up
  final bool? leftToRight;
  const HorizontalAnimation({super.key, required this.child, this.leftToRight});

  @override
  HorizontalAnimationState createState() => HorizontalAnimationState();
}

class HorizontalAnimationState extends State<HorizontalAnimation> with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<Offset> translateAnimation;
  late Animation<double> fadeAnimation;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 620));
    translateAnimation = Tween<Offset>(
      //
      begin: widget.leftToRight ?? false ? const Offset(-1, 0) : const Offset(1, 0),
      end: Offset.zero,
    ).animate(
      //
      CurvedAnimation(parent: controller, curve: Curves.fastEaseInToSlowEaseOut),
    );
    fadeAnimation = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(parent: controller, curve: Curves.ease));
    startAnimation();
  }

  /// Start the animation. If animations are enabled, reset and play the animation.
  /// Otherwise, set the animation to the final state (i.e. the end of the animation).
  void startAnimation() {
    // Enable animation: reset and play
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
      //
      child: SlideTransition(position: translateAnimation, child: widget.child),
    );
  }
}
