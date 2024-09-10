import 'package:flutter/material.dart';

class LabeledCheckbox extends StatelessWidget {
  const LabeledCheckbox({
    super.key,
    required this.label,
    required this.value,
    required this.onChanged,
  });

  final String label;
  final bool value;
  final Function onChanged;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onChanged(!value);
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Checkbox(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(2.0),
            ),
            side: MaterialStateBorderSide.resolveWith(
                (states) => const BorderSide(width: 2.0, color: Colors.deepPurple),
            ),
            value: value,
            activeColor: Colors.deepPurple,
            onChanged: (bool? newValue) {
              onChanged(newValue);
            },
          ),
          Text(
            label, 
            style: const TextStyle(color: Colors.deepPurple, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}