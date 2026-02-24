import 'package:flutter/material.dart';
import 'package:one_tutor_arithmetic/widgets/simple_text_container.dart';
// import 'package:one_tutor_arithmetic/widgets/simple_text_container.dart';
import 'package:one_tutor_arithmetic/widgets/text_input_container.dart';

class FinalTextInputs extends StatefulWidget {
  
  final int firstNumber;
  final int secondNumber;
  final Function speakText;
  
  const FinalTextInputs({
    super.key, 
    required this.firstNumber,
    required this.secondNumber,
    required this.speakText,
  });

  @override
  State<FinalTextInputs> createState() => _FinalTextInputsState();
}

class _FinalTextInputsState extends State<FinalTextInputs> {

  bool isErrorResultOnes = false;
  bool isErrorResultTens = false;
  bool isResultOnesEntered = false;

  GlobalKey<TextInputContainerState> borrowedTensKey = GlobalKey();
  GlobalKey<TextInputContainerState> finalResultOnesKey = GlobalKey();
  GlobalKey<TextInputContainerState> finalResultTensKey = GlobalKey();

  speakTextAsync(String text) async => await widget.speakText(text);

  @override
  initState() {

    super.initState();
    initAsync();

  }

  initAsync() async {
    await Future.delayed(const Duration(milliseconds: 2000));
    await speakTextAsync("Copy the result of the subtraction ones");
  }

  handleResultOnesEntered(int value){
    int expectedOnes = (widget.firstNumber - widget.secondNumber) % 10;
    if(value == expectedOnes){
      setState(() {
        isErrorResultOnes = false;
        isResultOnesEntered = true;
      });
      speakTextAsync("That's correct!");
    } else {
      setState(() {
        isErrorResultOnes = true;
      });
      speakTextAsync("Please try again.");
    }
  }

  handleResultTensEntered(int value){
    int expectedTens = (widget.firstNumber - widget.secondNumber) ~/ 10;
    if(value == expectedTens){
      setState(() {
        isErrorResultTens = false;
      });
      speakTextAsync("That's correct!");
    } else {
      setState(() {
        isErrorResultTens = true;
      });
      speakTextAsync("Please try again.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children:[
        const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 140,
                child: Text(
                  "Borrowed Tens",
                  style: TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold),
                ),
              ),
              // TextInputContainer(key: borrowedTensKey, onValueEntered: (value) {  }, isError: false,),
              SimpleTextContainer(text: '1'),
              SizedBox( width: 90, ),
            ],
          ),
        
         Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 50.0),
                child: Container(
                  width: 200,
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: Colors.black,
                        width: 3.0,
                      ),
                    )
                  ),
                ),
              ),
            ],
          ),

        Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                width: 140,
                child: Text(
                  "Result",
                  style: TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold),
                ),
              ),
          
              if(!isResultOnesEntered)
                const SimpleTextContainer(text: '?'),
              if(isResultOnesEntered)
                TextInputContainer(key: finalResultTensKey, onValueEntered: handleResultTensEntered, isError: isErrorResultTens, numberOfDigits: 1,),

              TextInputContainer(key: finalResultOnesKey, onValueEntered: handleResultOnesEntered, isError: isErrorResultOnes, numberOfDigits: 1,),
            ],
          ),
      ]
    );
  }
}