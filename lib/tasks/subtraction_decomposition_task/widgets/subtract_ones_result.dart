import 'package:flutter/material.dart';
import 'package:one_tutor_arithmetic/widgets/simple_text_container.dart';
import 'package:one_tutor_arithmetic/widgets/text_input_container.dart';

class SubtractOnesResult extends StatefulWidget {
  
  final int firstNumber;
  final int secondNumber;
  final Function onResultEntered;
  final Function speakText;
  
  const SubtractOnesResult({
    super.key, 
    required this.firstNumber,
    required this.secondNumber,
    required this.onResultEntered,
    required this.speakText,
  });

  @override
  State<SubtractOnesResult> createState() => _SubtractOnesResultState();
}


class _SubtractOnesResultState extends State<SubtractOnesResult> {

  double boxSize = 60.0;
  GlobalKey resultOnesKey = GlobalKey();
  bool isErrorResultOnes = false;
  late int decompositionOnes;
  late int expectedResultOnes;

  speakTextAsync(String text) async => await widget.speakText(text);
  
  handleResultOnesEntered(int value){
    setState(() {
      isErrorResultOnes = value == expectedResultOnes ? false : true;
    });

    if(value == expectedResultOnes){
        speakTextAsync("That's correct");
        widget.onResultEntered(value);
      } else {
        speakTextAsync("Please try again.");
      }
  }

  @override
  void initState() {
  
    decompositionOnes = int.parse(widget.secondNumber.toString()[1]) - int.parse(widget.firstNumber.toString()[1]);
    expectedResultOnes = 
      widget.firstNumber - widget.secondNumber > 9 
      ? int.parse((widget.firstNumber - widget.secondNumber).toString()[1])
      : widget.firstNumber - widget.secondNumber;

    speakTextAsync("How much is 10 minus $decompositionOnes?");
    
    super.initState();
    
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SimpleTextContainer(text: "1", boxSize: boxSize,),
        SimpleTextContainer(text: "0", boxSize: boxSize,),
        const Text(
          "-",
          style: TextStyle(color: Colors.black, fontSize: 60),
        ),
        SimpleTextContainer(text: decompositionOnes.toString(), boxSize: boxSize,),
        const Text(
          "=",
          style: TextStyle(color: Colors.black, fontSize: 60),
        ),
        TextInputContainer(key: resultOnesKey, onValueEntered: handleResultOnesEntered, isError: isErrorResultOnes, numberOfDigits: 1, boxSize: boxSize,),
        
      ],
    );
  }
}