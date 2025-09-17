import 'package:flutter/material.dart';
import 'package:one_tutor_arithmetic/widgets/simple_text_container.dart';
import 'package:one_tutor_arithmetic/widgets/text_input_container.dart';

class FirstNumberOnesDecomposition extends StatefulWidget {
  
  final int firstNumber;
  final Function onResultEntered;
  
  const FirstNumberOnesDecomposition({
    super.key, 
    required this.firstNumber,
    required this.onResultEntered
  });

  @override
  State<FirstNumberOnesDecomposition> createState() => _FirstNumberOnesDecompositionState();
}

class _FirstNumberOnesDecompositionState extends State<FirstNumberOnesDecomposition> {

  bool tenError = false;
  bool zeroError = false;
  bool firstNumberError = false;

  GlobalKey<TextInputContainerState> tenKey = GlobalKey();
  GlobalKey<TextInputContainerState> zeroKey = GlobalKey();
  GlobalKey<TextInputContainerState> firstNumberKey = GlobalKey();
  
  double boxSize = 60.0;

  handleTenEntered(int value) {
    setState(() {
      tenError = value == 1 ? false : true;
    });
    checkEnteredData();
  }

  handleZeroEntered(int value) {
    setState(() {
      zeroError = value == 0 ? false : true;
    });
    checkEnteredData();
  }

  handleSecondNumberEntered(int value) {
    setState(() {
      firstNumberError = widget.firstNumber.toString()[1] == value.toString() ? false : true;
    });
    checkEnteredData();
  }

  checkEnteredData() {
    if( // all values entered correctly
        (tenKey.currentState as TextInputContainerState).valueController.text != ''
      && (zeroKey.currentState as TextInputContainerState).valueController.text != ''
      && (firstNumberKey.currentState as TextInputContainerState).valueController.text != ''
      && !tenError
      && !zeroError
      && !firstNumberError
    ){
      widget.onResultEntered();
    } 

  }


  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SimpleTextContainer(text: "1", boxSize: boxSize,),
        SimpleTextContainer(text: widget.firstNumber.toString()[1], boxSize: boxSize,),
        const Text(
          "=",
          style: TextStyle(color: Colors.black, fontSize: 60),
        ),
        TextInputContainer(key: tenKey, onValueEntered: handleTenEntered, isError: tenError, numberOfDigits: 1, boxSize: boxSize,),
        TextInputContainer(key: zeroKey, onValueEntered: handleZeroEntered, isError: zeroError, numberOfDigits: 1, boxSize: boxSize,),
        const Text(
            "+",
            style: TextStyle(color: Colors.black, fontSize: 40),
        ),
        TextInputContainer(key: firstNumberKey, onValueEntered: handleSecondNumberEntered, isError: firstNumberError, numberOfDigits: 1, boxSize: boxSize,),
      ]
    );
  }

}