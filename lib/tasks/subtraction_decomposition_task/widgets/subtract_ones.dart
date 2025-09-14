import 'package:flutter/material.dart';
import 'package:one_tutor_arithmetic/widgets/text_input_container.dart';

class SubtractOnes extends StatefulWidget {
  
  final int firstNumber;
  final int secondNumber;
  // final Function onValuesEntered;
  
  const SubtractOnes({
    super.key, 
    required this.firstNumber,
    required this.secondNumber,
    // required this.onValuesEntered
  });

  @override
  State<SubtractOnes> createState() => _SubtractOnesState();
}


class _SubtractOnesState extends State<SubtractOnes> {
  @override
  Widget build(BuildContext context) {
    return const Column(
      children:[
        SizedBox(
          width: double.infinity,
          height: 80,
          child: 
            Center(
              child: Padding(
                padding: EdgeInsets.only(left: 10, right: 10),
                child: Text(
                  "Subtract Ones",
                  style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
            ),
        ),
      ],
    );
  }
}