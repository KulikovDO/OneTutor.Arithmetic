import 'package:flutter/material.dart';
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

  GlobalKey<TextInputContainerState> borrowedTensKey = GlobalKey();
  GlobalKey<TextInputContainerState> finalResultOnesKey = GlobalKey();
  GlobalKey<TextInputContainerState> finalResultTensKey = GlobalKey();

  speakTextAsync(String text) async => await widget.speakText(text);

  @override
  initState() {

    super.initState();
    speakTextAsync("Copy the result of the subtraction ones");

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
              ),
              TextInputContainer(key: borrowedTensKey, onValueEntered: (value) {  }, isError: false,),
              const SizedBox(
                width: 90,
              ),
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
          
              TextInputContainer(key: finalResultTensKey, onValueEntered: (value) {  }, isError: false,),
              TextInputContainer(key: finalResultOnesKey, onValueEntered: (value) {  }, isError: false,),
            ],
          ),
      ]
    );
  }
}