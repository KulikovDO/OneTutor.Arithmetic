import 'package:flutter/material.dart';

class IntroButton extends StatelessWidget {
  final String text;
  final Function onPressed;

  const IntroButton(
      {super.key,
      required this.text,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              const RoundedRectangleBorder(
                side: BorderSide(color: Colors.white, width: 3.0)
              ),
            ),
            backgroundColor: MaterialStateProperty.all(Colors.transparent),
            shadowColor: MaterialStateProperty.all(Colors.transparent),
          ),
      onPressed: () {
        onPressed();
      },
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Text(
          text, 
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
