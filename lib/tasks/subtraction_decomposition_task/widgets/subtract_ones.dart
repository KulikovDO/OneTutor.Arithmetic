import 'package:flutter/material.dart';
import 'package:one_tutor_arithmetic/widgets/text_input_container.dart';

class SubtractOnes extends StatefulWidget {
  
  final int firstNumber;
  final int secondNumber;
  // final Function onValuesEntered;
  
  const SubtractOnes({
    super.key, 
    required this.firstNumber,
    required this.secondNumber,
    // required this.onValuesEntered
  });

  @override
  State<SubtractOnes> createState() => _SubtractOnesState();
}


class _SubtractOnesState extends State<SubtractOnes> {

  /*late*/ GlobalKey<TextInputContainerState> numberTenKey = GlobalKey();
  /*late*/ GlobalKey<TextInputContainerState> firstNumberOnesKey = GlobalKey();
  /*late*/ GlobalKey<TextInputContainerState> secondNumberOnesKey = GlobalKey();
  /*late*/ GlobalKey<TextInputContainerState> resultOnesKey = GlobalKey();

  bool isErrorNumberTen = false;
  bool isErrorFirstNumberOnes = false;
  bool isErrorSecondNumberOnes = false;
  bool isErrorResultOnes = false;

  handleNumberTenEntered(int value) {  
    setState(() {
      isErrorNumberTen = value == 1 ? false : true;
    });
  }

  handleFirstNumberOnesEntered(int value) {  
    setState(() {
      isErrorFirstNumberOnes = widget.firstNumber.toString()[1] == value.toString() ? false : true;
    });
  }

  handleSecondNumberOnesEntered(int value) {  
    setState(() {
      isErrorSecondNumberOnes = widget.secondNumber.toString()[1] == value.toString() ? false : true;
    });
  }

  handleResultOnesEntered(int value) {  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children:[
        const SizedBox(
          width: double.infinity,
          height: 50,
          child: 
            Center(
              child: Padding(
                padding: EdgeInsets.only(left: 10, right: 10),
                child: Text(
                  "Subtract Ones",
                  style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
            ),
        ),
        
        Row(
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
            TextInputContainer(key: resultOnesKey, onValueEntered: handleResultOnesEntered, isError: isErrorResultOnes, numberOfDigits: 1,),
            
          ],
        ),

      ],
    );
  }

  
}