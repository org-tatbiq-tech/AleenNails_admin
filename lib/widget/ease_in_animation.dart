import 'package:flutter/material.dart';

class EaseInAnimation extends StatefulWidget {
  final Widget child;
  final Function onTap;
  final Duration duration;
  final double beginAnimation;
  bool isDisabled;
  final Curve curve;
  EaseInAnimation(
      {Key? key,
      required this.child,
      required this.onTap,
      this.beginAnimation = 0.95,
      this.curve = Curves.ease,
      this.isDisabled = false,
      this.duration = const Duration(milliseconds: 200)})
      : super(key: key);
  @override
  State<StatefulWidget> createState() => _EaseInAnimationState();
}

class _EaseInAnimationState extends State<EaseInAnimation>
    with TickerProviderStateMixin<EaseInAnimation> {
  late AnimationController controller;
  late Animation<double> easeInAnimation;
  bool isSpringDown = false;
  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      lowerBound: 0,
      upperBound: 1,
      duration: widget.duration,
    );
    controller.value = 1;
    easeInAnimation = Tween(
      begin: widget.isDisabled ? 1.0 : widget.beginAnimation,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: widget.curve,
      ),
    );
  }

  void springDown() {
    isSpringDown = true;
    controller.value = 0;
  }

  Future spring() async {
    isSpringDown = false;
    if (!isSpringDown) controller.forward();
  }

  Future springUp() async {
    isSpringDown = false;

    if (!isSpringDown) controller.value = 1;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTapDown: (tabDown) {
        if (!widget.isDisabled) springDown();
      },
      onTapUp: (tabUp) {
        if (!widget.isDisabled) spring();
      },
      onTap: () {
        if (!widget.isDisabled) widget.onTap();
      },
      onTapCancel: () {
        if (!widget.isDisabled) springUp();
      },
      child: ScaleTransition(
        scale: easeInAnimation,
        child: widget.child,
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
