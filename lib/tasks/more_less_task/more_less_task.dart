import 'package:flutter/material.dart';
import 'package:one_tutor_arithmetic/tasks/more_less_task/models/more_less_assignment.dart';
import 'package:one_tutor_arithmetic/widgets/tappable_text_container.dart';


class MoreLessTask extends StatefulWidget {
  final Function onValueEntered;
  final Function speakText;
  const MoreLessTask({super.key, required this.onValueEntered, required this.speakText});

  @override
  State<MoreLessTask> createState() => _MoreLessTaskState();
}


class _MoreLessTaskState extends State<MoreLessTask> {

  late MoreLessAssignment assignment;
  List<Widget> tappableTextContainerList = [];
  String enteredValue = "";
  bool isError = false;
  
  bool checkAnswer() { 
    bool isAnswerCorrect = assignment.checkAnswer(enteredValue); 

    setState(() {
      isError = !isAnswerCorrect;
    });

    return isAnswerCorrect;
  }

  onTapped(String number){
    
    setState(() {
      enteredValue = number;
    });

    widget.onValueEntered();

  }

  @override
  initState() {

    super.initState();
    assignment = MoreLessAssignment.create();
    initAssignment();

  }

  initAssignment() {

    setState(() {
      tappableTextContainerList.clear();
      enteredValue = "";
      isError = false;  
    });
    

    assignment = assignment.prepareTask();
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
                TappableTextContainer(key: GlobalKey(), mainText: assignment.answerOptions[0].toString(), additionalText: "", selectedText: enteredValue, isFullWidth: false, onTapped: onTapped,),
                TappableTextContainer(key: GlobalKey(), mainText: assignment.answerOptions[1].toString(), additionalText: "", selectedText: enteredValue, isFullWidth: false, onTapped: onTapped,),
                TappableTextContainer(key: GlobalKey(), mainText: assignment.answerOptions[2].toString(), additionalText: "", selectedText: enteredValue, isFullWidth: false, onTapped: onTapped,),
              ]
            ),
        ),
      ]
    );
  }
}