import 'package:first_app/data/arithmetic_operation.dart';
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