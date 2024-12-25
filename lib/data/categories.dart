import 'package:one_tutor_arithmetic/data/task_name.dart';
import 'package:one_tutor_arithmetic/model/tile_content.dart';
// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

const categories = [
  TileContent(
    taskName: TaskName.addition,
    color: Colors.purple,
    icon: Icons.add,
    description: "Addition",
  ),
  TileContent(
    taskName: TaskName.subtraction,
    color: Colors.yellow,
    icon: Icons.remove,
    description: "Subtraction",
  ),
  // TileContent(
  //   taskName: TaskName.multiplication,
  //   color: Colors.lightBlue,
  //   icon: Icons.clear,
  //   description: "Multiplication",
  // ),
  // TileContent(
  //   taskName: TaskName.division,
  //   color: Colors.teal,
  //   icon: CupertinoIcons.divide,
  //   description: "Division",
  // ),
  TileContent(
    taskName: TaskName.ordering,
    color: Colors.green,
    icon: Icons.sort,
    description: "Ordering",
  ),
  TileContent(
    taskName: TaskName.sequence,
    color: Colors.orange,
    icon: Icons.expand,
    description: "Sequence",
  ),
  TileContent(
    taskName: TaskName.evenOdd,
    color: Colors.lightGreen,
    icon: Icons.switch_left,
    description: "Even And Odd",
  ),
  TileContent(
    taskName: TaskName.moreLess,
    color: Colors.teal,
    icon: Icons.question_mark,
    description: "More or Less",
  ),
  TileContent(
    taskName: TaskName.lollies,
    color: Colors.lightBlue,
    icon: Icons.leak_add,
    description: "Lollies",
  ),
  TileContent(
    taskName: TaskName.daysOfWeek,
    color: Colors.pink,
    icon: Icons.calendar_month,
    description: "Days of Week",
  ),
  TileContent(
    taskName: TaskName.pebbleDivision,
    color: Colors.lime,
    icon: Icons.drag_indicator,
    description: "Pebble Division",
  ),
];