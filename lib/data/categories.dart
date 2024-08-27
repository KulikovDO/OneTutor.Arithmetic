import 'package:first_app/data/arithmetic_operation.dart';
import 'package:first_app/model/category.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

const categories = [
  Category(
    arithmeticOperation: ArithmeticOperation.addition,
    color: Colors.purple,
    icon: Icons.add,
  ),
  Category(
    arithmeticOperation: ArithmeticOperation.subtraction,
    color: Colors.yellow,
    icon: Icons.remove,
  ),
  Category(
    arithmeticOperation: ArithmeticOperation.multiplication,
    color: Colors.lightBlue,
    icon: Icons.clear,
  ),
  Category(
    arithmeticOperation: ArithmeticOperation.division,
    color: Colors.teal,
    icon: CupertinoIcons.divide,
  ),
];