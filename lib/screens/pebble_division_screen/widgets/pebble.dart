import 'package:flutter/material.dart';

class Pebble extends StatefulWidget {

  final Color color;

  const Pebble({
    super.key,
    required this.color,
  });

  @override
  State<Pebble> createState() => _PebbleState();
}

class _PebbleState extends State<Pebble> {

  

  @override
  void initState() {
    super.initState();
    
  }

  @override
  Widget build(BuildContext context) {
    
    return 

      CustomPaint(
      size: const Size(50, 50),
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
        size.width * 0.8,
        size.height * 0.7,
      )
      
      ..quadraticBezierTo(
        size.width * .5,
        size.height * 0.75,
        size.width * 0.2,
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
      ..drawPath(path, paint1)
      ..drawPath(path, paint2)

    ;

  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
