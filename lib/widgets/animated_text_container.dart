import 'package:flutter/material.dart';

class AnimatedTextContainer extends StatefulWidget {
  final String text;
  final double boxSize;

  AnimatedTextContainer({
    super.key,
    required this.text,
    this.boxSize = 80.0,
  });

  final ValueNotifier animate = ValueNotifier(false);

  @override
  State<AnimatedTextContainer> createState() => _AnimatedTextContainerState();
}

class _AnimatedTextContainerState extends State<AnimatedTextContainer> with SingleTickerProviderStateMixin {

  late Animation<double> animation; 
  late AnimationController animationController;
  int iteration = 0;
  int repeatTimes = 3;
  bool isAnimationCompleted = false;
  bool isAnimationStarted = false;

  @override
  void initState() {

    
    widget.animate.addListener(() {

      animationController.forward();
      setState(() {
        isAnimationStarted = true;
      });

    });

    super.initState();

    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );

    Tween<double> progressTween = Tween(begin: 0.0, end: 1.0);
    animation = progressTween.animate(animationController)
      ..addListener(() {
        setState(() {});
      });

    animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          iteration++;
        });
        if (iteration < repeatTimes) {
          
          animationController.reset();
          animationController.forward();
        } else {
          setState(() {
            isAnimationCompleted = true;
          });
        }
      } else if (status == AnimationStatus.dismissed) {
        animationController.forward();
      }
    });

  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return
      Padding(
        padding: const EdgeInsets.all(4.0),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: isAnimationCompleted || !isAnimationStarted ? Border.all(width: 2) : Border.all(width: animation.value * 4),
            color: Colors.lightBlue[50] as Color,
          ),
          height: widget.boxSize,
          width: widget.boxSize,
          
          child: Center(
            child: 
            Text( widget.text, style: TextStyle(fontSize: 0.56 * widget.boxSize, decoration: TextDecoration.none )),
          ),
        ),
      );
  }
}