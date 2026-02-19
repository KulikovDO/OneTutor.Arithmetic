import 'package:flutter/material.dart';

class FinalTextInputs extends StatefulWidget {
  
  final int firstNumber;
  final int secondNumber;
  final Function speakText;
  
  const FinalTextInputs({
    super.key, 
    required this.firstNumber,
    required this.secondNumber,
    required this.speakText,
  });

  @override
  State<FinalTextInputs> createState() => _FinalTextInputsState();
}

class _FinalTextInputsState extends State<FinalTextInputs> {
  @override
  Widget build(BuildContext context) {
    return 
    const Text("Final text inputs",);
  }
}