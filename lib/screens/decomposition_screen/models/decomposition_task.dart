import 'dart:math';

import 'package:flutter/material.dart';

Random rng = Random();

class DecompositionTask {
  const DecompositionTask({
    required this.sum,
    required this.text,
    required this.richText,
  });

  final int sum;
  final int firstNumber = 5;
  final String text;
  final Widget richText;

  static DecompositionTask create() => const DecompositionTask( sum: -1, text: "", richText: Text(""));

  DecompositionTask prepareTask() {

    List<int> numbers = [1, 2, 3, 4, 5];
    int secondNumber = 0;

    do{
      
      secondNumber = numbers[rng.nextInt(numbers.length)];

    }
    while( secondNumber == sum - firstNumber );

    String text = "Which number should be added to $firstNumber to get ${firstNumber + secondNumber}?";

    Widget richText = 
      RichText(
        text: TextSpan(
          style: const TextStyle(fontSize: 20, color: Colors.black,),
          children: [
            const TextSpan(text: "Which number should be added to "),
            TextSpan(text: firstNumber.toString(), style: const TextStyle(fontWeight: FontWeight.bold)),
            const TextSpan(text: " to get "),
            TextSpan(text: (firstNumber + secondNumber).toString(), style: const TextStyle(fontWeight: FontWeight.bold)),
            const TextSpan(text: "?"),
          ],
        ),
      );


    return DecompositionTask( 
      sum: firstNumber + secondNumber, 
      text: text, 
      richText: richText);

  }

  bool checkAnswer(int value) => sum - firstNumber == value;
  

}