import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:one_tutor_arithmetic/tasks/subtraction_decomposition_task/widgets/enter_ones.dart';
import 'package:one_tutor_arithmetic/tasks/subtraction_decomposition_task/widgets/subtract_ones_result.dart';
import 'package:one_tutor_arithmetic/tasks/subtraction_decomposition_task/widgets/first_number_ones_decomposition.dart';
import 'package:one_tutor_arithmetic/tasks/subtraction_decomposition_task/widgets/second_number_ones_decomposition.dart';


class SubtractOnes extends ConsumerStatefulWidget {
  
  final int firstNumber;
  final int secondNumber;
  // final Function onResultEntered;
  final Function speakText;
  
  const SubtractOnes({
    super.key, 
    required this.firstNumber,
    required this.secondNumber,
    // required this.onResultEntered
    required this.speakText,
  });

  @override
  ConsumerState<SubtractOnes> createState() => _SubtractOnesState();
}


class _SubtractOnesState extends ConsumerState<SubtractOnes> {

  bool isOnesEntered = false;
  bool isOnesResultEntered = false;
  bool isFirstNumberDecompositionComplete = false;
  bool isSecondNumberDecompositionComplete = false;

  
  GlobalKey enterOnesKey = GlobalKey();
  GlobalKey firstNumberOnesDecompositionKey = GlobalKey();
  GlobalKey secondNumberOnesDecompositionKey = GlobalKey();

  
  speakTextAsync(String text) async => await widget.speakText(text);
  

  handleResultOnesEntered() { 
    setState(() {
      isOnesResultEntered = true;
    });
  }


  handleOnesEntered(){
    setState(() {
      isOnesEntered = true;
    });
  }

  handleFirstNumberDecompositionComplete(){
    setState(() {
      isFirstNumberDecompositionComplete = true;
    });
  }

  handleSecondNumberDecompositionComplete() async {
    
    setState(() {
      isSecondNumberDecompositionComplete = true;
    });

  }


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
        
        EnterOnes(key: enterOnesKey, firstNumber: widget.firstNumber, secondNumber: widget.secondNumber, onResultEntered: handleOnesEntered, speakText: widget.speakText,),

        if(isOnesEntered && !isOnesResultEntered)
          FirstNumberOnesDecomposition(key: firstNumberOnesDecompositionKey, firstNumber: widget.firstNumber, onResultEntered: handleFirstNumberDecompositionComplete, speakText: widget.speakText,),

        if(isFirstNumberDecompositionComplete && !isOnesResultEntered)
          SecondNumberOnesDecomposition(key: secondNumberOnesDecompositionKey, firstNumber: widget.firstNumber, secondNumber: widget.secondNumber, onResultEntered: handleSecondNumberDecompositionComplete, speakText: widget.speakText,),

        if(isSecondNumberDecompositionComplete && !isOnesResultEntered)
          SubtractOnesResult(key: GlobalKey(), firstNumber: widget.firstNumber, secondNumber: widget.secondNumber, onResultEntered: handleResultOnesEntered, speakText: widget.speakText,),

      ],
    );
  }

  
}