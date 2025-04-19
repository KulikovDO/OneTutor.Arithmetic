import 'package:flutter/material.dart';


const double mainRadius = 100.0;

class FiftyCents extends StatelessWidget {

  const FiftyCents({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    
    return 

      CustomPaint(
        size: const Size(mainRadius, mainRadius),
        painter: FiftyCentsPainter(),
      );

  }
}

class FiftyCentsPainter extends CustomPainter { 

  FiftyCentsPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final mainPaint = Paint()
      ..color = Colors.grey[800]!
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    final backgroundPaint = Paint()
      ..color = Colors.grey[200]!
      ..style = PaintingStyle.fill;

    Offset center = Offset(0.5*size.width, 0.5*size.width);

    canvas
      // ..drawRect(rect, paint2)
      ..drawCircle(center, size.width / 2, backgroundPaint)
      ..drawCircle(center, size.width / 2, mainPaint)
    ;

    drawText( "CENTS", size.width, Offset( 0.3 * size.width, 0.65 * size.width ), size.width / 8, canvas);
    drawText( "50", size.width, Offset( 0.22 * size.width, 0.15 * size.width ), size.width / 2, canvas);

  }

  void drawText(String text, double maxWidth, Offset offset, double fontSize, Canvas canvas){

    final textStyle = TextStyle(color: Colors.grey[800] as Color, fontSize: fontSize, fontWeight: FontWeight.bold);
    final textSpan = TextSpan(text: text, style: textStyle);

    final textPainter = TextPainter(text: textSpan, textDirection: TextDirection.ltr);
    textPainter.layout(minWidth: 0, maxWidth: maxWidth);

    textPainter.paint(canvas, offset);

  }
  

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;

}
