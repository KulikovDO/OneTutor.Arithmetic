import 'package:flutter/material.dart';
import 'package:one_tutor_arithmetic/widgets/text_input_container.dart';

class TextInputRow extends StatefulWidget {
  
  final int numberOfTextInputs;
  final Function onCompleted;

  TextInputRow({
    super.key, 
    required this.numberOfTextInputs,
    required this.onCompleted,
  });

  final ValueNotifier reset = ValueNotifier(false);

  @override
  State<TextInputRow> createState() => _TextInputRowState();

}

class _TextInputRowState extends State<TextInputRow> with SingleTickerProviderStateMixin {

  List<TextInputContainer> textInputContainers = [];
  List<int> enteredValues = [];

  handleValueEntered(int value, int index) {
    enteredValues[index] = value;

    if(!enteredValues.contains(-1)){
      widget.onCompleted(enteredValues);
    }
  }

  @override
  void initState() {

    widget.reset.addListener(() {
     
      setState(() {
        textInputContainers = List.generate( widget.numberOfTextInputs,(index) => 
          TextInputContainer(isError: true, onValueEntered: (value) { handleValueEntered(value, index); } )
        );  
      });

    });

    super.initState();

    enteredValues.clear();

    for(int i = 0; i < widget.numberOfTextInputs; i++){
      enteredValues.add(-1);
    }

    textInputContainers = List.generate( widget.numberOfTextInputs,(index) => 
      TextInputContainer(isError: false, onValueEntered: (value) { handleValueEntered(value, index); } )
    );
  }

  @override
  Widget build(BuildContext context) {

    return 
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: 
          textInputContainers,
      );
  }

  
}