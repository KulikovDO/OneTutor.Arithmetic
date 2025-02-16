import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextInputContainer extends StatefulWidget {
  final Function onValueEntered;

  const TextInputContainer({
    super.key,
    required this.onValueEntered
  });

  @override
  State<TextInputContainer> createState() => _TextInputContainerState();
}

class _TextInputContainerState extends State<TextInputContainer> {

  bool isTapped = false;
  FocusNode focusNode = FocusNode();

  onSubmitted(String value){

    if(value == ""){
      FocusScope.of(context).requestFocus(focusNode);
      return;
    }

    widget.onValueEntered(int.parse(value));
  }

  onTapInside() {
    setState(() {
      isTapped = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    
    return
      Padding(
        padding: const EdgeInsets.all(4.0),
        child: TapRegion(
          onTapInside: (event) => onTapInside(),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(width: 2),
              color: Colors.lightBlue[50] as Color,
            ),
            height: 80.0,
            width: 80.0,
            child: 
              TextField(
                focusNode: focusNode,
                cursorHeight: 50,
                autofocus: true,
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
                style: const TextStyle(fontSize: 45, height: 1.4),
                textAlign: TextAlign.center,
              )
          ),
        ),
      );
  }
}