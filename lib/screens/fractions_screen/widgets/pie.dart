import 'dart:math';
import 'package:flutter/material.dart';



class Pie extends StatelessWidget {

  final double size;
  
  final int overallFractions;
  final int coloredFractions;
  final Color color;

  const Pie({
    super.key,
    required this.size,
    required this.overallFractions,
    required this.coloredFractions,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    
    return 
      CustomPaint(
        size: Size(size, size),
        painter: PiePainter(overallFractions, coloredFractions, color),
      );

  }
}

class PiePainter extends CustomPainter { 
  
  final int overallFractions;
  final int coloredFractions;
  final Color color;

  PiePainter(this.overallFractions, this.coloredFractions, this.color);

  @override
  void paint(Canvas canvas, Size size) {

    Offset center = Offset(0.5*size.width, 0.5*size.width);

    final paint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    double radius = 0.5 * size.width;

    canvas
      .drawCircle(center, radius, paint);

    List<Offset> offsets = calculateOffsets(radius);

    drawColoredSectors(canvas, overallFractions, coloredFractions, radius, color);

    for(Offset offset in offsets){
      canvas.drawLine(center, offset, paint);
    }
      
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;

  drawColoredSectors(Canvas canvas, int overallFractions, int coloredFractions, double radius, Color color){

    

    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    Rect rect = Rect.fromCircle(center: Offset(radius, radius), radius: radius);

    final path = Path()
      ..moveTo(radius, radius)
      ..arcTo(rect, -pi / 2, 2*pi * coloredFractions/overallFractions, false)
      ..close()
    ;

    canvas
      .drawPath(path, paint)
    ;

  }

  List<Offset> calculateOffsets(double radius){
    
    List<Offset> offsets = [];
    offsets.add(Offset(radius, 0));
    
    double angle = 0;
    for(int i = 0; i < overallFractions; i++){

      angle += 2*pi / overallFractions;

      if( angle == pi / 2 ){

        offsets.add(Offset(2 * radius, radius));

      } if( angle == pi ){

        offsets.add(Offset(radius, 2 * radius));

      } if( angle == 1.5 * pi ){

        offsets.add(Offset(0, radius));

      } else if(angle > 0 && angle < pi / 2){ // 1 quadrant

        offsets.add(Offset(radius + radius * sin(angle), radius - radius * cos(angle)));

      } else if( angle > pi / 2 && angle < pi){ // 4 quadrant

        offsets.add(Offset(radius + radius * cos(angle-0.5*pi), radius + radius * sin(angle-0.5*pi)));

      } else if( angle > pi && angle < 1.5 * pi){ // 3 quadrant

        offsets.add(Offset(radius - radius * cos(1.5* pi - angle), radius + radius * sin(1.5*pi - angle)));

      } else if( angle > 1.5 * pi && angle < 2 * pi){ // 2 quadrant

        offsets.add(Offset(radius - radius * sin(2*pi - angle), radius - radius * cos(2*pi - angle)));

      }
    }

    return offsets;
  }
}