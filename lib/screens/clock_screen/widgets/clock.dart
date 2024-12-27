import 'package:flutter/material.dart';

class Clock extends StatelessWidget {

  final double width;

  const Clock({
    super.key,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    
    return 

      CustomPaint(
        size: Size(width, width),
        painter: ClockPainter(),
      );

  }
}

class ClockPainter extends CustomPainter { 

  // ClockPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = 5;

    final path = Path()
      ..moveTo(size.width * 0.1, size.height * 0.4)
      ..quadraticBezierTo(
        size.width * .5,
        0,
        size.width * 0.9,
        size.height * 0.4,
      )
      
      ..quadraticBezierTo(
        size.width * 1.05,
        size.height * 0.7,
        size.width * 0.7,
        size.height * 0.7,
      )
      
      ..quadraticBezierTo(
        size.width * .5,
        size.height * 0.6,
        size.width * 0.3,
        size.height * 0.7,
      )

      ..quadraticBezierTo(
        0,
        size.height * 0.7,
        size.width * 0.1,
        size.height * 0.4,
      )
      ..close()
    ;

    canvas
      .drawPath(path, paint)

    ;

  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
