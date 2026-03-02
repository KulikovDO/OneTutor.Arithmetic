import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:one_tutor_arithmetic/tasks/subtraction_decomposition_task/data/highlight_option.dart';
import 'package:one_tutor_arithmetic/tasks/subtraction_decomposition_task/subtraction_decomposition_provider.dart';
import 'package:one_tutor_arithmetic/tasks/subtraction_decomposition_task/widgets/animated_text_container.dart';
import 'package:one_tutor_arithmetic/widgets/simple_text_container.dart';
import 'package:one_tutor_arithmetic/widgets/text_input_container.dart';

class FinalTextInputs extends ConsumerStatefulWidget {
  
  final int firstNumber;
  final int secondNumber;
  final Function speakText;
  final Function onResultOnesCopied;
  
  const FinalTextInputs({
    super.key, 
    required this.firstNumber,
    required this.secondNumber,
    required this.speakText,
    required this.onResultOnesCopied,
  });

  @override
  ConsumerState<FinalTextInputs> createState() => _FinalTextInputsState();
}

class _FinalTextInputsState extends ConsumerState<FinalTextInputs> {

  bool isErrorResultOnes = false;
  bool isErrorResultTens = false;
  bool isResultOnesAnimationCompleted = false;
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
    
    ref.read(subtractionDecompositionProvider.notifier).animate(HighlightOption.resultOnes);

  }

  handleResultOnesAnimationCompleted(){

    setState(() {
      isResultOnesAnimationCompleted = true;
    });

  }

  handleResultOnesEntered(int value) async{
    int expectedOnes = (widget.firstNumber - widget.secondNumber) % 10;
    if(value == expectedOnes){
      setState(() {
        isErrorResultOnes = false;
        isResultOnesEntered = true;
      });
      await speakTextAsync("That's correct!");
      widget.onResultOnesCopied();
    } else {
      setState(() {
        isErrorResultOnes = true;
      });
      await speakTextAsync("Please try again.");
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

              if(isResultOnesAnimationCompleted)
                TextInputContainer(key: finalResultOnesKey, onValueEntered: handleResultOnesEntered, isError: isErrorResultOnes, numberOfDigits: 1,),
              if(!isResultOnesAnimationCompleted)
                AnimatedTextContainer(text: "?", highlightOption: HighlightOption.resultOnes, onAnimationCompleted: handleResultOnesAnimationCompleted,),
            ],
          ),
      ]
    );
  }

  
}