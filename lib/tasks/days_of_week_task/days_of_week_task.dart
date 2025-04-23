import 'package:flutter/material.dart';
import 'package:one_tutor_arithmetic/tasks/days_of_week_task/models/days_of_week_assignment.dart';
import 'package:one_tutor_arithmetic/widgets/tappable_text_container.dart';

class DaysOfWeekTask extends StatefulWidget {
  final Function onValueEntered;
  final Function speakText;
  const DaysOfWeekTask({super.key, required this.onValueEntered, required this.speakText});

  @override
  State<DaysOfWeekTask> createState() => _DaysOfWeekTaskState();
}


class _DaysOfWeekTaskState extends State<DaysOfWeekTask> {

  late DaysOfWeekAssignment assignment;
  String enteredValue = "";
  bool isError = false;

  bool checkAnswer() { 
    bool isAnswerCorrect = assignment.checkAnswer(enteredValue); 

    setState(() {
      isError = !isAnswerCorrect;
    });

    return isAnswerCorrect;
  }

  onTapped(String dayOfWeek){
    
    setState(() {
      enteredValue = dayOfWeek;
    });
    widget.onValueEntered();

  }

  @override
  initState() {

    super.initState();
    assignment = DaysOfWeekAssignment.create();
    initAssignment();

  }

  initAssignment(){

    setState(() {
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
      crossAxisAlignment: CrossAxisAlignment.center,
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
              Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children:[
                TappableTextContainer(key: GlobalKey(), mainText: assignment.answerOptions[0].toString(), additionalText: "", selectedText: enteredValue, isFullWidth: true, onTapped: onTapped,),
                TappableTextContainer(key: GlobalKey(), mainText: assignment.answerOptions[1].toString(), additionalText: "", selectedText: enteredValue, isFullWidth: true, onTapped: onTapped,),
                TappableTextContainer(key: GlobalKey(), mainText: assignment.answerOptions[2].toString(), additionalText: "", selectedText: enteredValue, isFullWidth: true, onTapped: onTapped,),
              ]
            ),
        ),
      ]
    );
  }
}