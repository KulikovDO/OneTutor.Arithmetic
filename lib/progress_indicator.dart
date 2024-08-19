import 'package:flutter/material.dart';
import 'dart:math' as math;

class ProgressIndicator extends StatefulWidget {

  const ProgressIndicator({super.key, required this.progress});

  final double progress;

  @override
  State<ProgressIndicator> createState() => _ProgressIndicatorState();

}

class _ProgressIndicatorState extends State<ProgressIndicator> with SingleTickerProviderStateMixin {
  
  late Animation<double> animation;
  late AnimationController controller;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    Tween<double> progressTween = Tween(begin: 0.0, end: widget.progress);

    animation = progressTween.animate(controller)
      ..addListener(() {
        setState(() {});
      });

    controller.forward();

  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }


  @override
  void didUpdateWidget(ProgressIndicator oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.progress != oldWidget.progress) {

      Tween<double> progressTween = Tween(begin: oldWidget.progress, end: widget.progress);

      animation = progressTween.animate(controller)
        ..addListener(() {
          setState(() {});
        });

      controller.reset();
      controller.forward();
    }
  }


  @override
  Widget build(BuildContext context) {
    return Center(
      child: CustomPaint(
        size: const Size(300, 300),
        painter: ProgressIndicatorPainter(animation.value),
      ),
    );
  }

}

class ProgressIndicatorPainter extends CustomPainter { 
  
  final double progress;
  ProgressIndicatorPainter(this.progress);

  @override
  void paint(Canvas canvas, Size size) {

    final rect = Rect.fromLTRB(0, 0, size.width, size.height);
    const startAngle = 0.0;
    final sweepAngle = - math.pi * progress * 2;
    const useCenter = false;
    final paint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = 50;
    canvas.drawArc(rect, startAngle, sweepAngle, useCenter, paint);
  }

   @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
