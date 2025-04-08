import 'dart:math';
import 'package:flutter/material.dart';
import 'package:collection/collection.dart';

Random rng = Random();
Function unOrdDeepEq = const DeepCollectionEquality.unordered().equals;

class MemoryTask {
  const MemoryTask({
    required this.numbers,
    required this.text,
    required this.richText,
  });

  final List<int> numbers;
  final String text;
  final Widget richText;

  static MemoryTask create() => const MemoryTask( numbers: [], text: "", richText: Text(""));

  MemoryTask prepareTask() {
    
    List<int> numbers = [];

    do{
    
      int number = rng.nextInt( 9 ) + 1;
      
      if(numbers.isEmpty){
        numbers.add(number);
      } else {

        do{
          
          number = rng.nextInt( 9 ) + 1;

        } while(numbers[numbers.length - 1] == number);

        numbers.add(number);

      }

    } while(numbers.length < 3);

    String text = "Enter the numbers: ${numbers.join(", ")}";

    List<TextSpan> textSpans = [const TextSpan(text: "Enter the numbers")];
    for(int i = 0; i < numbers.length; i++){
      textSpans.add(TextSpan(text: " ${numbers[i]}", style: const TextStyle(fontWeight: FontWeight.bold),));
      if(i != numbers.length - 1){
        textSpans.add(const TextSpan(text: ","));
      }
    }

    Widget richText = 
      RichText(
        text: TextSpan(
          style: const TextStyle(fontSize: 20, color: Colors.black,),
          children: [
            ...textSpans,
          ],
        ),
      );


    return MemoryTask( numbers: numbers, text: text, richText: richText);

  }

  bool checkAnswer(List<int> enteredValues) {
    return unOrdDeepEq(enteredValues, numbers);
  }

}