import 'package:flutter/material.dart';
import 'package:one_tutor_arithmetic/tasks/subtraction_decomposition_task/models/subtraction_decomposition_assignment.dart';
import 'package:one_tutor_arithmetic/tasks/subtraction_decomposition_task/widgets/initial_text_inputs.dart';
import 'package:one_tutor_arithmetic/tasks/subtraction_decomposition_task/widgets/subtract_ones.dart';


class SubtractionDecompositionTask extends StatefulWidget {
  final Function onValueEntered;
  final Function speakText;
  const SubtractionDecompositionTask({super.key, required this.onValueEntered, required this.speakText});

  @override
  State<SubtractionDecompositionTask> createState() => _SubtractionDecompositionTaskState();
}


class _SubtractionDecompositionTaskState extends State<SubtractionDecompositionTask> {

  late SubtractionDecompositionAssignment assignment;
  int prevFirstNumber = 0;
  int prevSecondNumber = 0;
  bool displayInitialTextInputs = false;
  bool displaySubtractOnes = false;

  initAssignment() async{

    assignment = assignment.prepareTask(prevFirstNumber, prevSecondNumber);

    setState(() {
      prevFirstNumber = assignment.firstNumber;
      prevSecondNumber = assignment.secondNumber;
    });


    await widget.speakText(assignment.text);

    if (!mounted) return;

    setState(() { 
      displayInitialTextInputs = true;
    });

  }

  bool checkAnswer() { 
    // bool isAnswerCorrect = assignment.checkAnswer(enteredValue); 

    // setState(() {
    //   isError = !isAnswerCorrect;
    // });

    // return isAnswerCorrect;

    return true;
  }

  handleInitialValuesEntered(){
    setState(() {
      displaySubtractOnes = true;
    });
  }

  @override
  initState() {

    super.initState();
    assignment = SubtractionDecompositionAssignment.create();
    initAssignment();
  }

  @override
  Widget build(BuildContext context) {
  
    return SizedBox(
      width: double.infinity,
      child: Column(
        children: 
          [
            SizedBox(
              width: double.infinity,
              height: 80,
              child: 
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: assignment.richText
                  ),
                ),
            ),

            if(displayInitialTextInputs)
              InitialTextInputs(firstNumber: assignment.firstNumber, secondNumber: assignment.secondNumber, onValuesEntered: handleInitialValuesEntered, speakText: widget.speakText,),

            if(displaySubtractOnes)
              SubtractOnes(firstNumber: assignment.firstNumber, secondNumber: assignment.secondNumber, speakText: widget.speakText,)
          ]
      ),
    );
  }
}