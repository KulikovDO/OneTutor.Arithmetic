import 'package:flutter/material.dart';

class AnimatedTextContainer extends StatefulWidget {
  final String text;
  final double boxSize;

  const AnimatedTextContainer({
    super.key,
    required this.text,
    this.boxSize = 80.0,
  });

  @override
  State<AnimatedTextContainer> createState() => _AnimatedTextContainerState();
}

class _AnimatedTextContainerState extends State<AnimatedTextContainer> {

  

  @override
  Widget build(BuildContext context) {
    return
      Padding(
        padding: const EdgeInsets.all(4.0),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(width: 2),
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