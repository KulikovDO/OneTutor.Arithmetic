import 'package:flutter/material.dart';
import 'package:one_tutor_arithmetic/widgets/animated_text_container.dart';
import 'package:one_tutor_arithmetic/widgets/simple_text_container.dart';
import 'package:one_tutor_arithmetic/widgets/text_input_container.dart';

class InitialTextInputs extends StatefulWidget {
  
  final int firstNumber;
  final int secondNumber;
  final Function onValuesEntered;
  final Function speakText;
  
  const InitialTextInputs({
    super.key, 
    required this.firstNumber,
    required this.secondNumber,
    required this.onValuesEntered,
    required this.speakText,
  });

  @override
  State<InitialTextInputs> createState() => _InitialTextInputsState();
}


class _InitialTextInputsState extends State<InitialTextInputs> {

  bool isFirstNumberEntered = false;
  bool isSecondNumberEntered = false;

  bool firstNumberTensError = false;
  bool firstNumberOnesError = false;
  bool secondNumberTensError = false;
  bool secondNumberOnesError = false;

  GlobalKey<TextInputContainerState> firstNumberTensKey = GlobalKey();
  GlobalKey<TextInputContainerState> firstNumberOnesKey = GlobalKey();
  GlobalKey<TextInputContainerState> secondNumberTensKey = GlobalKey();
  GlobalKey<TextInputContainerState> secondNumberOnesKey = GlobalKey();

  late AnimatedTextContainer firstNumberOnesContainer;

  handleFirstNumberValueEnteredAsync(int value, GlobalKey key) {
    setState(() {
      switch(key) {
        case var k when k == firstNumberTensKey:
          firstNumberTensError = (widget.firstNumber.toString()[0] != value.toString());
        case var k when k == firstNumberOnesKey:
          firstNumberOnesError = (widget.firstNumber.toString()[1] != value.toString());
      }
    });

    // first number entered correctly
    if((firstNumberTensKey.currentState as TextInputContainerState).valueController.text != ''
      && (firstNumberOnesKey.currentState as TextInputContainerState).valueController.text != ''
      && !firstNumberTensError
      && !firstNumberOnesError){
      
      if(!isFirstNumberEntered){
        speakTextAsync( "Enter the second number");
      }
      
      setState(() {
        isFirstNumberEntered = true;
      });

    } else {
      setState(() {
        isFirstNumberEntered = false;
      });
    }
  }
  
  handleSecondNumberValueEnteredAsync(int value, GlobalKey key) {

    setState(() {
      switch(key) {
        case var k when k == secondNumberTensKey:
          secondNumberTensError = (widget.secondNumber.toString()[0] != value.toString());
        case var k when k == secondNumberOnesKey:
          secondNumberOnesError = (widget.secondNumber.toString()[1] != value.toString());
      }
    });

    // second number entered correctly
    if((secondNumberTensKey.currentState as TextInputContainerState).valueController.text != ''
      && (secondNumberOnesKey.currentState as TextInputContainerState).valueController.text != ''
      && !secondNumberTensError
      && !secondNumberOnesError){
      
      setState(() {
        isSecondNumberEntered = true;
      });

      firstNumberOnesContainer.animate.value = true;

      widget.onValuesEntered();
    } else {
      setState(() {
        isSecondNumberEntered = false;
      });
    }

  }

  speakTextAsync(String text) async {
    await widget.speakText(text);
  }

  @override
  initState() {

    super.initState();
    speakTextAsync("Enter the first number");

    firstNumberOnesContainer = AnimatedTextContainer(text: widget.firstNumber.toString()[1]);

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
            if(!isFirstNumberEntered)
              TextInputContainer(key: firstNumberTensKey, onValueEntered: (value) { handleFirstNumberValueEnteredAsync(value, firstNumberTensKey); }, isError: firstNumberTensError, numberOfDigits: 1,),
            if(isFirstNumberEntered)
              SimpleTextContainer(text: widget.firstNumber.toString()[0]),
            if(!isFirstNumberEntered)
              TextInputContainer(key: firstNumberOnesKey, onValueEntered: (value) { handleFirstNumberValueEnteredAsync(value, firstNumberOnesKey); }, isError: firstNumberOnesError,  numberOfDigits: 1,),
            if(isFirstNumberEntered)
              // AnimatedTextContainer(text: widget.firstNumber.toString()[1]),
              firstNumberOnesContainer,
              
          ],
        ),
        if(isFirstNumberEntered)
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
            if(!isSecondNumberEntered)
              TextInputContainer(key: secondNumberTensKey, onValueEntered: (value) { handleSecondNumberValueEnteredAsync(value, secondNumberTensKey); }, isError: secondNumberTensError, numberOfDigits: 1,),
            if(isSecondNumberEntered)
              SimpleTextContainer(text: widget.secondNumber.toString()[0]),
            if(!isSecondNumberEntered)
              TextInputContainer(key: secondNumberOnesKey, onValueEntered: (value) { handleSecondNumberValueEnteredAsync(value, secondNumberOnesKey); }, isError: secondNumberOnesError,  numberOfDigits: 1,),
            if(isSecondNumberEntered)
              AnimatedTextContainer(text: widget.secondNumber.toString()[1]),
            
          ],
        ),
      ]
    );
  }

}