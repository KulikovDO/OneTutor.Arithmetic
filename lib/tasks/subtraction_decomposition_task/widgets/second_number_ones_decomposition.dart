import 'package:flutter/material.dart';
import 'package:one_tutor_arithmetic/widgets/simple_text_container.dart';
import 'package:one_tutor_arithmetic/widgets/text_input_container.dart';

class SecondNumberOnesDecomposition extends StatefulWidget {
  
  final int firstNumber;
  final int secondNumber;
  final Function onResultEntered;
  
  const SecondNumberOnesDecomposition({
    super.key, 
    required this.firstNumber,
    required this.secondNumber,
    required this.onResultEntered
  });

  @override
  State<SecondNumberOnesDecomposition> createState() => _SecondNumberOnesDecompositionState();
}

class _SecondNumberOnesDecompositionState extends State<SecondNumberOnesDecomposition> {
  double boxSize = 60.0;
  bool firstNumberError = false;
  bool secondNumberError = false;

  GlobalKey<TextInputContainerState> firstNumberKey = GlobalKey();
  GlobalKey<TextInputContainerState> secondNumberKey = GlobalKey();

  handleFirstNumberEntered(int value) {

    setState(() {
      firstNumberError = widget.firstNumber.toString()[1] == value.toString() ? false : true;
    });
    checkEnteredData();

  }

  handleSecondNumberEntered(int value) {

    setState(() {
      secondNumberError = (int.parse(widget.secondNumber.toString()[1]) - int.parse(widget.firstNumber.toString()[1])).toString()  == value.toString() ? false : true;
    });
    checkEnteredData();
  }

  checkEnteredData() {
    if( // all values entered correctly
      (firstNumberKey.currentState as TextInputContainerState).valueController.text != ''
      && (secondNumberKey.currentState as TextInputContainerState).valueController.text != ''
      && !firstNumberError
      && !secondNumberError
    ){
      widget.onResultEntered();
    } 
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SimpleTextContainer(text: widget.secondNumber.toString()[1], boxSize: boxSize,),
        const Text(
          "=",
          style: TextStyle(color: Colors.black, fontSize: 60),
        ),
        TextInputContainer(key: firstNumberKey, onValueEntered: handleFirstNumberEntered, isError: firstNumberError, numberOfDigits: 1, boxSize: boxSize,),
        const Text(
            "+",
            style: TextStyle(color: Colors.black, fontSize: 40),
        ),
        TextInputContainer(key: secondNumberKey, onValueEntered: handleSecondNumberEntered, isError: secondNumberError, numberOfDigits: 1, boxSize: boxSize,),
      ]
    );
  }
}