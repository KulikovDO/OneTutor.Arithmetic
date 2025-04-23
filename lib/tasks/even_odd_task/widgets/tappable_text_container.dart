import 'package:flutter/material.dart';

class TappableTextContainer extends StatefulWidget {
  final String text;
  final Function onTapped;
  final bool isError;
  final bool isTapped;

  const TappableTextContainer({
    super.key,
    required this.text,
    required this.onTapped,
    required this.isError,
    required this.isTapped,
  });

  @override
  State<TappableTextContainer> createState() => _TappableTextContainerState();
}

class _TappableTextContainerState extends State<TappableTextContainer> {

  bool isSelected = false;
  
  onTapInside() {
    widget.onTapped(widget.text, !isSelected);
    setState(() {
      isSelected = !isSelected;
    });
  }

  @override
  void initState() {
    isSelected = widget.isTapped;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;
    Color backgroundColor;
    if(widget.isError){
      backgroundColor = isSelected ? Colors.red[200] as Color : const Color.fromARGB(255, 255, 230, 230);
    } else {
      backgroundColor = isSelected ? Colors.lightBlue[200] as Color : Colors.lightBlue[50] as Color;
    }
    
    return
      TapRegion(
        onTapInside: (event) => onTapInside(),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
                width: 2, 
                color: widget.isError ? Colors.red : Colors.black,
              ),
            color: backgroundColor,
          ),
          height: size.width / 3,
          width: size.width / 3,
          
          child: Stack(
            alignment: Alignment.center,
            children: [
              Text( widget.text, style: const TextStyle(fontSize: 45, decoration: TextDecoration.none )),
              Align(
                alignment: Alignment.topLeft,
                child: Checkbox(value: isSelected, onChanged: null),
              ),
            ]
          )
        
        
        ),
      );
  }
}