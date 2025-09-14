import 'package:one_tutor_arithmetic/data/arithmetic_operation.dart';
import 'package:one_tutor_arithmetic/tasks/arithmetic_task/models/arithmetic_assignment.dart';
import 'package:one_tutor_arithmetic/widgets/text_input_container.dart';
import 'package:flutter/material.dart';


class ArithmeticTask extends StatefulWidget {
  final Function onValueEntered;
  final Function speakText;
  final ArithmeticOperation arithmeticOperation;
  const ArithmeticTask({super.key, required this.onValueEntered, required this.speakText, required this.arithmeticOperation});

  @override
  State<ArithmeticTask> createState() => _ArithmeticTaskState();
}

class _ArithmeticTaskState extends State<ArithmeticTask> {

  int prevFirstNumber = 0;
  int prevSecondNumber = 0;

  bool displayMainScreenIntro = true;
  late ArithmeticAssignment assignment;
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
  
  @override
  initState() {
    super.initState();
    assignment = ArithmeticAssignment.create(widget.arithmeticOperation);
    initAssignment();
  }

  initAssignment(){

    assignment = assignment.prepareTask();
    
    setState(() {
      prevFirstNumber = assignment.firstNumber;
      prevSecondNumber = assignment.secondNumber;
      enteredValue = -1;
      isError = false;
      textInputContainerKey = GlobalKey();
    });
    
    widget.speakText(assignment.text);    
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height;

    return SizedBox(
      width: double.infinity,
      child: 
        Center(
          child: Padding(
            padding: EdgeInsets.only(left: 10, right: 10, bottom: height / 3),
            child: 
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text( "${assignment.firstNumber} ${assignment.operationSymbol} ${assignment.secondNumber} = ", style:  const TextStyle( fontSize: 50, fontWeight: FontWeight.w500 )),
                  TextInputContainer(key: textInputContainerKey, onValueEntered: handleValueEntered, isError: isError,)
                ]
              ),
          ),
        ),
    );
  }
}
