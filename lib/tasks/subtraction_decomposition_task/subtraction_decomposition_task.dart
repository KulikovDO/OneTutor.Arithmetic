import 'package:flutter/material.dart';
import 'package:one_tutor_arithmetic/tasks/subtraction_decomposition_task/models/subtraction_decomposition_assignment.dart';
import 'package:one_tutor_arithmetic/widgets/text_input_container.dart';


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
  
  bool firstNumberTensError = false;
  bool firstNumberOnesError = false;
  bool secondNumberTensError = false;
  bool secondNumberOnesError = false;

  /*late*/ GlobalKey firstNumberTensKey = GlobalKey();
  /*late*/ GlobalKey firstNumberOnesKey = GlobalKey();
  /*late*/ GlobalKey secondNumberTensKey = GlobalKey();
  /*late*/ GlobalKey secondNumberOnesKey = GlobalKey();

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

  bool checkAnswer() { 
    // bool isAnswerCorrect = assignment.checkAnswer(enteredValue); 

    // setState(() {
    //   isError = !isAnswerCorrect;
    // });

    // return isAnswerCorrect;

    return true;
  }

  handleValueEntered(int value, GlobalKey key) {

    setState(() {
      switch(key) {
        case GlobalKey k when k == firstNumberTensKey:
          firstNumberTensError = (assignment.firstNumber.toString()[0] != value.toString());
        case GlobalKey k when k == firstNumberOnesKey:
          firstNumberOnesError = (assignment.firstNumber.toString()[1] != value.toString());
        case GlobalKey k when k == secondNumberTensKey:
          secondNumberTensError = (assignment.secondNumber.toString()[0] != value.toString());
        case GlobalKey k when k == secondNumberOnesKey:
          secondNumberOnesError = (assignment.secondNumber.toString()[1] != value.toString());
      }
    });

    // setState(() {
    //   enteredValue = value;
    // });
    // widget.onValueEntered();

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
        children: 
          [
            SizedBox(
              width: double.infinity,
              height: 80,
              child: 
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: assignment.richText
                  ),
                ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  width: 140,
                  child: Text(
                    "First number",
                    style: TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                ),
                TextInputContainer(key: firstNumberTensKey, onValueEntered: (value) { handleValueEntered(value, firstNumberTensKey); }, isError: firstNumberTensError,),
                TextInputContainer(key: firstNumberOnesKey, onValueEntered: (value) { handleValueEntered(value, firstNumberOnesKey); }, isError: firstNumberOnesError,),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  width: 140,
                  child: Text(
                    "Second number",
                    style: TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                ),
                TextInputContainer(key: secondNumberTensKey, onValueEntered: (value) { handleValueEntered(value, secondNumberTensKey); }, isError: secondNumberTensError,),
                TextInputContainer(key: secondNumberOnesKey, onValueEntered: (value) { handleValueEntered(value, secondNumberOnesKey); }, isError: secondNumberOnesError,),
                
              ],
            ),
          ]
      ),
    );
  }
}