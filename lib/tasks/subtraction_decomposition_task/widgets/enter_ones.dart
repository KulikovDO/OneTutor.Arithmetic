import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:one_tutor_arithmetic/tasks/subtraction_decomposition_task/subtraction_decomposition_provider.dart';
import 'package:one_tutor_arithmetic/widgets/simple_text_container.dart';
import 'package:one_tutor_arithmetic/widgets/text_input_container.dart';

class EnterOnes extends ConsumerStatefulWidget {
  
  final int firstNumber;
  final int secondNumber;
  final Function onResultEntered;
  final Function speakText;
  final bool isResultEntered;
  
  const EnterOnes({
    super.key, 
    required this.firstNumber,
    required this.secondNumber,
    required this.onResultEntered,
    required this.speakText,
    required this.isResultEntered,
  });

  @override
  ConsumerState<EnterOnes> createState() => _EnterOnesState();
}


class _EnterOnesState extends ConsumerState<EnterOnes> {

  double boxSize = 60.0;
  GlobalKey firstNumberOnesKey = GlobalKey();
  GlobalKey secondNumberOnesKey = GlobalKey();

  bool isOnesEntered = false;
  bool isErrorFirstNumberOnes = false;
  bool isErrorSecondNumberOnes = false;

  speakTextAsync(String text) async{
    await widget.speakText(text);
    ref.read(subtractionDecompositionProvider.notifier).animateOnes();
  }

  handleFirstNumberOnesEntered(int value) {  
    setState(() {
      isErrorFirstNumberOnes = widget.firstNumber.toString()[1] == value.toString() ? false : true;
    });
    checkOnceEntered();
  }

  handleSecondNumberOnesEntered(int value) {  
    setState(() {
      isErrorSecondNumberOnes = widget.secondNumber.toString()[1] == value.toString() ? false : true;
    });
    checkOnceEntered();
  }

  checkOnceEntered(){
    if( // all values entered correctly
      (firstNumberOnesKey.currentState as TextInputContainerState).valueController.text != ''
      && (secondNumberOnesKey.currentState as TextInputContainerState).valueController.text != ''
      && !isErrorFirstNumberOnes
      && !isErrorSecondNumberOnes
    ){
      setState(() {
        isOnesEntered = true;
      }); 

      ref.read(subtractionDecompositionProvider.notifier).resetAnimationOnes();
      widget.onResultEntered();

    } 
  }
  getDisplayedResult() {
    if(widget.isResultEntered){
      return ((widget.firstNumber - widget.secondNumber) % 10).toString();
    } else {
      return "?";
    }
  }

  @override
  initState() {

    super.initState();

    if(!widget.isResultEntered) {
      speakTextAsync("Enter ones to subtract");
    }

  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if(isOnesEntered || widget.isResultEntered)
          SimpleTextContainer(text: "1", boxSize: boxSize,),
        if(!(isOnesEntered || widget.isResultEntered))
          const SizedBox( width: 87, height: 87,),
        if(isOnesEntered || widget.isResultEntered)
          SimpleTextContainer(text: widget.firstNumber.toString()[1], boxSize: boxSize,),
        if(!(isOnesEntered || widget.isResultEntered))
          TextInputContainer(key: firstNumberOnesKey, onValueEntered: handleFirstNumberOnesEntered, isError: isErrorFirstNumberOnes,  numberOfDigits: 1, boxSize: boxSize,),

        const Padding(
          padding: EdgeInsets.only(left: 5, right: 5),
          child: Text(
            "-",
            style: TextStyle(color: Colors.black, fontSize: 60),
          ),
        ),
        if(isOnesEntered || widget.isResultEntered)
          SimpleTextContainer(text: widget.secondNumber.toString()[1], boxSize: boxSize,),
        if(!(isOnesEntered || widget.isResultEntered))
          TextInputContainer(key: secondNumberOnesKey, onValueEntered: handleSecondNumberOnesEntered, isError: isErrorSecondNumberOnes, numberOfDigits: 1, boxSize: boxSize,),
        const Text(
          "=",
          style: TextStyle(color: Colors.black, fontSize: 60),
        ),
        if(isOnesEntered || widget.isResultEntered)
          SimpleTextContainer(text: getDisplayedResult(), boxSize: boxSize,),
      ],
    );
  }

}