import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// TODO: text input lost focus
class TextInputContainer extends StatefulWidget {
  final String text;
  final Function onValueEntered;
  final bool isError;

  const TextInputContainer({
    super.key,
    required this.text,
    required this.onValueEntered,
    required this.isError,
  });

  @override
  State<TextInputContainer> createState() => TextInputContainerState();
}

class TextInputContainerState extends State<TextInputContainer> {

  bool isTapped = false;
  FocusNode focusNode = FocusNode();
  final TextEditingController valueController = TextEditingController();

  onSubmitted(String value){

    if(value == ""){
      FocusScope.of(context).requestFocus(focusNode);
      return;
    }

    widget.onValueEntered(int.parse(value));
  }

  onTapOutside(){
    FocusScope.of(context).unfocus();
    onSubmitted(valueController.text);
  }

  onTapInside() {

    FocusScope.of(context).requestFocus(focusNode);
    
    setState(() {
      isTapped = true;
    });
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    valueController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    
    return
      Padding(
        padding: const EdgeInsets.all(4.0),
        child: TapRegion(
          onTapInside: (event) => onTapInside(),
          onTapOutside: (event) => onTapOutside(),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                width: 2, 
                color: widget.isError ? Colors.red : Colors.black,
              ),
              color: widget.isError ? const Color.fromARGB(255, 255, 230, 230) : Colors.lightBlue[50] as Color,

            ),
            height: 80.0,
            width: 80.0,
            
            child: Center(
              child: 
                !isTapped
                  ?
                Text( widget.text, style: const TextStyle(fontSize: 45, decoration: TextDecoration.none ))
                  :
                TextField(
                  controller: valueController,
                  focusNode: focusNode,
                  autofocus: true,
                  cursorHeight: 50,
                  onSubmitted: onSubmitted,
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp('[0-9]')),
                    LengthLimitingTextInputFormatter(2),
                  ],
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                  ),
                  style: const TextStyle(
                    fontSize: 45, 
                    height: 1.4,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.center,
                )
            ),
          ),
        ),
      );
  }
}