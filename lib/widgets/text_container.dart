import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:one_tutor_arithmetic/data/border_kind.dart';

class TextContainer extends StatelessWidget {
  final Color color;
  final Color textColor;
  final String? text;
  final BorderKind borderKind;

  const TextContainer({
    super.key,
    required this.color,
    required this.textColor,
    required this.text,
    required this.borderKind
  });

  @override
  Widget build(BuildContext context) {
    
    Widget container = 
      Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: color
        ),
        height: 100.0,
        width: 100.0,
        
        child: Center(
          child: 
          text != null ? Text( text!, style: TextStyle(fontSize: 50, color: textColor)) : null,
        ),
      );

      return Padding(
        padding: const EdgeInsets.all(10.0),
        child: DottedBorder(
          color: borderKind == BorderKind.none ? Colors.transparent : textColor,
          borderType: BorderType.RRect,
          radius: const Radius.circular(10),
          strokeWidth: borderKind == BorderKind.dotted ? 3 : 2,
          strokeCap: borderKind == BorderKind.dotted ?  StrokeCap.butt : StrokeCap.round,
          child: container,
        ),
      );

  }
}