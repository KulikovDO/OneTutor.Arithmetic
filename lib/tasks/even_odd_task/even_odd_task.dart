
import 'package:flutter/material.dart';
import 'package:one_tutor_arithmetic/tasks/even_odd_task/models/even_odd_assignment.dart';
import 'package:one_tutor_arithmetic/tasks/even_odd_task/widgets/tappable_text_contrainer.dart';


class EvenOddTask extends StatefulWidget {
  final Function onValueEntered;
  final Function speakText;
  const EvenOddTask({super.key, required this.onValueEntered, required this.speakText});

  @override
  State<EvenOddTask> createState() => _EvenOddTaskState();
}


class _EvenOddTaskState extends State<EvenOddTask> {

  late EvenOddAssignment assignment;  
  List<String> selectedNumbers = [];
  List<Widget> tappableTextContainerList = [];
  bool isError = false;

  bool checkAnswer() { 
    bool isAnswerCorrect = assignment.checkAnswer(selectedNumbers); 

    setState(() {
      isError = !isAnswerCorrect;
    });

    return isAnswerCorrect;
  }

  onTapped(String number, bool isSelected){
    
    if(isSelected){
      selectedNumbers.add(number);
    } else {
      selectedNumbers.removeWhere((item) => item == number);
    }

    if(selectedNumbers.isNotEmpty){
      widget.onValueEntered();
    } 

  }


  initAssignment() {

    assignment = assignment.prepareTask();

    setState(() {
      isError = false;
      selectedNumbers.clear();
      tappableTextContainerList.clear();

      for(String number in assignment.numbers){
        tappableTextContainerList.add(TappableTextContainer(key: GlobalKey(), text: number, onTapped: onTapped,));
      }  
    });

    widget.speakText(assignment.text);

  }

  

  @override
  initState() {

    super.initState();
    assignment = EvenOddAssignment.create();
    initAssignment();

    

  }

  @override
  Widget build(BuildContext context) {
  
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

          Expanded(
            child: SizedBox(
              width: double.infinity,
              child: 
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: assignment.richText

                  ),
                ),
            )
          ),

          Expanded(
            flex: 5,
            child: 
              Wrap(
                spacing: 20,
                runSpacing: 20,
                children: tappableTextContainerList,
              )
          ),
        ]
      );

  }
}