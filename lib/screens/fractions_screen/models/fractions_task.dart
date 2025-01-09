import 'dart:math';
import 'package:flutter/material.dart';
import 'package:one_tutor_arithmetic/screens/fractions_screen/data/sector_colors.dart';

Random rng = Random();
const int maxNumOfFractions = 8;

class FractionsTask {
  const FractionsTask({
    required this.overallFractions,
    required this.coloredFractions,
    required this.isCircle,
    required this.text,
    required this.richText,
    required this.color,
  });

  final int overallFractions;
  final int coloredFractions;
  final bool isCircle;
  final String text;
  final Widget richText;
  final Color color;

  static FractionsTask create() => const FractionsTask( overallFractions: 0, coloredFractions:0, isCircle: false, text: "", richText: Text(""), color: Colors.white);

  FractionsTask prepareTask() {

    int overallFractions = 0;
    int coloredFractions = 0;

    do{
      
      overallFractions = rng.nextInt( 7 ) + 2;
      coloredFractions = rng.nextInt( overallFractions - 1 ) + 1;

    }
    while( overallFractions == this.overallFractions && coloredFractions == this.coloredFractions );

    bool isCircle = !this.isCircle;

    String text = isCircle ? "Which part of the circle is colored?" : "Which part of the box is colored?" ; // box

    RichText richText = 
      RichText(
        text: TextSpan(
          style: const TextStyle(fontSize: 20, color: Colors.black,),
          children: [
            TextSpan(text: text),
          ],
        ),
      );

    int colorIndex = rng.nextInt(sectorColors.length);
    Color color = sectorColors[colorIndex];


    return FractionsTask( 
      overallFractions: overallFractions, 
      coloredFractions: coloredFractions,
      isCircle: isCircle,
      text: text, 
      richText: richText,
      color: color,
    );

  }

  bool checkAnswer(int nominator, int denominator) => nominator == coloredFractions && denominator == overallFractions;

}