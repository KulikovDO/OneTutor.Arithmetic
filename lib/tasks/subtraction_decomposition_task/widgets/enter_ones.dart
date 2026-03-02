import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:one_tutor_arithmetic/tasks/subtraction_decomposition_task/data/highlight_option.dart';
import 'package:one_tutor_arithmetic/tasks/subtraction_decomposition_task/subtraction_decomposition_provider.dart';
import 'package:one_tutor_arithmetic/tasks/subtraction_decomposition_task/widgets/animated_text_container.dart';
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

  GlobalKey borrowedTensKey = GlobalKey();
  GlobalKey firstNumberOnesKey = GlobalKey();
  GlobalKey secondNumberOnesKey = GlobalKey();

  bool isBorrowedTensEntered = false;
  bool isErrorBorrowedTens = false;
  bool isErrorFirstNumberOnes = false;
  bool isErrorSecondNumberOnes = false;
  bool isOnesEntered = false;

  speakTextAsync(String text) async => await widget.speakText(text);
  

  handleBorrowedTensEntered(int value) async{  
    
    if(value == 1){
      setState(() {
        isErrorBorrowedTens = false;
        isBorrowedTensEntered = true;
      });

      await speakTextAsync("That's correct!");
      await Future.delayed(const Duration(milliseconds: 2000)); // not sure why previous speakTextAsync is not awaited properly
      widget.onResultEntered();

    } else {
      setState(() {
        isErrorBorrowedTens = true;
      });
      speakTextAsync("Please try again");
    }
    
  }

  handleFirstNumberOnesEntered(int value) {  
    
    if(widget.firstNumber.toString()[1] == value.toString()){
      setState(() {
        isErrorFirstNumberOnes = false;
      });
    } else {
      setState(() {
        isErrorFirstNumberOnes = true;
      });
      speakTextAsync("Please try again");
    }
    checkOnceEntered();
  }

  handleSecondNumberOnesEntered(int value) {  
    
    if(widget.secondNumber.toString()[1] == value.toString()){
      setState(() {
        isErrorSecondNumberOnes = false;
      });
    } else {
      setState(() {
        isErrorSecondNumberOnes = true;
      });
      speakTextAsync("Please try again");
    }
    
    checkOnceEntered();
  }

  checkOnceEntered() async {
    if( // all values entered correctly
      (firstNumberOnesKey.currentState as TextInputContainerState).valueController.text != ''
      && (secondNumberOnesKey.currentState as TextInputContainerState).valueController.text != ''
      && !isErrorFirstNumberOnes
      && !isErrorSecondNumberOnes
    ){
      setState(() {
        isOnesEntered = true;
      }); 

      await speakTextAsync("How much you need to borrow to subtract the ones?");
      ref.read(subtractionDecompositionProvider.notifier).resetAnimation(HighlightOption.ones);
      

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
    initAsync();
  }

  initAsync() async {
    if(!widget.isResultEntered) {
      await speakTextAsync("Enter ones to subtract");
      ref.read(subtractionDecompositionProvider.notifier).animate(HighlightOption.ones);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [

        if(isOnesEntered && !isBorrowedTensEntered)
          TextInputContainer(key: borrowedTensKey, onValueEntered: handleBorrowedTensEntered, isError: isErrorBorrowedTens,  numberOfDigits: 1, boxSize: boxSize,),
        if(isOnesEntered && isBorrowedTensEntered || widget.isResultEntered)
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
        
        if(isOnesEntered && isBorrowedTensEntered || widget.isResultEntered)
          // SimpleTextContainer(text: getDisplayedResult(), boxSize: boxSize,),
          AnimatedTextContainer(text: getDisplayedResult(), highlightOption: HighlightOption.resultOnes, boxSize: boxSize, onAnimationCompleted: (){},),
      ],
    );
  }

}