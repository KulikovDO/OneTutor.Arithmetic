import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:one_tutor_arithmetic/tasks/grouping_task/models/grouping_assignment.dart';
import 'package:one_tutor_arithmetic/widgets/text_input_container.dart';
import 'package:one_tutor_arithmetic/tasks/grouping_task/widgets/touch_control.dart';


class GroupingTask extends StatefulWidget {
  final Function onValueEntered;
  final Function speakText;
  const GroupingTask({super.key, required this.onValueEntered, required this.speakText});

  @override
  State<GroupingTask> createState() => _GroupingTaskState();
}


class _GroupingTaskState extends State<GroupingTask> {

  late GroupingAssignment assignment;
  late TouchControl touchControl;
  int enteredValue = 0;
  bool isError = false;
  late GlobalKey textInputContainerKey;

  @override
  initState() {

    super.initState();
    assignment = GroupingAssignment.create();
    initAssignment();

  }

  bool checkAnswer() { 
    bool isAnswerCorrect = assignment.checkAnswer(enteredValue); 

    setState(() {
      isError = !isAnswerCorrect;
    });

    return isAnswerCorrect;
  }

  initAssignment(){

    FlutterView view = PlatformDispatcher.instance.views.first;
    double screenWidth = view.physicalSize.width / view.devicePixelRatio;

    assignment = assignment.prepareTask(screenWidth);
    
    setState(() {
      enteredValue = -1;
      isError = false;
      textInputContainerKey = GlobalKey();  
      touchControl = TouchControl(key: GlobalKey(), assignment: assignment,);
    });
    widget.speakText(assignment.text);
  }

  void handleValueEntered(int value) {

    setState(() {
      enteredValue = value;
    });

    widget.onValueEntered();

  }


  @override
  Widget build(BuildContext context) {
  
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [

        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child:
                assignment.richText
            ),
          ),
        ),

        touchControl,

        const SizedBox(height: 30,),

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text( "Number of groups: ", style: TextStyle( fontSize: 25, fontWeight: FontWeight.w500 )),
            TextInputContainer(key: textInputContainerKey, onValueEntered: handleValueEntered,isError: isError),
          ]
        ),
      ]
    );

  }

}