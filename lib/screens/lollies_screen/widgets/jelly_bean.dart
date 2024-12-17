import 'dart:math' as math;

import 'package:flutter/material.dart';

var rng = math.Random();
List<Color> colors = [Colors.orange, Colors.red, Colors.yellow, Colors.green, Colors.pink, Colors.blue, Colors.purple, Colors.white];

class JellyBean extends StatefulWidget {

  const JellyBean({
    super.key,
  });

  @override
  State<JellyBean> createState() => _JellyBeanState();
}

class _JellyBeanState extends State<JellyBean> {

  int imageIndex = 0;
  int colorIndex = 0;
  double angle = 0;

  @override
  void initState() {
    super.initState();
    imageIndex = rng.nextInt( 3 ) + 1;
    colorIndex = rng.nextInt(colors.length );
    angle = rng.nextDouble() * math.pi;
  }

  @override
  Widget build(BuildContext context) {
    
    return Padding(
        padding: const EdgeInsets.all(4.0),
        child: SizedBox(
          height: 80.0,
          width: 80.0,
          
          child: Center(
            child: 
              CustomPaint(
              size: const Size(80, 80),
              painter: JellyBeanPainter(colors[colorIndex], angle),
            ),

          ),
        ),
      );

  }
}

class JellyBeanPainter extends CustomPainter { 

  final Color color;
  final double angle;
  JellyBeanPainter(this.color, this.angle);

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
      ..translate(size.width/2, size.height/2)
      ..rotate(angle)
      ..translate(-size.width/2, -size.height/2)
      ..drawPath(path, paint1)
      ..drawPath(path, paint2)
      
    ;

  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
