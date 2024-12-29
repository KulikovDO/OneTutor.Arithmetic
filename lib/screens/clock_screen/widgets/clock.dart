// import 'dart:math';

import 'dart:math';

import 'package:flutter/material.dart';

class Clock extends StatelessWidget {

  final double width;
  final int hour;

  const Clock({
    super.key,
    required this.width,
    required this.hour,
  });

  @override
  Widget build(BuildContext context) {
    
    return 

      CustomPaint(
        size: Size(width, width),
        painter: ClockPainter(hour),
      );

  }
}

class ClockPainter extends CustomPainter { 

  final int hour;

  ClockPainter(this.hour);

  @override
  void paint(Canvas canvas, Size size) {
    final paint1 = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = 5;

    final paint2 = Paint()
      ..color = Colors.grey.withOpacity(0.2)
      ..style = PaintingStyle.fill;

    final hourArrowPaint = Paint()
      ..color = const Color.fromARGB(255, 0, 0, 255)
      ..strokeWidth = 5
      ..strokeCap = StrokeCap.round;

    final minuteArrowPaint = Paint()
      ..color = Colors.green
      ..strokeWidth = 4
      ..strokeCap = StrokeCap.round;

    final rect = Rect.fromLTRB(0, 0, size.width, size.height);
    final hourArrowLength = size.width * .25;
    final minuteArrowLength = size.width * 0.17;

    Offset center = Offset(0.5*size.width, 0.5*size.width);

    canvas
      ..drawRect(rect, paint2)
      ..drawCircle(center, size.width / 2, paint1)
      ..drawCircle(center, 5, paint1)

      // ..drawCircle(center, radius, paint1)
      
      // ..drawLine(Offset(0, 0.5*size.width), Offset(size.width, 0.5*size.width), paint1)
      // ..drawLine(Offset(0.5*size.width, 0), Offset(0.5*size.width, size.width), paint1)

      //..drawLine(Offset(0.5*size.width - sin(pi/6)*radius , 0.5*size.width - cos(pi/6)*radius), Offset(0.5*size.width + sin(pi/6)*radius, 0.5*size.width + cos(pi/6)*radius ), paint1)
      // ..drawLine(Offset(0.5*size.width + sin(pi/6)*radius , 0.5*size.width - cos(pi/6)*radius), Offset(0.5*size.width - sin(pi/6)*radius, 0.5*size.width + cos(pi/6)*radius ), paint1)

      // ..drawLine(Offset(0.5*size.width - sin(pi/3)*radius , 0.5*size.width - cos(pi/3)*radius), Offset(0.5*size.width + sin(pi/3)*radius, 0.5*size.width + cos(pi/3)*radius ), paint1)
      // ..drawLine(Offset(0.5*size.width + sin(pi/3)*radius , 0.5*size.width - cos(pi/3)*radius), Offset(0.5*size.width - sin(pi/3)*radius, 0.5*size.width + cos(pi/3)*radius ), paint1)
    ;

    List<Offset> digitsOffsets = [
      Offset(size.width / 1.5, size.width / 13), // 1
      Offset(size.width / 1.25, size.width / 4.5), // 2
      Offset(size.width / 1.15, size.width / 2.35), // 3
      Offset(size.width / 1.25, size.width / 1.6), // 4
      Offset(size.width / 1.5, size.width / 1.3), // 5
      Offset(size.width / 2.15, size.width / 1.2), // 6
      Offset(size.width / 3.6, size.width / 1.3), // 7
      Offset(size.width / 8, size.width / 1.6), // 8
      Offset(size.width / 15, size.width / 2.35), // 9
      Offset(size.width / 11, size.width / 4.5), // 10
      Offset(size.width / 4.3, size.width / 13), // 11
      Offset(size.width / 2.3, size.width / 35), // 12
    ];

    int digit = 1;
    for(Offset digitOffset in digitsOffsets){
      drawText(digit.toString(), size.width, digitOffset, canvas);
      digit++;
    }

    drawArrow(center, getEndOffset(hour, hourArrowLength, size), canvas, 20, hourArrowPaint);
    drawArrow(center, Offset(0.5*size.width, minuteArrowLength), canvas, 15, minuteArrowPaint);

  }

  Offset getEndOffset(int hour, double radius, Size size){
    
    switch(hour){

      case 1:
        return Offset(0.5*size.width + sin(pi/6)*radius , 0.5*size.width - cos(pi/6)*radius); // 1
      case 2:
        return Offset(0.5*size.width + sin(pi/3)*radius , 0.5*size.width - cos(pi/3)*radius); // 2
      case 3:
        return Offset(0.5*size.width + radius, 0.5*size.width); // 3
      case 4:
        return Offset(0.5*size.width + sin(pi/3)*radius, 0.5*size.width + cos(pi/3)*radius); // 4
      case 5:
        return Offset(0.5*size.width + sin(pi/6)*radius, 0.5*size.width + cos(pi/6)*radius); // 5
      case 6:
        return Offset(0.5*size.width, 0.5*size.width + radius); //6
      case 7:
        return Offset(0.5*size.width - sin(pi/6)*radius, 0.5*size.width + cos(pi/6)*radius); // 7
      case 8:
        return Offset(0.5*size.width - sin(pi/3)*radius, 0.5*size.width + cos(pi/3)*radius); // 8
      case 9:
        return Offset(radius, 0.5 * size.width); // 9
      case 10:
        return Offset(0.5*size.width - sin(pi/3)*radius , 0.5*size.width - cos(pi/3)*radius); // 10
      case 11:
        return Offset(0.5*size.width - sin(pi/6)*radius , 0.5*size.width - cos(pi/6)*radius); // 11
      default:
        return Offset(0.5*size.width, radius); // 12
    }

  }


  void drawText(String text, double dimension, Offset offset, Canvas canvas){

    final textStyle = TextStyle(color: Colors.black, fontSize: dimension / 8, fontWeight: FontWeight.bold );
    final textSpan = TextSpan(text: text, style: textStyle);

    final textPainter = TextPainter(text: textSpan, textDirection: TextDirection.ltr);
    textPainter.layout(minWidth: 0, maxWidth: dimension);

    textPainter.paint(canvas, offset);

  }


  void drawArrow(Offset a, Offset b, Canvas canvas, int arrowSize, Paint paint) {

    const arrowAngle = pi / 6;

    final dX = b.dx - a.dx;
    final dY = b.dy - a.dy;
    final angle = atan2(dY, dX);

    // Recalculate b such that it's the end of the line minus the arrow.
    final Offset subtractedB = Offset(
      b.dx - (arrowSize - 2) * cos(angle),
      b.dy - (arrowSize - 2) * sin(angle),
    );

    canvas.drawLine(a, subtractedB, paint);
    final path = Path();

    path.moveTo(b.dx - arrowSize * cos(angle - arrowAngle),
        b.dy - arrowSize * sin(angle - arrowAngle));
    path.lineTo(b.dx, b.dy);
    path.lineTo(b.dx - arrowSize * cos(angle + arrowAngle),
        b.dy - arrowSize * sin(angle + arrowAngle));
    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;

}
