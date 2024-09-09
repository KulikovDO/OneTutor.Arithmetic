import 'package:flutter/material.dart';

class Arrow extends StatefulWidget {
  const Arrow({super.key});

  @override
  State<Arrow> createState() => _ArrowState();
}

class _ArrowState extends State<Arrow> with SingleTickerProviderStateMixin{

  late Animation<double> animation;
  late AnimationController _animationController;


  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    Tween<double> progressTween = Tween(begin: 0.0, end: 20.0);

    animation = progressTween.animate(_animationController)
      ..addListener(() {

        if (_animationController.isCompleted) {
          _animationController.reverse();
        }
        if(_animationController.isDismissed){
          _animationController.forward();
        }


        setState(() {});
      });

    _animationController.forward();

  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    double width = MediaQuery.sizeOf(context).width;
    double height = MediaQuery.sizeOf(context).height;
    

    return Center(
      child: CustomPaint(
        size: Size(width, height),
        painter: ArrowPainter(animation.value),
      ),
    );

  }
}

class ArrowPainter extends CustomPainter {

  final double progress;
  ArrowPainter(this.progress);

  @override
  void paint(Canvas canvas, Size size) {

    final paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill
    ;

    Path path = Path();

    path.moveTo( 0.4 * size.width, 0.2 * size.height + progress );
    
    path.lineTo( 0.6 * size.width, 0.2 * size.height + progress );
    path.lineTo( 0.6 * size.width, 0.6 * size.height + progress );
    path.lineTo( 0.7 * size.width, 0.6 * size.height + progress );
    
    path.lineTo( 0.5 * size.width, 0.8 * size.height + progress );

    path.lineTo( 0.3 * size.width, 0.6 * size.height + progress );
    path.lineTo( 0.4 * size.width, 0.6 * size.height + progress );
    path.lineTo( 0.4 * size.width, 0.2 * size.height + progress ); 

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  } 
}