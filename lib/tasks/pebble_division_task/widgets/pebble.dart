import 'package:flutter/material.dart';

class Pebble extends StatefulWidget {

  final Color color;
  final double width;

  const Pebble({
    super.key,
    required this.color,
    required this.width,
  });

  @override
  State<Pebble> createState() => _PebbleState();
}

class _PebbleState extends State<Pebble> {

  @override
  Widget build(BuildContext context) {
    
    return 

      CustomPaint(
        size: Size(widget.width, widget.width * 0.6),
        painter: PebblePainter(widget.color),
      );

  }
}

class PebblePainter extends CustomPainter { 

  final Color color;
  PebblePainter(this.color);

  @override
  void paint(Canvas canvas, Size size) {

    final paint1 = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = 5;

    final paint2 = Paint()
      ..color = color
      ..style = PaintingStyle.fill;
    
    // final paint3 = Paint()
    //   ..color = Colors.grey.withOpacity(0.3)
    //   ..style = PaintingStyle.fill;

    final path = Path()
      ..moveTo(size.width * 0.15, size.height * 0.33)
      ..quadraticBezierTo(
        size.width * .5,
        0,
        size.width * 0.85,
        size.height * 0.33,
      )
      
      ..quadraticBezierTo(
        size.width * 1,
        size.height * 0.7,
        size.width * 0.8,
        size.height * 0.8,
      )
      
      ..quadraticBezierTo(
        size.width * .5,
        size.height * 0.9,
        size.width * 0.2,
        size.height * 0.8,
      )

      ..quadraticBezierTo(
        0,
        size.height * 0.7,
        size.width * 0.15,
        size.height * 0.33,
      )
      ..close()
    ;

    canvas
      // ..drawRect(Rect.fromLTRB( 0.0, 0.0, size.width, size.height), paint3) // background: for testing
      ..drawPath(path, paint1)
      ..drawPath(path, paint2)

    ;

  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
