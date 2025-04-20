import 'dart:math';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

var rng = Random();
Function unOrdDeepEq = const DeepCollectionEquality.unordered().equals;

class EvenOddAssignment {
  const EvenOddAssignment({
    required this.numbers,
    required this.isEven,
    required this.text,
    required this.richText,
  });

  final List<String> numbers; // = [];
  final int isEven; // = 1;
  
  final String text;
  final Widget richText;

  static EvenOddAssignment create() => const EvenOddAssignment( isEven: 1, numbers: [], text: "", richText: Text(""));

  EvenOddAssignment prepareTask() {
    List<String> description = [ "Select the odd numbers", "Select the even numbers"];
    int isEven = rng.nextInt(2);
    
    List<String> numbers = [];
    numbers.addAll(generateNumbers());

    String text = description[isEven];
    Widget richText = Text( text, style:  const TextStyle( fontSize: 20, fontWeight: FontWeight.w500 ));
    return EvenOddAssignment(isEven: isEven, numbers: numbers, text: text, richText: richText);

  }

  List<String> generateNumbers( ){

    List<String> numbers = [];
    
    int number = 0;

    for(int i = 0; i < 6; i++)
    {

      do
      {
        number = rng.nextInt( 30 ) + 1;
      }
      while(numbers.contains(number.toString()));

      numbers.add(number.toString());

    }
    return numbers;
  }

  bool checkAnswer(List<String> selectedNumbers) {

    List<String> evenNumbers = [];
    List<String> oddNumbers = [];

    for(String number in numbers){
      if(int.parse(number)%2 == 0){
        evenNumbers.add(number);
      } else {
        oddNumbers.add(number);
      }
    }

    bool answerIsCorrect = isEven == 1 ? unOrdDeepEq(selectedNumbers, evenNumbers) : unOrdDeepEq(selectedNumbers, oddNumbers);

    return answerIsCorrect;

  }
}