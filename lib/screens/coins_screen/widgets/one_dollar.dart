import 'package:flutter/material.dart';


const double mainRadius = 80.0;

class OneDollar extends StatelessWidget {

  const OneDollar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    
    return 

      CustomPaint(
        size: const Size(mainRadius, mainRadius),
        painter: OneDollarPainter(),
      );

  }
}

class OneDollarPainter extends CustomPainter { 

  OneDollarPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final mainPaint = Paint()
      ..color = Colors.grey[800]!
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    final backgroundPaint = Paint()
      ..color = Colors.yellow[300]!
      ..style = PaintingStyle.fill;

    Offset center = Offset(0.5*size.width, 0.5*size.width);

    canvas
      // ..drawRect(rect, paint2)
      ..drawCircle(center, size.width / 2, backgroundPaint)
      ..drawCircle(center, size.width / 2, mainPaint)
    ;

    drawText( "DOLLAR", size.width, Offset( 0.26 * size.width, 0.6 * size.width ), size.width / 8, canvas);
    drawText( "1", size.width, Offset( 0.35 * size.width, 0.1 * size.width ), size.width / 2, canvas);

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
