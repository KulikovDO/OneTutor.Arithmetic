import 'package:flutter/material.dart';

class TappableTextContainer extends StatefulWidget {
  final String text;
  final Function onTapped;

  const TappableTextContainer({
    super.key,
    required this.text,
    required this.onTapped,
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
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;
    
    return
      TapRegion(
        onTapInside: (event) => onTapInside(),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(width: 2),
            color: isSelected ? Colors.lightBlue[200] as Color : Colors.lightBlue[50] as Color,
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