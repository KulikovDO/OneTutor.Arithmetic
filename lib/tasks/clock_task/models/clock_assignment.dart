import 'dart:math';
import 'package:flutter/material.dart';
import 'package:one_tutor_arithmetic/tasks/clock_task/data/hour_option.dart';



Random rng = Random();

class ClockAssignment {
  const ClockAssignment({
    required this.hour,
    required this.hourOption,
    required this.answerOptions,
    required this.answer,
    required this.text,
    required this.richText,
  });

  final int hour;
  final HourOption hourOption;
  final List<int> answerOptions;
  final int answer;
  final String text;
  final Widget richText;

  static ClockAssignment create() => const ClockAssignment( hour: 12, hourOption: HourOption.exact, answerOptions: [], answer: -1, text: "", richText: Text(""));

  ClockAssignment prepareTask() {

    int hour = 0;
    HourOption hourOption = HourOption.values[0];

    do{
      
      hour = rng.nextInt( 12 ) + 1;
      hourOption = HourOption.values[rng.nextInt( HourOption.values.length )];

    }
    while( hour == this.hour && hourOption == this.hourOption );

    List<String> textOptions = [
      "What time it was one hour ago?",
      "What time is it now?",
      "What time will it be in one hour?",
    ];

    List<Widget> richTextOptions = [
      RichText(
        text: const TextSpan(
          style: TextStyle(fontSize: 20, color: Colors.black,),
          children: [
            TextSpan(text: "What time it was"),
            TextSpan(text: " one hour ", style: TextStyle(fontWeight: FontWeight.bold)),
            TextSpan(text: "ago?"),
          ],
        ),
      ),
      RichText(
        text: const TextSpan(
          style: TextStyle(fontSize: 20, color: Colors.black,),
          children: [
            TextSpan(text: "What time is it"),
            TextSpan(text: " now", style: TextStyle(fontWeight: FontWeight.bold)),
            TextSpan(text: "?"),
          ],
        ),
      ),
      RichText(
        text: const TextSpan(
          style: TextStyle(fontSize: 20, color: Colors.black,),
          children: [
            TextSpan(text: "What time will it be in"),
            TextSpan(text: " one hour", style: TextStyle(fontWeight: FontWeight.bold)),
            TextSpan(text: "?"),
          ],
        ),
      ),
    ];

    int answer = getAnswer(hour, hourOption);

    List<int> answerOptions = generateAnswerOptions(answer);

    return ClockAssignment(
      hour: hour, 
      hourOption: hourOption, 
      answerOptions: answerOptions, 
      answer: answer, 
      text: textOptions[HourOption.values.indexOf(hourOption)], 
      richText: richTextOptions[HourOption.values.indexOf(hourOption)]
    );

  }

  List<int> generateAnswerOptions(int answer){
    List<int> answerOptions = [answer];

    int hour = -1;

    for(int i = 0; i< 2; i++){
      do{
        
        hour = rng.nextInt( 12 ) + 1;

      }
      while( answerOptions.contains(hour) );

      answerOptions.add(hour);

    }

    answerOptions.shuffle();
    return answerOptions;

  }

  int getAnswer(int hour, HourOption hourOption){

    switch(hourOption){
      case HourOption.before:
        return (hour - 1) == 0 ? 12 : hour - 1;
      case HourOption.exact:
        return hour;
      case HourOption.after:
        return (hour + 1) == 13 ? 1 : hour + 1;
    }

  }

  bool checkAnswer(String enteredValue) => int.tryParse(enteredValue) == answer;

}