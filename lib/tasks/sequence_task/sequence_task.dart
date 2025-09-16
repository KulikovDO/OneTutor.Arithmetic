import 'package:flutter/material.dart';
import 'package:one_tutor_arithmetic/tasks/sequence_task/models/sequence_assignment.dart';
import 'package:one_tutor_arithmetic/widgets/simple_text_container.dart';
import 'package:one_tutor_arithmetic/widgets/text_input_container.dart';


class SequenceTask extends StatefulWidget {
  final Function onValueEntered;
  final Function speakText;
  const SequenceTask({super.key, required this.onValueEntered, required this.speakText});

  @override
  State<SequenceTask> createState() => _SequenceTaskState();
}


class _SequenceTaskState extends State<SequenceTask> {

  late SequenceAssignment assignment;
  late GlobalKey textInputContainerKey;
  int enteredValue = -1;
  List<Widget> firstTextContainerList = [];
  List<Widget> secondTextContainerList = [];
  bool isError = false;


  bool checkAnswer() { 
    bool isAnswerCorrect = assignment.checkAnswer(enteredValue); 

    setState(() {
      isError = !isAnswerCorrect;
    });

    return isAnswerCorrect;
  }


  void handleValueEntered(int value){
    setState(() {
      enteredValue = value;
    });
    widget.onValueEntered();
  }


  initAssignment(){

    assignment = assignment.prepareTask();

    setState(() {
      enteredValue = -1;
      isError = false;
      textInputContainerKey = GlobalKey();
      firstTextContainerList.clear();
      secondTextContainerList.clear();
      bool isPopulatingFirstList = true;
      for(int option in assignment.options){

        if(option == -1){
          isPopulatingFirstList = false;
          continue;
        }

        if(isPopulatingFirstList){
          firstTextContainerList.add(SimpleTextContainer(key: GlobalKey(), text: option.toString()));
        } else {
          secondTextContainerList.add(SimpleTextContainer(key: GlobalKey(), text: option.toString()));
        }

      } 
    });

    widget.speakText(assignment.text);

  }


  @override
  initState() {

    super.initState();
    assignment = SequenceAssignment.create();
    initAssignment();
  }

  @override
  Widget build(BuildContext context) {
  
    return SizedBox(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: 
          [
            SizedBox(
              width: double.infinity,
              child: 
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: assignment.richText
                  ),
                ),
            ),
            ...firstTextContainerList,
            TextInputContainer(key: textInputContainerKey, onValueEntered: handleValueEntered, isError: isError,),
            ...secondTextContainerList,
          ]
      ),
    );
  }
}