import 'dart:math';
import 'package:flutter/material.dart';


Random rng = Random();
List<String> daysOfWeek = [
  "Monday",
  "Tuesday",
  "Wednesday",
  "Thursday",
  "Friday",
  "Saturday",
  "Sunday"
];

class DaysOfWeekAssignment {
  const DaysOfWeekAssignment({
    required this.dayOfWeek,
    required this.answerOptions,
    required this.answer,
    required this.text,
    required this.richText,
  });
  final String dayOfWeek;
  final List<String> answerOptions;
  final String answer;
  final String text;
  final Widget richText;


  static DaysOfWeekAssignment create() => const DaysOfWeekAssignment( dayOfWeek: "", answerOptions: [], answer: "", text: "", richText: Text(""));

  DaysOfWeekAssignment prepareTask() {

    int dayOfWeekIndex = -1;
    String dayOfWeek = "";

    do {
      dayOfWeekIndex = rng.nextInt(daysOfWeek.length);
      dayOfWeek = daysOfWeek[dayOfWeekIndex];
    } 
    while ( dayOfWeek == this.dayOfWeek );

    bool isAfter = rng.nextBool();

    String afterBeforeText = isAfter ? "after" : "before";

    String text = "Which day comes $afterBeforeText $dayOfWeek?"; //TODO: add before

    int answerIndex = -1;

    if(isAfter){
      answerIndex =  dayOfWeekIndex == daysOfWeek.length - 1 ? 0 : dayOfWeekIndex + 1;
    } else {
      answerIndex =  dayOfWeekIndex == 0 ? daysOfWeek.length - 1 : dayOfWeekIndex - 1;
    }

    String answer = daysOfWeek[answerIndex];

    Widget richText = 
      RichText(
        text: TextSpan(
          style: const TextStyle(fontSize: 20, color: Colors.black,),
          children: [
            TextSpan(text: "Which day comes $afterBeforeText "),
            TextSpan(text: dayOfWeek, style: const TextStyle(fontWeight: FontWeight.bold)),
            const TextSpan(text: "?"),
          ],
        ),
      );

    List<String> answerOptions = generateAnswerOptions(answerIndex, dayOfWeekIndex);

    return DaysOfWeekAssignment( dayOfWeek: dayOfWeek, answerOptions: answerOptions, answer: answer, text: text, richText: richText );

  }

  List<String> generateAnswerOptions(int answerIndex, int dayOfWeekIndex){
    List<String> answerOptions = [daysOfWeek[answerIndex]];
    int index = -1;

    for(int i = 0; i < 2; i++){
      do {
        index = rng.nextInt(daysOfWeek.length);
      } 
      while ( index == answerIndex || index == dayOfWeekIndex || answerOptions.contains(daysOfWeek[index]) );
      answerOptions.add(daysOfWeek[index]);
    }

    answerOptions.shuffle();

    return answerOptions;
  }

  bool checkAnswer(String enteredValue) => enteredValue == answer;

}
