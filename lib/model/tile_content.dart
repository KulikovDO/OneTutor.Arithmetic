import 'package:one_tutor_arithmetic/data/task_name.dart';
import 'package:flutter/material.dart';

class TileContent {
  const TileContent({
    required this.taskName,
    required this.color,
    required this.icon,
  });

  final TaskName taskName;
  final Color color;
  final IconData icon;
}