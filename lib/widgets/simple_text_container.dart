import 'package:flutter/material.dart';

class SimpleTextContainer extends StatelessWidget {
  final String text;
  final double boxSize;

  const SimpleTextContainer({
    super.key,
    required this.text,
    this.boxSize = 80.0,
  });

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
          height: boxSize,
          width: boxSize,
          
          child: Center(
            child: 
            Text( text, style: TextStyle(fontSize: 0.56 * boxSize, decoration: TextDecoration.none )),
          ),
        ),
      );
  }
}