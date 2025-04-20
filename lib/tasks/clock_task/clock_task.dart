import 'package:flutter/material.dart';
import 'package:one_tutor_arithmetic/tasks/clock_task/models/clock_assignment.dart';
import 'package:one_tutor_arithmetic/tasks/clock_task/widgets/clock.dart';
import 'package:one_tutor_arithmetic/tasks/coins_task/widgets/tappable_text_container.dart';


class ClockTask extends StatefulWidget {
  final Function onValueEntered;
  final Function speakText;
  
  const ClockTask({super.key, required this.onValueEntered, required this.speakText});

  @override
  State<ClockTask> createState() => _ClockTaskState();
}


class _ClockTaskState extends State<ClockTask> {

  late ClockAssignment assignment;

  String enteredValue = "";
  bool isError = false;
  

  @override
  initState() {

    super.initState();
    assignment = ClockAssignment.create();
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

  handleTapped(String number){
    
    setState(() {
      enteredValue = number;
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
          flex: 4,
          child: 
            Center(child: Clock(width: 300.0, hour: assignment.hour))
        ),

        Expanded(
          flex: 5,
          child: 
              Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children:[
                TappableTextContainer(key: GlobalKey(), text: assignment.answerOptions[0].toString(), selectedText: enteredValue, onTapped: handleTapped,),
                TappableTextContainer(key: GlobalKey(), text: assignment.answerOptions[1].toString(), selectedText: enteredValue, onTapped: handleTapped,),
                TappableTextContainer(key: GlobalKey(), text: assignment.answerOptions[2].toString(), selectedText: enteredValue, onTapped: handleTapped,),
              ]
            ),
        ),
      ]
    );
  }

}