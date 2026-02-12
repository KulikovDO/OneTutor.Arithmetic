import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:one_tutor_arithmetic/tasks/subtraction_decomposition_task/data/highlight_option.dart';
import 'package:one_tutor_arithmetic/tasks/subtraction_decomposition_task/subtraction_decomposition_provider.dart';

Color highlightedBackgroundColor = Colors.lightBlue[100] as Color;
Color initialBackgroundColor = Colors.lightBlue[50] as Color;
Color tappedBackgroundColor = Colors.purple[100] as Color;

class TappableAnimatedTextContainer extends ConsumerStatefulWidget {
  final String text;
  final double boxSize;
  final String tag;
  final HighlightOption highlightOption;

  const TappableAnimatedTextContainer({
    super.key,
    required this.text,
    required this.highlightOption,
    this.tag = "",
    this.boxSize = 80.0,
  });


  @override
  ConsumerState<TappableAnimatedTextContainer> createState() => TappableAnimatedTextContainerState();
}

class TappableAnimatedTextContainerState extends ConsumerState<TappableAnimatedTextContainer> with SingleTickerProviderStateMixin {

  late Animation<double> animation; 
  late AnimationController animationController;
  int iteration = 0;
  int repeatTimes = 3;
  bool isAnimationCompleted = false;
  bool isAnimationStarted = false;
  Color backgroundColor = initialBackgroundColor;
  bool isTapped = false;
  bool canBeTapped = false;

  @override
  void initState() {

    super.initState();

    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
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
            canBeTapped = true;
            isAnimationCompleted = true;
            backgroundColor = highlightedBackgroundColor;
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

  handleTapInside() {

    if(!canBeTapped) {
      return;
    }

    

    if(isTapped){
      
      ref.read(subtractionDecompositionProvider.notifier).deselectNumber(int.parse(widget.tag));
      
      setState(() {
        isTapped = false;
        backgroundColor = highlightedBackgroundColor;
      });
    } else {
      
      bool canProceed = ref.read(subtractionDecompositionProvider.notifier).selectNumber(int.parse(widget.tag), int.parse(widget.text));

      if(!canProceed) {
        return;
      }
      
      setState(() {
        isTapped = true;
        backgroundColor = tappedBackgroundColor;
      });
    }
  }

  @override
  Widget build(BuildContext context) {

    ref.listen(subtractionDecompositionProvider, (previousState, newState) {
      if (newState.shouldAnimate && widget.highlightOption == newState.highlightOption) {

        animationController.forward();
        setState(() {
          isAnimationStarted = true;
        });

      }

      if (newState.shouldResetAnimation && widget.highlightOption == newState.highlightOption) {
        animationController.stop();
        setState(() {
          isAnimationStarted = false;
          isAnimationCompleted = false;
          backgroundColor = initialBackgroundColor;
        });
      }

    });


    getBorder() {
      if(isTapped){
        return Border.all(width: 4, color: Colors.purple[600] as Color);
      }
      else if(isAnimationCompleted || !isAnimationStarted){
        return Border.all(
          width: isAnimationCompleted && isAnimationStarted ? 4 : 2, 
          color: isAnimationCompleted && isAnimationStarted ? Colors.blueAccent : Colors.black
        );
      } 
      else {
        return Border.all(width: animation.value * 4, color: Colors.blueAccent);
      }
    }

    

    return
      Padding(
        padding: const EdgeInsets.all(4.0),
        child: TapRegion(
        onTapInside: (event) => handleTapInside(),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: getBorder(),
            color: backgroundColor,
          ),
          height: widget.boxSize,
          width: widget.boxSize,
          
          child: Center(
            child: 
            Text( widget.text, style: TextStyle(fontSize: 0.56 * widget.boxSize, decoration: TextDecoration.none )),
          ),
        ),
      )
    );
  }
  
}