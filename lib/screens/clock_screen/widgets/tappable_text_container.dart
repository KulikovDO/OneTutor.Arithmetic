import 'package:flutter/material.dart';

class TappableTextContainer extends StatelessWidget {
  final String text;
  final String selectedText;
  final Function onTapped;

  const TappableTextContainer({
    super.key,
    required this.text,
    required this.selectedText,
    required this.onTapped,
  });

  onTapInside() => onTapped(text);

  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;
    
    return
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: TapRegion(
          onTapInside: (event) => onTapInside(),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(width: 2),
              color: (selectedText == text) ? Colors.lightBlue[200] as Color : Colors.lightBlue[50] as Color,
            ),
            height: size.width / 4,
            width: size.width / 4,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text( text, style: const TextStyle(fontSize: 45, decoration: TextDecoration.none, height: 1.0)),
                    const Text( "o'clock", style: TextStyle(fontSize: 20, decoration: TextDecoration.none, )),
                  ],
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child:
                    (selectedText == text)
                      ?
                    Icon(
                      Icons.radio_button_checked,
                      color: Colors.grey[600] as Color,
                      size: 20,
                    )
                      :
                    Icon(
                      Icons.radio_button_unchecked,
                      color: Colors.grey[600] as Color,
                      size: 20,
                    )
                ),
              ]
            )
          
          
          ),
        ),
      );
  }
}