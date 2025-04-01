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
    color: Colors.blueAccent,
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
    color: Colors.lightGreen,
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
    
    color: Colors.lightBlue,
    icon: Icons.drag_indicator,
    description: "Pebble Division",
  ),
  TileContent(
    taskName: TaskName.clock,
    color: Colors.greenAccent,
    icon: Icons.punch_clock,
    description: "Clock",
  ),
    TileContent(
    taskName: TaskName.grouping,
    color: Colors.brown,
    icon: Icons.ac_unit,
    description: "Grouping",
  ),
    TileContent(
    taskName: TaskName.coins,
    color: Colors.indigo,
    icon: Icons.toll,
    description: "Coins",
  ),
    TileContent(
    taskName: TaskName.fractions,
    color: Colors.amber,
    icon: Icons.pie_chart,
    description: "Fractions",
  ),
    TileContent(
    taskName: TaskName.memory,
    color: Colors.redAccent,
    icon: Icons.psychology,
    description: "Memory",
  ),
  TileContent(
    taskName: TaskName.memory,
    color: Colors.lightGreenAccent,
    icon: Icons.settings_ethernet,
    description: "Decomposition",
  ),
];

// color: Colors.lime,