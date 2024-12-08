import 'package:flutter/material.dart';
import 'package:one_tutor_arithmetic/data/border_kind.dart';
import 'package:one_tutor_arithmetic/widgets/text_container.dart';

class DraggableTextContainer extends StatefulWidget {
  
  final int? acceptedData;
  final String text;
  final int shouldReset;

  const DraggableTextContainer({ super.key, required this.acceptedData, required this.text, required this.shouldReset });

  
  @override
  State<DraggableTextContainer> createState() => _DraggableTextContainerState();
}

class _DraggableTextContainerState extends State<DraggableTextContainer> {

  bool isAccepted = false;
  int shouldReset = -1;

  @override
  Widget build(BuildContext context) {

    if(widget.shouldReset != shouldReset){

      setState(() {
        isAccepted = false;
        shouldReset = widget.shouldReset;  
      });
      
    }

    if(widget.acceptedData != null && int.parse(widget.text) == widget.acceptedData){
      setState(() {
        isAccepted = true;
      });
    }

    return 
      isAccepted
        ?
      TextContainer(color: Colors.grey[50] as Color, textColor: Colors.black12, text: null, borderKind: BorderKind.solid)
        :
      Draggable<int>(
        data: int.parse(widget.text),
        feedback: TextContainer(color: Colors.lightBlue[50] as Color, textColor: Colors.black, text: widget.text, borderKind: BorderKind.solid),
        childWhenDragging: TextContainer(color: Colors.grey[50] as Color, textColor: Colors.black12, text: widget.text, borderKind: BorderKind.solid),
        child: TextContainer(color: Colors.lightBlue[50] as Color, textColor: Colors.black, text: widget.text, borderKind: BorderKind.solid),

      );




  }

}