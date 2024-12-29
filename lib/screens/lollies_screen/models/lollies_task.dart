
import 'dart:math';

import 'package:flutter/material.dart';

Random rng = Random();
List<String> names = ["Alex", "John", "Mary", "Sophie", "Olivia"];

class LolliesTask {
  const LolliesTask({
    required this.firstNumber,
    required this.secondNumber,
    required this.lolliesAmount,
    required this.answerOptions,
    required this.answer,
    required this.text,
    required this.richText,
  });

  final int firstNumber;
  final int secondNumber;
  final int lolliesAmount;
  final List<int> answerOptions;
  final int answer;
  final String text;
  final Widget richText;

  static LolliesTask create() => const LolliesTask( firstNumber: -1, secondNumber: -1, lolliesAmount: 0, answerOptions: [], answer: -1, text: "", richText: Text(""));

  LolliesTask prepareTask() {

    bool isAddition = rng.nextBool();

    if(isAddition){
      return prepareAdditionTask();
    }

    return prepareSubtractionTask();
    
  }

  LolliesTask prepareAdditionTask(){
    int firstNumber = 0;
    int secondNumber = 0;

    do{
      
      firstNumber = rng.nextInt( 5 ) + 1;
      secondNumber = rng.nextInt( 5 ) + 1;

    }
    while( firstNumber == this.firstNumber && secondNumber == this.secondNumber );

    String lolliesText = secondNumber == 1 ? "lolly" : "lollies";

    int nameIndex = rng.nextInt(names.length );
    String text = "${names[nameIndex]} is given $secondNumber $lolliesText. How many lollies does ${names[nameIndex]} have now?";

    int answer = firstNumber + secondNumber;

    Widget richText = 
      RichText(
        text: TextSpan(
          style: const TextStyle(fontSize: 20, color: Colors.black,),
          children: [
            TextSpan(text: "${names[nameIndex]} is given "),
            TextSpan(text: secondNumber.toString(), style: const TextStyle(fontWeight: FontWeight.bold)),
            TextSpan(text: " $lolliesText. How many lollies does ${names[nameIndex]} have now?"),
          ],
        ),
      );

    return LolliesTask( 
      firstNumber: firstNumber, 
      secondNumber: secondNumber,
      lolliesAmount: firstNumber,
      answerOptions: generateAnswerOptions(answer), 
      answer: answer, 
      text: text, 
      richText: richText
    );

  }

  LolliesTask prepareSubtractionTask(){
    
    int firstNumber = 0;
    int secondNumber = 0;

    do{
      
      firstNumber = rng.nextInt( 5 ) + 1;
      secondNumber = rng.nextInt( 5 ) + 1;

    }
    while( firstNumber == this.firstNumber && secondNumber == this.secondNumber && firstNumber == secondNumber );

    int sum = firstNumber + secondNumber;
    int nameIndex = rng.nextInt(names.length );
    String lolliesText = firstNumber == 1 ? "lolly" : "lollies";
    String text = "${names[nameIndex]} eats $firstNumber $lolliesText. How many lollies does ${names[nameIndex]} have left?";

    int answer = sum - firstNumber;

    Widget richText = 
      RichText(
        text: TextSpan(
          style: const TextStyle(fontSize: 20, color: Colors.black,),
          children: [
            TextSpan(text: "${names[nameIndex]} eats "),
            TextSpan(text: firstNumber.toString(), style: const TextStyle(fontWeight: FontWeight.bold)),
            TextSpan(text: " $lolliesText. How many lollies does ${names[nameIndex]} have left?"),
          ],
        ),
      );

    return LolliesTask(
      firstNumber: firstNumber,
      secondNumber: secondNumber, 
      lolliesAmount: firstNumber + secondNumber,
      answerOptions: generateAnswerOptions(answer), 
      answer: answer, 
      text: text, 
      richText: richText 
    );

  }

  List<int> generateAnswerOptions(int answer){
    List<int> answerOptions = [];
    
    int min = 0;
    int max = 10;

    if(answer == min){

      answerOptions.add(answer);
      answerOptions.add(answer + 1);
      answerOptions.add(answer + 2);

    } else if(answer == max){
      
      answerOptions.add(answer);
      answerOptions.add(answer - 1);
      answerOptions.add(answer - 2);

    } else {

      answerOptions.add(answer);
      answerOptions.add(answer - 1);
      answerOptions.add(answer + 1);

    }

    answerOptions.shuffle();

    return answerOptions;

  }


  bool checkAnswer(int value) {
    return true;
  }

}