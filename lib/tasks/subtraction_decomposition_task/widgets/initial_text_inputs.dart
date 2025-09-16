import 'package:flutter/material.dart';
import 'package:one_tutor_arithmetic/widgets/text_input_container.dart';

class InitialTextInputs extends StatefulWidget {
  
  final int firstNumber;
  final int secondNumber;
  final Function onValuesEntered;
  
  const InitialTextInputs({
    super.key, 
    required this.firstNumber,
    required this.secondNumber,
    required this.onValuesEntered
  });

  @override
  State<InitialTextInputs> createState() => _InitialTextInputsState();
}


class _InitialTextInputsState extends State<InitialTextInputs> {

  bool firstNumberTensError = false;
  bool firstNumberOnesError = false;
  bool secondNumberTensError = false;
  bool secondNumberOnesError = false;

  /*late*/ GlobalKey<TextInputContainerState> firstNumberTensKey = GlobalKey();
  /*late*/ GlobalKey<TextInputContainerState> firstNumberOnesKey = GlobalKey();
  /*late*/ GlobalKey<TextInputContainerState> secondNumberTensKey = GlobalKey();
  /*late*/ GlobalKey<TextInputContainerState> secondNumberOnesKey = GlobalKey();

  handleValueEntered(int value, GlobalKey key) {

    setState(() {
      switch(key) {
        case var k when k == firstNumberTensKey:
          firstNumberTensError = (widget.firstNumber.toString()[0] != value.toString());
        case var k when k == firstNumberOnesKey:
          firstNumberOnesError = (widget.firstNumber.toString()[1] != value.toString());
        case var k when k == secondNumberTensKey:
          secondNumberTensError = (widget.secondNumber.toString()[0] != value.toString());
        case var k when k == secondNumberOnesKey:
          secondNumberOnesError = (widget.secondNumber.toString()[1] != value.toString());
      }

      if( // all values entered correctly
        (firstNumberTensKey.currentState as TextInputContainerState).valueController.text != ''
        && (secondNumberTensKey.currentState as TextInputContainerState).valueController.text != ''
        && (firstNumberOnesKey.currentState as TextInputContainerState).valueController.text != ''
        && (secondNumberOnesKey.currentState as TextInputContainerState).valueController.text != ''
        && !firstNumberTensError
        && !firstNumberOnesError
        && !secondNumberTensError
        && !secondNumberOnesError
      ){
        widget.onValuesEntered();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children:[
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              width: 140,
              child: Text(
                "First number",
                style: TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold),
              ),
            ),
            TextInputContainer(key: firstNumberTensKey, onValueEntered: (value) { handleValueEntered(value, firstNumberTensKey); }, isError: firstNumberTensError, numberOfDigits: 1,),
            TextInputContainer(key: firstNumberOnesKey, onValueEntered: (value) { handleValueEntered(value, firstNumberOnesKey); }, isError: firstNumberOnesError,  numberOfDigits: 1,),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              width: 140,
              child: Text(
                "Second number",
                style: TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold),
              ),
            ),
            TextInputContainer(key: secondNumberTensKey, onValueEntered: (value) { handleValueEntered(value, secondNumberTensKey); }, isError: secondNumberTensError, numberOfDigits: 1,),
            TextInputContainer(key: secondNumberOnesKey, onValueEntered: (value) { handleValueEntered(value, secondNumberOnesKey); }, isError: secondNumberOnesError,  numberOfDigits: 1,),
            
          ],
        ),
      ]
    );
  }

}