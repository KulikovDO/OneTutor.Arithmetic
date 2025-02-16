import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

Random rng = Random();
class OrderingTask {

  const OrderingTask({
    required this.order,
    required this.numbers,
    required this.text,
    required this.richText,
  });

  final int order;
  final List<String> numbers;
  final String text;
  final Widget richText;

  static OrderingTask create() => const OrderingTask( order: 0, numbers: [], text: "", richText: Text(""));

  OrderingTask prepareTask() {
    final List<String> numbers = [];
    int order = rng.nextInt( 2 );
    List<String> description = ["Put these numbers in order from highest to lowest", "Put these numbers in order from lowest to highest"];

    // numbers.clear();
    numbers.addAll(_generateNumbers());
    


    return OrderingTask( 
      order: order,
      numbers: numbers,  
      text: description[order], 
      richText: Text( description[order], style:  const TextStyle( fontSize: 20, fontWeight: FontWeight.w500 ))
    );

  }

  List<String> _generateNumbers(){

    List<String> numbers = [];
    
    int number = 0;

    for(int i = 0; i < 3; i++)
    {

      do
      {
        number = rng.nextInt( 10 ) + 1;
      }
      while(numbers.contains(number.toString()));

      numbers.add(number.toString());

    }

    return numbers;

  }

  bool checkAnswer( List<int> answers) {
    
    

    List<int> correctAnswers = [...answers];

    if(order == 0) {
      correctAnswers.sort((b, a) => a.compareTo(b)); // descending
    } else {
      correctAnswers.sort((a, b) => a.compareTo(b)); // ascending
    }

    return listEquals(answers, correctAnswers);

  }
}
