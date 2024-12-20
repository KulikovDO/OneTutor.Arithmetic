import 'dart:math' as math;

import 'package:flutter/material.dart';

var rng = math.Random();
List<Color> colors = [
  Colors.orange[200] as Color, 
  Colors.red[200] as Color,  
  Colors.yellow[200] as Color,  
  Colors.green[200] as Color,  
  Colors.pink[200] as Color, 
  Colors.blue[200] as Color, 
  Colors.purple[200] as Color, 
  Colors.white
];

class Pebble extends StatefulWidget {

  const Pebble({
    super.key 
  });

  @override
  State<Pebble> createState() => _PebbleState();
}

class _PebbleState extends State<Pebble> {

  int imageIndex = 0;
  int colorIndex = 0;

  @override
  void initState() {
    super.initState();
    imageIndex = rng.nextInt( 3 ) + 1;
    colorIndex = rng.nextInt(colors.length );
  }

  @override
  Widget build(BuildContext context) {
    
    return 
      Draggable(
        feedback: Padding(
            padding: const EdgeInsets.all(2),
            child: SizedBox (
              height: 50.0,
              width: 50.0,
              child: 
                  CustomPaint(
                  size: const Size(50, 50),
                  painter: PebblePainter(colors[colorIndex]),
                ),
          
              
            ),
          ),
        childWhenDragging: const SizedBox (
              height: 54.0,
              width: 54.0,
        ),
        child: 
          Padding(
            padding: const EdgeInsets.all(2),
            child: SizedBox (
              height: 50.0,
              width: 50.0,
              child: 
                  CustomPaint(
                  size: const Size(50, 50),
                  painter: PebblePainter(colors[colorIndex]),
                ),
          
              
            ),
          ),
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
