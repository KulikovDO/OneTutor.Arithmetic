
import 'dart:math';

import 'package:flutter/material.dart';

Random rng = Random();

class MoreLessTask {
  const MoreLessTask({
    required this.firstNumber,
    required this.secondNumber,
    required this.text,
    required this.richText,
  });

  final int firstNumber;
  final int secondNumber;
  final String text;
  final Widget richText;

  static MoreLessTask create() => const MoreLessTask( firstNumber: -1, secondNumber: -1, text: "", richText: Text(""));

  MoreLessTask prepareTask() {

    bool isAddition = rng.nextBool();

    if(isAddition){
      return prepareAdditionTask();
    }

    return prepareSubtractionTask();
    
  }

  MoreLessTask prepareAdditionTask(){
    int firstNumber = 0;
    int secondNumber = 0;

    do{
      
      firstNumber = rng.nextInt( 5 ) + 1;
      secondNumber = rng.nextInt( 5 ) + 1;

    }
    while( firstNumber == this.firstNumber && secondNumber == this.secondNumber );

    int option = rng.nextInt(2);

    List<String> textOptions = [
      "Which number is $firstNumber more than $secondNumber?",
      "$firstNumber is $secondNumber less than which number?",
    ];

    List<Widget> richTextOptions = [
      RichText(
        text: TextSpan(
          style: const TextStyle(fontSize: 20, color: Colors.black,),
          children: [
            const TextSpan(text: "Which number is "),
            TextSpan(text: firstNumber.toString(), style: const TextStyle(fontWeight: FontWeight.bold)),
            const TextSpan(text: " more than "),
            TextSpan(text: secondNumber.toString(), style: const TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
      ),
      RichText(
        text: TextSpan(
          style: const TextStyle(fontSize: 20, color: Colors.black,),
          children: [
            TextSpan(text: firstNumber.toString(), style: const TextStyle(fontWeight: FontWeight.bold)),
            const TextSpan(text: " is "),
            TextSpan(text: secondNumber.toString(), style: const TextStyle(fontWeight: FontWeight.bold)),
            const TextSpan(text: " less than which number?"),
          ],
        ),
      )
    ];

    return MoreLessTask( firstNumber: firstNumber, secondNumber: secondNumber, text: textOptions[option], richText: richTextOptions[option] );

  }

  MoreLessTask prepareSubtractionTask(){
    
    int firstNumber = 0;
    int secondNumber = 0;

    do{
      
      firstNumber = rng.nextInt( 5 ) + 1;
      secondNumber = rng.nextInt( 5 ) + 1;

    }
    while( firstNumber == this.firstNumber && secondNumber == this.secondNumber && firstNumber == secondNumber );

    int sum = firstNumber + secondNumber;

    int option = rng.nextInt(2);
    
    List<String> textOptions = [
      "Which number is $firstNumber less than $sum?",
      "$firstNumber is $secondNumber less than which number?",
    ];

    List<Widget> richTextOptions = [
      RichText(
        text: TextSpan(
          style: const TextStyle(fontSize: 20, color: Colors.black,),
          children: [
            const TextSpan(text: "Which number is "),
            TextSpan(text: firstNumber.toString(), style: const TextStyle(fontWeight: FontWeight.bold)),
            const TextSpan(text: " less than "),
            TextSpan(text: sum.toString(), style: const TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
      ),
      RichText(
        text: TextSpan(
          style: const TextStyle(fontSize: 20, color: Colors.black,),
          children: [
            TextSpan(text: firstNumber.toString(), style: const TextStyle(fontWeight: FontWeight.bold)),
            const TextSpan(text: " is "),
            TextSpan(text: secondNumber.toString(), style: const TextStyle(fontWeight: FontWeight.bold)),
            const TextSpan(text: " less than which number?"),
          ],
        ),
      )
    ];

    return MoreLessTask( firstNumber: firstNumber, secondNumber: secondNumber, text: textOptions[option], richText: richTextOptions[option] );


  }

  bool checkAnswer(int value) {
    return true;
  }

}