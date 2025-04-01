import 'dart:math';
import 'package:flutter/material.dart';

Random rng = Random();

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

        // while(numbers[numbers.length - 1] != number){
        //   number = rng.nextInt( 10 ) + 1;
        //   numbers.add(number);
        // }
      }

    } while(numbers.length < 3);

    String text = "Enter the following numbers: ${numbers.join(", ")}";

    Widget richText = const Text("Enter the numbers", style: TextStyle(fontSize: 20, color: Colors.black,));


    return MemoryTask( numbers: numbers, text: text, richText: richText);

  }

}