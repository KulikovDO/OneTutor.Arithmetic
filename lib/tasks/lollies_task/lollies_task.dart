import 'package:flutter/material.dart';
import 'package:one_tutor_arithmetic/tasks/lollies_task/models/lollies_assignment.dart';
import 'package:one_tutor_arithmetic/tasks/lollies_task/widgets/jelly_bean.dart';
import 'package:one_tutor_arithmetic/widgets/tappable_text_container.dart';


class LolliesTask extends StatefulWidget {
  final Function onValueEntered;
  final Function speakText;
  const LolliesTask({super.key, required this.onValueEntered, required this.speakText});


  @override
  State<LolliesTask> createState() => _LolliesTaskState();
}


class _LolliesTaskState extends State<LolliesTask> {

  List<JellyBean> jellybeans = [];
  late LolliesAssignment assignment;
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
    assignment = LolliesAssignment.create();
    initAssignment();

  }

  initAssignment(){

    assignment = assignment.prepareTask();
    

    setState(() {
      enteredValue = "";
      isError = false;
      jellybeans.clear();

      for(int i = 0; i < assignment.lolliesAmount; i++){
        jellybeans.add(const JellyBean());
      }
      
    });

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
          flex: 4,
          child: 
            Center(
              child: Wrap(
                spacing: 5,
                runSpacing: 5,
                children: 
                  jellybeans
                ,
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
                TappableTextContainer(key: GlobalKey(), mainText: assignment.answerOptions[0].toString(), additionalText: "", selectedText: enteredValue, isFullWidth: false, isError: isError, onTapped: onTapped,),
                TappableTextContainer(key: GlobalKey(), mainText: assignment.answerOptions[1].toString(), additionalText: "", selectedText: enteredValue, isFullWidth: false, isError: isError, onTapped: onTapped,),
                TappableTextContainer(key: GlobalKey(), mainText: assignment.answerOptions[2].toString(), additionalText: "", selectedText: enteredValue, isFullWidth: false, isError: isError, onTapped: onTapped,),
              ]
            ),
        ),
      ]
    );

  }
}