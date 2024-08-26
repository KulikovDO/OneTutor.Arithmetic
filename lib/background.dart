import 'package:flutter/material.dart';


class Background extends StatelessWidget {
  const Background({super.key});

  @override
  Widget build(BuildContext context) {

    double width = MediaQuery.sizeOf(context).width;
    double height = MediaQuery.sizeOf(context).height;

    return Center(
      child: CustomPaint(
        size: Size(width, height),
        painter: BackgroundPainter(),
      ),
    );


  }

}

class BackgroundPainter extends CustomPainter { 
  
  BackgroundPainter();

  @override
  void paint(Canvas canvas, Size size) {

    final rect = Rect.fromLTRB(0, 0, size.width, size.height);

    final backgroundPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    canvas.drawRect(rect, backgroundPaint);

    final fieldPaint = Paint()
      ..color = const Color.fromARGB(255, 232, 195, 191)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    canvas.drawLine(const Offset(70,0), Offset(70, size.height), fieldPaint);

    final linePaint = Paint()
      ..color = const Color.fromARGB(255, 214, 234, 240)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    double y = 30;

    while(y <= size.height)
    {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), linePaint);
      y += 30;
    }
    
  }

   @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}