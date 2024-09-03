import 'package:one_tutor_arithmetic/data/arithmetic_operation.dart';
import 'package:flutter/material.dart';

class Category {
  const Category({
    required this.arithmeticOperation,
    required this.color,
    required this.icon,
  });

  final ArithmeticOperation arithmeticOperation;
  final Color color;
  final IconData icon;
}