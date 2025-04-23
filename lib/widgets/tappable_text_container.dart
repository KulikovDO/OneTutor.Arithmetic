import 'package:flutter/material.dart';

class TappableTextContainer extends StatelessWidget {
  final String mainText;
  final String additionalText;
  final String selectedText;
  final bool isFullWidth;
  final Function onTapped;

  const TappableTextContainer({
    super.key,
    required this.mainText,
    required this.additionalText,
    required this.selectedText,
    required this.isFullWidth,
    required this.onTapped,
  });

  onTapInside() => onTapped(mainText);

  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;
    double mainTextFontSize = isFullWidth ? size.width / 18 : 45;
    
    return
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: TapRegion(
          onTapInside: (event) => onTapInside(),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(width: 2),
              color: (selectedText == mainText) ? Colors.lightBlue[200] as Color : Colors.lightBlue[50] as Color,
            ),
            height: isFullWidth ? 0.2 * size.width : size.width / 4,
            width: isFullWidth ? 0.75 * size.width : size.width / 4,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text( mainText, style: TextStyle(fontSize: mainTextFontSize, decoration: TextDecoration.none, height: 1.0)),
                    if(additionalText != "")
                      Text( additionalText, style: const TextStyle(fontSize: 20, decoration: TextDecoration.none, )),
                  ],
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child:
                    (selectedText == mainText)
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