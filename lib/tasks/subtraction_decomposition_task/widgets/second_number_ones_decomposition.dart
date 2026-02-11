import 'package:flutter/material.dart';
import 'package:one_tutor_arithmetic/tasks/subtraction_decomposition_task/data/highlight_option.dart';
import 'package:one_tutor_arithmetic/tasks/subtraction_decomposition_task/widgets/tappable_animated_text_container.dart';
import 'package:one_tutor_arithmetic/widgets/simple_text_container.dart';
import 'package:one_tutor_arithmetic/widgets/text_input_container.dart';

class SecondNumberOnesDecomposition extends StatefulWidget {
  
  final int firstNumber;
  final int secondNumber;
  final Function onResultEntered;
  final Function speakText;
  
  const SecondNumberOnesDecomposition({
    super.key, 
    required this.firstNumber,
    required this.secondNumber,
    required this.onResultEntered,
    required this.speakText,
  });

  @override
  State<SecondNumberOnesDecomposition> createState() => _SecondNumberOnesDecompositionState();
}

class _SecondNumberOnesDecompositionState extends State<SecondNumberOnesDecomposition> {
  double boxSize = 60.0;
  bool isSecondNumberError = false;
  bool isSecondNumberEntered = false;
  late int expectedValue;

  GlobalKey<TextInputContainerState> secondNumberKey = GlobalKey();

  speakTextAsync(String text) async => await widget.speakText(text);
  

  @override
  initState() {

    super.initState();
    speakTextAsync("${widget.secondNumber.toString()[1]} is ${widget.firstNumber.toString()[1]} plus which number?");
    expectedValue = int.parse(widget.secondNumber.toString()[1]) - int.parse(widget.firstNumber.toString()[1]);
  }

  handleSecondNumberEntered(int value) async {

    setState(() {
      isSecondNumberError = expectedValue.toString()  == value.toString() ? false : true;
    });
    
    if( // all values entered correctly
      (secondNumberKey.currentState as TextInputContainerState).valueController.text != ''
      && !isSecondNumberError
    ){
      
      setState(() {
        isSecondNumberEntered = true;
      });
      
      await speakTextAsync("That's correct");
      await Future.delayed(const Duration(milliseconds: 1500)); // not sure why previous speakTextAsync is not awaited properly
      widget.onResultEntered();
    } else {
      // incorrect value entered
      await speakTextAsync("Please try again");
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
        TappableAnimatedTextContainer(text: widget.firstNumber.toString()[1], highlightOption: HighlightOption.cancelOut, boxSize: boxSize,),
        const Text(
            "+",
            style: TextStyle(color: Colors.black, fontSize: 40),
        ),
        if(!isSecondNumberEntered)
          TextInputContainer(key: secondNumberKey, onValueEntered: handleSecondNumberEntered, isError: isSecondNumberError, numberOfDigits: 1, boxSize: boxSize,),
        if(isSecondNumberEntered)          
          TappableAnimatedTextContainer(text: expectedValue.toString(), highlightOption: HighlightOption.cancelOut, boxSize: boxSize,),
      ]
    );
  }
}