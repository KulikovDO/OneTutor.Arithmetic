import 'dart:math';
import 'package:flutter/material.dart';

var rng = Random();

class SequenceAssignment {
  const SequenceAssignment({
    required this.options,
    required this.answer,
    required this.text,
    required this.richText,
  });

  final String text;
  final int answer;
  final List<int> options;
  final Widget richText;

  static SequenceAssignment create() => const SequenceAssignment( options: [], answer: -1, text: "", richText: Text("") );

  SequenceAssignment prepareTask() {

    int start = rng.nextInt( 20 -  6 );
    int missingNumberIndex = rng.nextInt( 4 ) + 1;
    int answer = -1;
    List<int> options = [];
    const text = "What is the missing number?";
    

    for(var i = 0; i < 6; i++){

      if(i == missingNumberIndex){
        options.add(-1);
        answer = start + i;
      } else {
        options.add(start + i);
      }

    }

    bool isReverse = rng.nextBool();

    return SequenceAssignment(
      options: isReverse ? options.reversed.toList() : options,
      answer: answer,
      text: text,
      richText: const Text( text, style: TextStyle( fontSize: 20, fontWeight: FontWeight.w500 ))
    );
  }

  bool checkAnswer(int answer) => answer == this.answer;
}