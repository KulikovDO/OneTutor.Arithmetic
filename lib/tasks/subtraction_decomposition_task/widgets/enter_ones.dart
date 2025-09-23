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
  
  const EnterOnes({
    super.key, 
    required this.firstNumber,
    required this.secondNumber,
    required this.onResultEntered,
    required this.speakText,
  });

  @override
  ConsumerState<EnterOnes> createState() => _EnterOnesState();
}


class _EnterOnesState extends ConsumerState<EnterOnes> {

  // GlobalKey numberTenKey = GlobalKey();
  GlobalKey firstNumberOnesKey = GlobalKey();
  GlobalKey secondNumberOnesKey = GlobalKey();

  // bool isErrorNumberTen = false;
  bool isOnesEntered = false;
  bool isErrorFirstNumberOnes = false;
  bool isErrorSecondNumberOnes = false;

  speakTextAsync(String text) async{
    await widget.speakText(text);
    ref.read(subtractionDecompositionProvider.notifier).animateOnes();
  }

  // handleNumberTenEntered(int value) {  
  //   setState(() {
  //     isErrorNumberTen = value == 1 ? false : true;
  //   });
  // }

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
      /*  (numberTenKey.currentState as TextInputContainerState).valueController.text != ''
      &&*/ (firstNumberOnesKey.currentState as TextInputContainerState).valueController.text != ''
      && (secondNumberOnesKey.currentState as TextInputContainerState).valueController.text != ''
      // && !isErrorNumberTen
      && !isErrorFirstNumberOnes
      && !isErrorSecondNumberOnes
    ){
      setState(() {
        isOnesEntered = true;
      }); 


    } 
  }

  @override
  initState() {

    super.initState();
    speakTextAsync("Enter ones to subtract");

  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // TextInputContainer(key: numberTenKey, onValueEntered: handleNumberTenEntered, isError: isErrorNumberTen, numberOfDigits: 1,),
        
        if(isOnesEntered)
          const SimpleTextContainer(text: "1"),
        if(!isOnesEntered)
          const SizedBox( width: 87, height: 87,),
        TextInputContainer(key: firstNumberOnesKey, onValueEntered: handleFirstNumberOnesEntered, isError: isErrorFirstNumberOnes,  numberOfDigits: 1,),
        const Padding(
          padding: EdgeInsets.only(left: 5, right: 5),
          child: Text(
            "-",
            style: TextStyle(color: Colors.black, fontSize: 60),
          ),
        ),
        TextInputContainer(key: secondNumberOnesKey, onValueEntered: handleSecondNumberOnesEntered, isError: isErrorSecondNumberOnes, numberOfDigits: 1,),
        const Text(
          "=",
          style: TextStyle(color: Colors.black, fontSize: 60),
        ),
      ],
    );
  }
}