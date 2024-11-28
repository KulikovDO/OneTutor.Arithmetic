import 'package:flutter/material.dart';

class StackedIcons extends StatelessWidget {
  final IconData baseIcon;
  final IconData secondIcon;
  final double size;


  const StackedIcons({
    super.key,
    required this.baseIcon,
    required this.secondIcon,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {

    return SizedBox(
      height: size,
      width: size,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Align(
            alignment: Alignment.bottomLeft,
            child: SizedBox(
              height: 0.95 * size,
              width: 0.95 * size,
              child: Text(String.fromCharCode(baseIcon.codePoint),
                style: TextStyle(
                  inherit: false,
                  fontSize: 0.95 * size,
                  fontWeight: FontWeight.w800,
                  fontFamily: baseIcon.fontFamily,
                  color: Colors.black
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.topRight,
            child: SizedBox(
              height: 0.5 * size,
              width: 0.5 * size,
              child: Text(String.fromCharCode(secondIcon.codePoint),
                style: TextStyle(
                  inherit: false,
                  fontSize: 0.5 * size,
                  fontWeight: FontWeight.w800,
                  fontFamily: secondIcon.fontFamily,
                  color: Colors.black
                ),
              ),
            ),
          ),
        ],
      ),
    );


  }
}