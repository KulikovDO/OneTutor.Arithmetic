import 'package:flutter/material.dart';
import 'package:one_tutor_arithmetic/widgets/draggable_text_container.dart';
import 'package:one_tutor_arithmetic/widgets/droppable_text_container.dart';

class DragAndDroppableTextContainer extends StatefulWidget {
  
  final Function? onAccepted;
  final int shouldReset;
  final int? acceptedData;
  final String? text;
  final bool isDraggable;
  
  const DragAndDroppableTextContainer({super.key, required this.onAccepted, required this.shouldReset, required this.acceptedData, required this.text, required this.isDraggable});
 

  @override
  State<DragAndDroppableTextContainer> createState() => DragAndDroppableTextContainerState();
}

class DragAndDroppableTextContainerState extends State<DragAndDroppableTextContainer> {

  @override
  Widget build(BuildContext context) {
    return
      widget.isDraggable
        ?
      DraggableTextContainer(acceptedData: widget.acceptedData, text: widget.text!, shouldReset: widget.shouldReset,)
        :
      DroppableTextContainer(key: widget.key, onAccepted: widget.onAccepted!, shouldReset: widget.shouldReset,)
    ;
  }

}