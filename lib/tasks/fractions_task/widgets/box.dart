import 'package:flutter/material.dart';


class Box extends StatelessWidget {

  final double size;
  final int overallFractions;
  final int coloredFractions;
  final Color color;

  const Box({
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
        size: Size(size, 0.6*size),
        painter: BoxPainter(overallFractions, coloredFractions, color),
      );

  }
}

class BoxPainter extends CustomPainter { 

  final int overallFractions;
  final int coloredFractions;
  final Color color;
  BoxPainter(this.overallFractions, this.coloredFractions, this.color);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    

    final rect = Rect.fromLTRB(0, 0, size.width, size.height);

    canvas.drawRect(rect, paint);

    drawColoredSectors(canvas, overallFractions, coloredFractions, size.width, size.height, color);

    double offset = 0;
    
    for(int i = 0; i < overallFractions; i++){

      offset += size.width / overallFractions;
      canvas.drawLine(Offset(offset, 0), Offset(offset, size.height), paint);

    }

    
    
  }

  drawColoredSectors(Canvas canvas, int overallFractions, int coloredFractions, double width, double height, Color color){

    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final path = Path()
      ..moveTo(0, height)
      ..lineTo(0, 0)
      ..lineTo(width * coloredFractions / overallFractions, 0)
      ..lineTo(width * coloredFractions / overallFractions, height)
      ..close()
    ;

    canvas
      .drawPath(path, paint)
    ;

  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}