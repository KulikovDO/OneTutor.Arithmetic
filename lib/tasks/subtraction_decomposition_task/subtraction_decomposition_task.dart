import 'package:flutter/material.dart';
import 'package:one_tutor_arithmetic/tasks/subtraction_decomposition_task/models/subtraction_decomposition_assignment.dart';


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



  initAssignment(){

    assignment = assignment.prepareTask(prevFirstNumber, prevSecondNumber);

    setState(() {
      prevFirstNumber = assignment.firstNumber;
      prevSecondNumber = assignment.secondNumber;
      
    });

    // setState(() {
    //   enteredValue = -1;
    //   isError = false;
    //   textInputContainerKey = GlobalKey();
    //   firstTextContainerList.clear();
    //   secondTextContainerList.clear();
    //   bool isPopulatingFirstList = true;
    //   for(int option in assignment.options){

    //     if(option == -1){
    //       isPopulatingFirstList = false;
    //       continue;
    //     }

    //     if(isPopulatingFirstList){
    //       firstTextContainerList.add(TextContainer(key: GlobalKey(), text: option.toString()));
    //     } else {
    //       secondTextContainerList.add(TextContainer(key: GlobalKey(), text: option.toString()));
    //     }

    //   } 
    // });

    widget.speakText(assignment.text);

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
          ]
      ),
    );
  }
}