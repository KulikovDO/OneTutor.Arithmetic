import 'package:flutter/material.dart';
import 'dart:math' as math;

class DelayIndicator extends StatefulWidget {

  const DelayIndicator({super.key});

  /*
  TODO:
  1. Color
  2. Size
  */
  @override
  State<DelayIndicator> createState() => _DelayIndicatorState();

}

class _DelayIndicatorState extends State<DelayIndicator> with SingleTickerProviderStateMixin {

  late Animation<double> animation;
  late AnimationController controller;
  int iteration = 0;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );

    Tween<double> progressTween = Tween(begin: 0.0, end: 1.0);

    animation = progressTween.animate(controller)
      ..addListener(() {
        setState(() {});
      });

    controller.forward();

    controller.addListener(() {

        if (controller.isCompleted && iteration < 3) {
          controller.repeat();
          setState(() {
            print(iteration);
            iteration++;
          });
        }
    });

  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Center(
      child: CustomPaint(
        size: const Size(200, 200),
        painter: DelayIndicatorPainter(animation.value),
      ),
    );
  }

}

class DelayIndicatorPainter extends CustomPainter { 
  
  final double progress;
  DelayIndicatorPainter(this.progress);

  @override
  void paint(Canvas canvas, Size size) {

    final rect = Rect.fromLTRB(0, 0, size.width, size.height);
    const double startAngle = 1.5 * math.pi;
    final sweepAngle = math.pi * progress * 2;
    const useCenter = false;
    final paint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = 20;
    canvas.drawArc(rect, startAngle, sweepAngle, useCenter, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
