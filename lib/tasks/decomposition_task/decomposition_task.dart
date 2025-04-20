import 'package:flutter/material.dart';
import 'package:one_tutor_arithmetic/tasks/decomposition_task/models/decomposition_assignment.dart';
import 'package:one_tutor_arithmetic/widgets/text_input_container.dart';

class DecompositionTask extends StatefulWidget {
  
  final Function onValueEntered;
  final Function speakText;
  
  const DecompositionTask({super.key, required this.onValueEntered, required this.speakText});
  
  @override
  State<DecompositionTask> createState() => DecompositionTaskState();
}


class DecompositionTaskState extends State<DecompositionTask> {

  late DecompositionAssignment assignment;
  int enteredValue = -1;
  bool isError = false;
  late GlobalKey textInputContainerKey;

  handleValueEntered(int value){
    setState(() {
      enteredValue = value;
    });
    widget.onValueEntered();
  }

  bool checkAnswer() { 
    bool isAnswerCorrect = assignment.checkAnswer(enteredValue); 

    setState(() {
      isError = !isAnswerCorrect;
    });

    return isAnswerCorrect;
  }

  
  void initAssignment() {
    assignment = assignment.prepareTask();
    setState(() {
      enteredValue = -1;
      isError = false;
      textInputContainerKey = GlobalKey();
    });
    
    widget.speakText(assignment.text);
  }
  
  @override
  void initState() {
    super.initState();
    assignment = DecompositionAssignment.create().prepareTask();

    setState(() {
      textInputContainerKey = GlobalKey();
    });
    
    widget.speakText(assignment.text);
  }

  @override
  Widget build(BuildContext context) {
  
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [

        Expanded(
          child: SizedBox(
            width: double.infinity,
            child: 
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child:
                    assignment.richText
                ),
              ),
          )
        ),

        Expanded(
          flex: 5,
          child: 
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children:[
                Text("${assignment.sum} = ${assignment.firstNumber} + ", style: const TextStyle( fontSize: 50, fontWeight: FontWeight.w500 )),
                TextInputContainer(key: textInputContainerKey, isError: isError, onValueEntered: handleValueEntered ),
              ]
            ),
        ),
      ]
    );
  }
  
}