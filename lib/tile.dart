import 'package:first_app/misc/extensions.dart';
import 'package:first_app/model/category.dart';
import 'package:flutter/material.dart';

class Tile extends StatelessWidget {
  final Category category;
  final double width;
  final double height;
  final Function onPressed;

  const Tile({
    super.key,
    required this.category,
    required this.width,
    required this.height,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            colors: [
              category.color.withOpacity(0.55),
              category.color.withOpacity(0.9),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: ElevatedButton(
          style: ButtonStyle(
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
            ),
            fixedSize: MaterialStateProperty.all(Size(width, height)),
            backgroundColor: MaterialStateProperty.all(Colors.transparent),
            shadowColor: MaterialStateProperty.all(Colors.transparent),
          ),
          onPressed: () {
            onPressed();
          },
          child: Row(
            children: [
              SizedBox(
                width: height / 2,
                child: Icon(
                  category.icon,
                  color: Colors.black,
                  size: 30,
                ),
              ),
              Expanded(
                flex: 1,
                child: Center(
                  child: Text(
                    category.arithmeticOperation.name.capitalize(),
                    style: const TextStyle(fontSize: 30, color: Colors.black),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
