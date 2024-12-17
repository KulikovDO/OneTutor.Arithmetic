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

class MoreLessTask {
  const MoreLessTask({
    required this.answerOptions,
    required this.answer,
    required this.text,
    required this.richText,
  });
  final List<String> answerOptions;
  final int answer;
  final String text;
  final Widget richText;
}
