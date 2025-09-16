import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextInputContainer extends StatefulWidget {
  final Function onValueEntered;
  final bool isError;
  final int? numberOfDigits;

  const TextInputContainer({
    super.key,
    required this.onValueEntered,
    required this.isError,
    this.numberOfDigits,
  });

  @override
  State<TextInputContainer> createState() => TextInputContainerState();
}

class TextInputContainerState extends State<TextInputContainer> {

  bool isTapped = false;
  //FocusNode focusNode = FocusNode();
  final TextEditingController valueController = TextEditingController();

  handleSubmitted(String value){

    if(value == ""){
      // FocusScope.of(context).requestFocus(focusNode);
      return;
    }

    widget.onValueEntered(int.parse(value));

  }

  handleFocusChange(bool hasFocus) {
    setState(() {
      isTapped = hasFocus;
    });

    if(!hasFocus){
      FocusManager.instance.primaryFocus?.unfocus();
      handleSubmitted(valueController.text);
    }
  }

  handleTapOutside() {
    FocusManager.instance.primaryFocus?.unfocus();
    handleSubmitted(valueController.text);
  }

  void handleValueChanged(String value) {
  
    if(widget.numberOfDigits != null && value.length >= widget.numberOfDigits!){
      FocusManager.instance.primaryFocus?.unfocus();
      handleSubmitted(value);
    }

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
                Focus(
                  onFocusChange: handleFocusChange,
                  child: TextField(
                    controller: valueController,
                    onChanged: handleValueChanged,
                    onTapOutside: (event) => handleTapOutside(),
                    cursorHeight: 50,
                    onSubmitted: handleSubmitted,
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp('[0-9]')),
                      LengthLimitingTextInputFormatter(2),
                    ],
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      hintText: "?",
                      hintStyle: TextStyle(
                        fontSize: 45,
                        color: isTapped ? Colors.grey.withOpacity(0) : Colors.black.withOpacity(0.7),
                      ),
                    ),
                    style: const TextStyle(
                      fontSize: 45, 
                      height: 1.4,
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.center,
                  ),
                )
            ),
          ),
      );
  }

  
}