import 'package:flutter/material.dart';
import 'package:one_tutor_arithmetic/tasks/models/decomposition_assignment.dart';
import 'package:one_tutor_arithmetic/widgets/text_input_container.dart';

class DecompositionTask extends StatefulWidget {
  const DecompositionTask({super.key});
  
  @override
  State<DecompositionTask> createState() => _DecompositionTaskState();
}


class _DecompositionTaskState extends State<DecompositionTask> {

  late DecompositionAssignment assignment;
  int enteredValue = -1;
  bool isError = false;
  bool isSubmitDisabled = true;
  late GlobalKey textInputContainerKey;

  handleValueEntered(int value){
    setState(() {
      enteredValue = value;
      isSubmitDisabled = false;
    });
  }

  handleSubmit() async {

    

  }


  
  @override
  void initState() {
    super.initState();
    assignment = DecompositionAssignment.create().prepareTask();
    // init();
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
                Text("${assignment.sum} = ${assignment.firstNumber} + ", style: const TextStyle( fontSize: 50, fontWeight: FontWeight.w500 )),
                TextInputContainer(key: textInputContainerKey, isError: isError, onValueEntered: handleValueEntered ),
              ]
            ),
        ),
      ]
    );
  }
}