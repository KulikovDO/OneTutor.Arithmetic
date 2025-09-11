import 'dart:math';
import 'package:flutter/material.dart';

var rng = Random();

class SubtractionDecompositionAssignment {
  const SubtractionDecompositionAssignment({
    required this.firstNumber,
    required this.secondNumber,
    required this.text,
    required this.richText,
  });

  final String text;
  final int firstNumber;
  final int secondNumber;
  final Widget richText;

  static SubtractionDecompositionAssignment create() => const SubtractionDecompositionAssignment( firstNumber: -1, secondNumber: -1, text: "", richText: Text("") );

  SubtractionDecompositionAssignment prepareTask(int prevFirstNumber, int prevSecondNumber) {

    int firstNumber = 0;
    int secondNumber = 0;

    do{
      
      int firstOnes = rng.nextInt(8) + 1; // from 1 to 8
      int secondOnes = rng.nextInt( 9 - (firstOnes)  ) + firstOnes + 1; // firstOnes to 9

      int firstTens = rng.nextInt( 9 - 2 ) + 2; // from 2 to 9
      int secondTens = rng.nextInt( firstTens - 1 ) + 1; // 1 to firstTens

      firstNumber = firstOnes + firstTens * 10;
      secondNumber = secondOnes + secondTens * 10;

    }
    while( firstNumber == prevFirstNumber || secondNumber == prevSecondNumber );
   

    final text = 'How much is $firstNumber minus $secondNumber?';

    Widget richText = RichText(
      text: TextSpan(
        style: const TextStyle(fontSize: 20, color: Colors.black,),
        children: [
          const TextSpan(text: "How much is "),
          TextSpan(text: "$firstNumber", style: const TextStyle(fontWeight: FontWeight.bold)),
          const TextSpan(text: " - "),
          TextSpan(text: "$secondNumber", style: const TextStyle(fontWeight: FontWeight.bold)),
          const TextSpan(text: "?"),
        ],
      ),
    );

    return SubtractionDecompositionAssignment(
      firstNumber: firstNumber,
      secondNumber: secondNumber,
      text: text,
      richText: richText
    );
  }


}