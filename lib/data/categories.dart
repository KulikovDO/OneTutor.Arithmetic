import 'package:first_app/model/category.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

const categories = [
  Category(
    id: 'c1',
    title: 'Addition',
    color: Colors.purple,
    icon: Icons.add,
  ),
  Category(
    id: 'c1',
    title: 'Subtraction',
    color: Colors.yellow,
    icon: Icons.remove,
  ),
  Category(
    id: 'c2',
    title: 'Multiplication',
    color: Colors.lightBlue,
    icon: Icons.clear,
  ),
  Category(
    id: 'c3',
    title: 'Division',
    color: Colors.teal,
    icon: CupertinoIcons.divide,
  ),
];