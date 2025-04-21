import 'package:flutter/material.dart';
import 'package:one_tutor_arithmetic/data/border_kind.dart';
import 'package:one_tutor_arithmetic/widgets/text_container.dart';

class DroppableTextContainer extends StatefulWidget {
  
  final Function onAccepted;
  const DroppableTextContainer({super.key, required this.onAccepted});

  @override
  State<DroppableTextContainer> createState() => DroppableTextContainerState();
}

class DroppableTextContainerState extends State<DroppableTextContainer> {

  @override
  Widget build(BuildContext context) {

    return 
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
            widget.onAccepted(details.data);
        },
      );

  }

}