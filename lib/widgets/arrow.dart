import 'package:flutter/material.dart';

class Arrow extends StatelessWidget {
  const Arrow({super.key});

  @override
  Widget build(BuildContext context) {

    double width = MediaQuery.sizeOf(context).width;
    double height = MediaQuery.sizeOf(context).height;
    

    return Center(
      child: CustomPaint(
        size: Size(width, height),
        painter: ArrowPainter(),
      ),
    );

  }

}

class ArrowPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // final rect = Rect.fromLTRB(0, 0, size.width, size.height);
    final paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill
    ;

    Path path = Path();

    path.moveTo( 0.4 * size.width, 0.1 * size.height );
    path.lineTo( 0.6 * size.width, 0.1 * size.height );
    path.lineTo( 0.6 * size.width, 0.7 * size.height );
    path.lineTo( 0.7 * size.width, 0.7 * size.height );
    path.lineTo( 0.5 * size.width, 0.9 * size.height );
    path.lineTo( 0.3 * size.width, 0.7 * size.height );
    path.lineTo( 0.4 * size.width, 0.7 * size.height );
    path.lineTo( 0.4 * size.width, 0.1 * size.height );

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  } 
}