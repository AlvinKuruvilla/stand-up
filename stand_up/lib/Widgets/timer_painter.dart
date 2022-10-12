import 'package:flutter/material.dart';
import 'dart:math';

// TODO: Show timer progress as it gets closer to zero

class TimerPainter extends CustomPainter {
  final Animation<double> animation;
  final Color backgroundColor, color;

  TimerPainter({
    required this.animation,
    required this.backgroundColor,
    required this.color,
  }) : super(repaint: animation);

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = backgroundColor
      ..strokeWidth = 8.0
      ..strokeCap = StrokeCap.butt
      ..style = PaintingStyle.stroke;
    // the old value was 2.0 instead of 5.0
    canvas.drawCircle(size.center(Offset.zero), size.width / 5.0, paint);
    paint.color = color;
    double progress = (1.0 - animation.value) * 2 * pi;
    canvas.drawArc(Offset.zero & size, pi * 1.5, progress, false, paint);
  }

  @override
  bool shouldRepaint(TimerPainter oldDelegate) {
    return animation.value != oldDelegate.animation.value ||
        color != oldDelegate.color ||
        backgroundColor != oldDelegate.backgroundColor;
  }
}
