import 'package:appointments/utils/layout.dart';
import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations.dart';

enum AnimationType { opacity, translateX }

enum PositionType { top, bottom, right, left }

class FadeAnimation extends StatelessWidget {
  final double delay;
  final PositionType positionType;
  final Widget child;

  const FadeAnimation({
    Key? key,
    required this.delay,
    required this.child,
    this.positionType = PositionType.right,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    getPositionStart() {
      switch (positionType) {
        case PositionType.left:
          return Offset(rSize(30), 0);
        case PositionType.right:
          return Offset(-rSize(30), 0);
        case PositionType.top:
          return Offset(0, rSize(30));
        case PositionType.bottom:
          return Offset(0, -rSize(30));
        default:
      }
    }

    final tween = MultiTween<AnimationType>()
      ..add(
        AnimationType.opacity,
        Tween(begin: 0.0, end: 1.0),
        const Duration(milliseconds: 500),
      )
      ..add(
        AnimationType.translateX,
        Tween(begin: getPositionStart(), end: const Offset(1, 1)),
        const Duration(milliseconds: 500),
      );

    return PlayAnimation<MultiTweenValues<AnimationType>>(
      delay: Duration(milliseconds: (500 * delay).round()),
      duration: tween.duration,
      tween: tween,
      child: child,
      builder: (context, child, value) => Opacity(
        opacity: value.get(AnimationType.opacity),
        child: Transform.translate(
          offset: value.get(AnimationType.translateX),
          child: child,
        ),
      ),
    );
  }
}
