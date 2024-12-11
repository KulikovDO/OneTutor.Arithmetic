import 'package:flutter/material.dart';

class CustomFloatingActionButton extends StatelessWidget{
  
  final Widget child;
  final Function onPressed;
  final bool isDisabled;

  const CustomFloatingActionButton({
    super.key,
    required this.child,
    required this.onPressed,
    required this.isDisabled
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: isDisabled ? null : () => onPressed(),
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.all(2),
        ),
        child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                child
              ],
            )
          ),
     );
  }
}