import 'package:flutter/material.dart';
import 'package:one_tutor_arithmetic/data/border_kind.dart';
import 'package:one_tutor_arithmetic/widgets/text_container.dart';

class DraggableTextContainer extends StatefulWidget {
  
  final int? acceptedData;
  final String text;
  final Function onDragCompleted;

  const DraggableTextContainer({ super.key, required this.acceptedData, required this.text, required this.onDragCompleted });

  
  @override
  State<DraggableTextContainer> createState() => _DraggableTextContainerState();
}

class _DraggableTextContainerState extends State<DraggableTextContainer> {

  @override
  Widget build(BuildContext context) {

    return 
      Draggable<int>(
        data: int.parse(widget.text),
        feedback: TextContainer(color: Colors.lightBlue[50] as Color, textColor: Colors.black, text: widget.text, borderKind: BorderKind.solid),
        childWhenDragging: TextContainer(color: Colors.grey[50] as Color, textColor: Colors.black12, text: widget.text, borderKind: BorderKind.solid),
        onDragCompleted: (){ 
          widget.onDragCompleted();
        },
        child: TextContainer(color: Colors.lightBlue[50] as Color, textColor: Colors.black, text: widget.text, borderKind: BorderKind.solid),
      );

  }

}