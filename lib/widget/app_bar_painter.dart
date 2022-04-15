import 'package:flutter/material.dart';

class AppBarPainter extends CustomPainter {
  final Offset center;
  final double radius, containerHeight;
  final BuildContext context;

  double statusBarHeight = 0;
  double screenWidth = 0;

  AppBarPainter({
    required this.context,
    required this.containerHeight,
    required this.center,
    required this.radius,
  }) {
    statusBarHeight = MediaQuery.of(context).padding.top;
    screenWidth = MediaQuery.of(context).size.width;
  }

  @override
  void paint(Canvas canvas, Size size) {
    Paint circlePainter = Paint();
    circlePainter.color = Theme.of(context).colorScheme.primaryContainer;
    canvas.clipRect(
        Rect.fromLTWH(0, 0, screenWidth, containerHeight + statusBarHeight));
    canvas.drawCircle(center, radius, circlePainter);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
