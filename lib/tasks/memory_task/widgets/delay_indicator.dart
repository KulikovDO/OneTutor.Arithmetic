import 'package:flutter/material.dart';
import 'dart:math' as math;

class DelayIndicator extends StatefulWidget {

  final Function onCompleted;
  final int repeatTimes; // how many times you want to repeat animation

  const DelayIndicator({
    super.key, 
    required this.onCompleted,
    required this.repeatTimes,
  });

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
      duration: const Duration(milliseconds: 1500),
    );

    Tween<double> progressTween = Tween(begin: 0.0, end: 1.0);
    animation = progressTween.animate(controller)
      ..addListener(() {
        setState(() {});
      });

    controller.forward();

    controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          iteration++;
        });
        if (iteration < widget.repeatTimes) {
          
          controller.reset();
          controller.forward();
        } else {
          widget.onCompleted(); // call the onCompleted function
        }
      } else if (status == AnimationStatus.dismissed) {
        controller.forward();
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

    double width = MediaQuery.sizeOf(context).width;
    double height = MediaQuery.sizeOf(context).height;
    bool isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;

    // indicator size depending on screen orientation
    double size = isPortrait
      ?
    (width / 100).floor() * 100 - 100
      :
    (height / 100).floor() * 100 - 100;

    return 
      Stack(
        children: [
          Center(
            child: CustomPaint(
              size: Size(size, size),
              painter: DelayIndicatorPainter(animation.value),
            ),
          ),
          Center(
            child: Text(
              (widget.repeatTimes - iteration).toString(), 
              style: const TextStyle(fontSize: 100, fontWeight: FontWeight.bold),
            ),
          ),
        ],
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
      ..strokeWidth = 15;
    canvas.drawArc(rect, startAngle, sweepAngle, useCenter, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
