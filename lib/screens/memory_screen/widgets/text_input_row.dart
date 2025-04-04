import 'package:flutter/material.dart';
import 'package:one_tutor_arithmetic/widgets/text_input_container.dart';

class TextInputRow extends StatefulWidget {
  
  final int numberOfTextInputs;
  final Function onCompleted;

  const TextInputRow({
    super.key, 
    required this.numberOfTextInputs,
    required this.onCompleted,
  });

  @override
  State<TextInputRow> createState() => _TextInputRowState();

}

class _TextInputRowState extends State<TextInputRow> with SingleTickerProviderStateMixin {

  List<TextInputContainer> textInputContainers = [];
  List<GlobalKey<TextInputContainerState>> textInputKeys = [];
  List<int> enteredValues = [];

  handleValueEntered(int value, int index) {
    print("*****handleValueEntered*****");
    print(value);
    print(index);
    
    
    enteredValues[index] = value;

    print(enteredValues);
    print("*****handleValueEntered*****");

    if(!enteredValues.contains(-1)){
      widget.onCompleted(enteredValues);
    }
  }

  @override
  void initState() {
    super.initState();

    enteredValues.clear();

    textInputKeys.clear();

    for(int i = 0; i < widget.numberOfTextInputs; i++){
      textInputKeys.add(GlobalKey());
      enteredValues.add(-1);
    }

    textInputContainers = List.generate( widget.numberOfTextInputs,(index) => 
      TextInputContainer(key: textInputKeys[index], isError: false, text: "?", onValueEntered: (value) { handleValueEntered(value, index); } )
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