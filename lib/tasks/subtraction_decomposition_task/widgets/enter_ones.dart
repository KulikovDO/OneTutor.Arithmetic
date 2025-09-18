import 'package:flutter/material.dart';
import 'package:one_tutor_arithmetic/widgets/text_input_container.dart';

class EnterOnes extends StatefulWidget {
  
  final int firstNumber;
  final int secondNumber;
  final Function onResultEntered;
  
  const EnterOnes({
    super.key, 
    required this.firstNumber,
    required this.secondNumber,
    required this.onResultEntered
  });

  @override
  State<EnterOnes> createState() => _EnterOnesState();
}


class _EnterOnesState extends State<EnterOnes> {

  GlobalKey numberTenKey = GlobalKey();
  GlobalKey firstNumberOnesKey = GlobalKey();
  GlobalKey secondNumberOnesKey = GlobalKey();

  bool isErrorNumberTen = false;
  bool isErrorFirstNumberOnes = false;
  bool isErrorSecondNumberOnes = false;

  handleNumberTenEntered(int value) {  
    setState(() {
      isErrorNumberTen = value == 1 ? false : true;
    });
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
        (numberTenKey.currentState as TextInputContainerState).valueController.text != ''
      && (firstNumberOnesKey.currentState as TextInputContainerState).valueController.text != ''
      && (secondNumberOnesKey.currentState as TextInputContainerState).valueController.text != ''
      && !isErrorNumberTen
      && !isErrorFirstNumberOnes
      && !isErrorSecondNumberOnes
    ){
      setState(() {
        // isOnesEntered = true;
        widget.onResultEntered();
      }); 
    } 

  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextInputContainer(key: numberTenKey, onValueEntered: handleNumberTenEntered, isError: isErrorNumberTen, numberOfDigits: 1,),
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