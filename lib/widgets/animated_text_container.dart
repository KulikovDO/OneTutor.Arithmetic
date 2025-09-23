import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:one_tutor_arithmetic/tasks/subtraction_decomposition_task/subtraction_decomposition_provider.dart';

class AnimatedTextContainer extends ConsumerStatefulWidget {
  final String text;
  final double boxSize;

  AnimatedTextContainer({
    super.key,
    required this.text,
    this.boxSize = 80.0,
  });

  final ValueNotifier animate = ValueNotifier(false);

  @override
  ConsumerState<AnimatedTextContainer> createState() => AnimatedTextContainerState();
}

class AnimatedTextContainerState extends ConsumerState<AnimatedTextContainer> with SingleTickerProviderStateMixin {

  late Animation<double> animation; 
  late AnimationController animationController;
  int iteration = 0;
  int repeatTimes = 3;
  bool isAnimationCompleted = false;
  bool isAnimationStarted = false;
  Color backgroundColor = Colors.lightBlue[50] as Color;

  @override
  void initState() {

    
    
    // widget.animate.addListener(() {

    //   animationController.forward();
    //   setState(() {
    //     isAnimationStarted = true;
    //   });

    // });

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
            backgroundColor = Colors.lightBlue[400] as Color;
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

    ref.listen(subtractionDecompositionProvider, (previousState, newState) {
      if (newState.shouldAnimateOnes) {

        animationController.forward();
        setState(() {
          isAnimationStarted = true;
        });

      }
    });

    return
      Padding(
        padding: const EdgeInsets.all(4.0),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: isAnimationCompleted || !isAnimationStarted 
              ? Border.all(
                width: isAnimationCompleted && isAnimationStarted ? 4 : 2, 
                color: isAnimationCompleted && isAnimationStarted ? Colors.blueAccent : Colors.black
              ) 
              : Border.all(width: animation.value * 4, color: Colors.blueAccent),
            color: backgroundColor,
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