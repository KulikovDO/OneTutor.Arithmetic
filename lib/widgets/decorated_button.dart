import 'package:flutter/material.dart';

class DecoratedButton extends StatelessWidget {
  final double width;
  final double height;
  final String text;
  final IconData icon;
  final Function onPressed;

  const DecoratedButton({
    super.key,
    required this.width,
    required this.height,
    required this.text,
    required this.icon,
    required this.onPressed
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        onPressed: () {
          onPressed();
        },
        child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  icon,
                ),
                const SizedBox(
                  width: 5.0,
                ),
                Text(text),
              ],
            )),
      ),
    );
  }
}
