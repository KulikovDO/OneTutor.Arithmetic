import 'package:flutter/material.dart';

class TextContainer extends StatelessWidget {
  final String text;

  const TextContainer({
    super.key,
    required this.text,
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
          height: 80.0,
          width: 80.0,
          
          child: Center(
            child: 
            Text( text, style: const TextStyle(fontSize: 45, decoration: TextDecoration.none )),
          ),
        ),
      );
  }
}