import 'package:first_app/model/category.dart';
import 'package:flutter/material.dart';

class Tile extends StatelessWidget {
  const Tile({
    super.key,
    required this.category,
    required this.onSelect,
  });

  final Category category;
  final void Function() onSelect;

  @override
  Widget build(BuildContext context) {

    return InkWell(
      onTap: onSelect,
      splashColor: Theme.of(context).primaryColor,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            gradient: LinearGradient(
              colors: [
                category.color.withOpacity(0.55),
                category.color.withOpacity(0.9),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            )),
        child: Center(
          child: Text(
            category.title,
            style: const TextStyle(fontSize: 40),
          ),
        ),
      ),
    );


  }

}