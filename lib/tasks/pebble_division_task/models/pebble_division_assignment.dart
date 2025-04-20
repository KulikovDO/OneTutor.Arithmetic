import 'dart:math';

import 'package:flutter/material.dart';

Random rng = Random();

class PebbleDivisionAssignment {

  const PebbleDivisionAssignment({
      required this.numOfPebbles,
      required this.numOfBuckets,
      required this.answer,
      required this.text,
      required this.richText,
    });

  final int numOfPebbles;
  final int numOfBuckets;
  final int answer;
  final String text;
  final Widget richText;

  static PebbleDivisionAssignment create() => const PebbleDivisionAssignment( numOfPebbles: 0, numOfBuckets: 0, answer: 0, text: "", richText: Text(""));

  PebbleDivisionAssignment prepareTask(){

    int numOfBuckets = 0;
    int pebblesPerBucket = 0;
    int numOfPebbles = 0;
    
    do{
      
      numOfBuckets = rng.nextInt(3) + 2; // max numOfBuckets = 4;
      pebblesPerBucket = rng.nextInt(5) + 1; // max 6 pebbles per bucket

      numOfPebbles = numOfBuckets * pebblesPerBucket;

    }
    while( numOfBuckets == this.numOfBuckets && numOfPebbles == this.numOfPebbles );

    String text = "Share $numOfPebbles pebbles between $numOfBuckets buckets. how many pebbles in each bucket?";

    Widget richText = RichText(
      text: TextSpan(
        style: const TextStyle(fontSize: 20, color: Colors.black,),
        children: [
          const TextSpan(text: "Share "),
          TextSpan(text: numOfPebbles.toString(), style: const TextStyle(fontWeight: FontWeight.bold)),
          const TextSpan(text: " pebbles between "),
          TextSpan(text: numOfBuckets.toString(), style: const TextStyle(fontWeight: FontWeight.bold)),
          const TextSpan(text: " buckets. How many pebbles in each bucket?"),
        ],
      ),
    );


    return PebbleDivisionAssignment( numOfPebbles: numOfPebbles, numOfBuckets: numOfBuckets, answer: pebblesPerBucket, text: text, richText: richText);

  }

  bool checkAnswer(int value) => answer == value;
  
  
}