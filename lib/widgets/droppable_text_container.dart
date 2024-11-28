import 'package:flutter/material.dart';
import 'package:one_tutor_arithmetic/data/border_kind.dart';
import 'package:one_tutor_arithmetic/widgets/text_container.dart';

class DroppableTextContainer extends StatefulWidget {
  
  final Function onAccepted;
  final int shouldReset;
  
  const DroppableTextContainer({super.key, required this.onAccepted, required this.shouldReset});
 

  @override
  State<DroppableTextContainer> createState() => DroppableTextContainerState();
}

class DroppableTextContainerState extends State<DroppableTextContainer> {

  int? acceptedData;
  int shouldReset = -1;

  @override
  Widget build(BuildContext context) {

    if(widget.shouldReset != shouldReset){
      acceptedData = null;
      
      setState(() {
        shouldReset = widget.shouldReset;  
      });
      
    }

    return 
      acceptedData != null 
        ? 
      TextContainer(text: acceptedData.toString(), color: Colors.lightBlue[50] as Color, textColor: Colors.black, borderKind: BorderKind.solid) 
        :
      DragTarget<int>(
        builder: (
          BuildContext context,
          List<dynamic> accepted,
          List<dynamic> rejected,
        ) {
          return TextContainer(
            text: null, 
            color: Colors.lightBlue[50] as Color, 
            textColor: accepted.isNotEmpty ? Colors.black : Colors.grey, // hovering effect
            borderKind: BorderKind.dotted
          );
        },
        onAcceptWithDetails: (DragTargetDetails<int> details) {
          setState(() {
            acceptedData = details.data;
            widget.onAccepted(details.data);
          });
        },
      );

  }

}