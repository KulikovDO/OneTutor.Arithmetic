import 'package:one_tutor_arithmetic/data/task_name.dart';
import 'package:one_tutor_arithmetic/model/tile_content.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

const categories = [
  TileContent(
    taskName: TaskName.addition,
    color: Colors.purple,
    icon: Icons.add,
  ),
  TileContent(
    taskName: TaskName.subtraction,
    color: Colors.yellow,
    icon: Icons.remove,
  ),
  TileContent(
    taskName: TaskName.multiplication,
    color: Colors.lightBlue,
    icon: Icons.clear,
  ),
  TileContent(
    taskName: TaskName.division,
    color: Colors.teal,
    icon: CupertinoIcons.divide,
  ),
    TileContent(
    taskName: TaskName.ordering,
    color: Colors.green,
    icon: Icons.sort,
  ),
];