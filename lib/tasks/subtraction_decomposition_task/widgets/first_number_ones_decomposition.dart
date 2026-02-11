import 'package:flutter/material.dart';
import 'package:one_tutor_arithmetic/tasks/subtraction_decomposition_task/data/highlight_option.dart';
import 'package:one_tutor_arithmetic/tasks/subtraction_decomposition_task/widgets/tappable_animated_text_container.dart';
import 'package:one_tutor_arithmetic/widgets/simple_text_container.dart';
import 'package:one_tutor_arithmetic/widgets/text_input_container.dart';

class FirstNumberOnesDecomposition extends StatefulWidget {
  
  final int firstNumber;
  final Function onResultEntered;
  // final Future<void> Function(String) speakText;
  final Function speakText;
  
  const FirstNumberOnesDecomposition({
    super.key, 
    required this.firstNumber,
    required this.onResultEntered,
    required this.speakText,
  });

  @override
  State<FirstNumberOnesDecomposition> createState() => _FirstNumberOnesDecompositionState();
}

class _FirstNumberOnesDecompositionState extends State<FirstNumberOnesDecomposition> {

  bool firstNumberError = false;
  bool isFirstNumberEntered = false;

  GlobalKey<TextInputContainerState> firstNumberKey = GlobalKey();
  
  double boxSize = 60.0;

  speakTextAsync(String text) async {
    await widget.speakText(text);
  }

  handleSecondNumberEntered(int value) async {
    setState(() {
      firstNumberError = widget.firstNumber.toString()[1] == value.toString() ? false : true;
    });
    
    if( // all values entered correctly
      (firstNumberKey.currentState as TextInputContainerState).valueController.text != ''
      && !firstNumberError
    ){
      
      await speakTextAsync("That's correct");
      await Future.delayed(const Duration(milliseconds: 1500)); // not sure why previous speakTextAsync is not awaited properly

      setState(() {
        isFirstNumberEntered = true;
      });
      
      
      
      widget.onResultEntered();

    } else {
      
      setState(() {
        isFirstNumberEntered = false;
      });

      speakTextAsync("Please try again");
    }

  }

  @override
  initState() {

    super.initState();
    speakTextAsync("1${widget.firstNumber.toString()[1]} is ten plus which number?");

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
        SimpleTextContainer(text: "1", boxSize: boxSize,),
        SimpleTextContainer(text: "0", boxSize: boxSize,),
        const Text(
            "+",
            style: TextStyle(color: Colors.black, fontSize: 40),
        ),
        if(!isFirstNumberEntered)
          TextInputContainer(key: firstNumberKey, onValueEntered: handleSecondNumberEntered, isError: firstNumberError, numberOfDigits: 1, boxSize: boxSize,),
        if(isFirstNumberEntered)          
          TappableAnimatedTextContainer(text: widget.firstNumber.toString()[1], highlightOption: HighlightOption.cancelOut, boxSize: boxSize,),
      ]
    );
  }

}