import 'package:flutter/material.dart';
import 'package:one_tutor_arithmetic/tasks/memory_task/widgets/delay_indicator.dart';
import 'package:one_tutor_arithmetic/tasks/memory_task/widgets/text_input_row.dart';
import 'package:one_tutor_arithmetic/tasks/memory_task/models/memory_assignment.dart';
import 'package:one_tutor_arithmetic/widgets/custom_floating_action_button.dart';


class MemoryTask extends StatefulWidget {
  
  final Function onValueEntered;
  final Function speakText;
  
  const MemoryTask({super.key, required this.onValueEntered, required this.speakText});

  @override
  State<MemoryTask> createState() => _MemoryTaskState();
}


class _MemoryTaskState extends State<MemoryTask> {
  late MemoryAssignment assignment;
  
  bool displayRichText = false;
  bool displayAnimation = false;
  bool displayTextInputs = false;
  List<int> enteredValues = [];
  bool isError = false;
  late TextInputRow textInputRow;

  bool checkAnswer() { 
    bool isAnswerCorrect = assignment.checkAnswer(enteredValues); 

    setState(() {
      isError = !isAnswerCorrect;
    });

    if(!isAnswerCorrect){
      textInputRow.reset.value = true;
    }
    return isAnswerCorrect;
  }
    
  handleAnimationCompleted() {
    setState(() {
      displayAnimation = false;
      displayTextInputs = true;
    });
  }

  handleValuesEntered(List<int> values) {
    setState(() {
      enteredValues = [...values];
    });
    widget.onValueEntered();
  }

  handleRepeatTextButtonPressed() async {
    await widget.speakText(assignment.text);
  }

  initAssignment() async {

    assignment = assignment.prepareTask();
    textInputRow = TextInputRow(numberOfTextInputs: assignment.numbers.length, onCompleted: handleValuesEntered);

    setState(() { 
      displayRichText = true;
      displayTextInputs = false;
      enteredValues.clear();
      isError = false;
    });

    await widget.speakText(assignment.text);

    if (!mounted) return;
    setState(() { 

      displayRichText = false; 
      displayAnimation = true;

    });

  }

  
  
  @override
  initState() {

    super.initState();
    assignment = MemoryAssignment.create();
    initAssignment();

  }


  @override
  Widget build(BuildContext context) {
  
    return 
      Stack(
          children: [

            if(displayRichText)
            Center(
              child: assignment.richText
            ),

            if(displayTextInputs)
              Padding(
                padding: const EdgeInsets.only(top: 100),
                child: 
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomFloatingActionButton(
                      isDisabled: false,
                      onPressed: handleRepeatTextButtonPressed,
                      child: const Icon(
                        Icons.replay,
                        color: Colors.black,
                        size: 40,
                      ),   
                    ),
                  ],
                ),
              ),

            if(displayAnimation)
              Center(
                child: DelayIndicator( onCompleted: handleAnimationCompleted, repeatTimes: 5, )
              ),
          
            if(displayTextInputs)
              Center(
                child: textInputRow,
              ),
          ]
      );
    }  
  
}