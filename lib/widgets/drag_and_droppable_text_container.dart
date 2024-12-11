import 'package:flutter/material.dart';
import 'package:one_tutor_arithmetic/widgets/draggable_text_container.dart';
import 'package:one_tutor_arithmetic/widgets/droppable_text_container.dart';

class DragAndDroppableTextContainer extends StatefulWidget {
  
  final Function onAccepted;
  final int? acceptedData;
  final String? text;
  final bool isDraggable;
  
  const DragAndDroppableTextContainer({super.key, required this.onAccepted, required this.acceptedData, required this.text, required this.isDraggable});
 

  @override
  State<DragAndDroppableTextContainer> createState() => DragAndDroppableTextContainerState();
}

class DragAndDroppableTextContainerState extends State<DragAndDroppableTextContainer> {

  bool isDraggable = false;
  String? text = "";

  @override
  void initState() {
    super.initState();
    isDraggable = widget.isDraggable;
    text = widget.text;
  }

  _onDragCompleted(){

    setState(() {
      text = null;
      isDraggable = false;
    });
    
  }
  
  
  _onAccepted(int data){

    setState(() {
      isDraggable = true;
      text = data.toString();
    });

    widget.onAccepted(data);
  }

  @override
  Widget build(BuildContext context) {

    return
      isDraggable
        ?
      DraggableTextContainer(acceptedData: widget.acceptedData, text: text!, onDragCompleted: _onDragCompleted,)
        :
      DroppableTextContainer(onAccepted: _onAccepted)
    ;
  }

}