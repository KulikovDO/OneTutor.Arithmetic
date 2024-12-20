import 'package:flutter/material.dart';
import 'package:one_tutor_arithmetic/screens/pebble_division_screen/widgets/bucket.dart';
import 'package:one_tutor_arithmetic/screens/pebble_division_screen/widgets/draggable_pebble.dart';

class DroppableBucket extends StatefulWidget {

  final Function onAccepted;

  const DroppableBucket({
    super.key,
    required this.onAccepted,
  });

  @override
  State<DroppableBucket> createState() => _DroppableBucketState();
}

class _DroppableBucketState extends State<DroppableBucket> {

  List<DraggablePebble> draggablePebbles = [];

  handleOnAccepted(DraggablePebble draggablePebble){

    widget.onAccepted(draggablePebble);
    draggablePebbles.add(draggablePebble);

  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return 
      DragTarget<DraggablePebble>(
        builder: (
          BuildContext context,
          List<dynamic> accepted,
          List<dynamic> rejected,
        ) {
          return Bucket(draggablePebbles: draggablePebbles);
        },
        onAcceptWithDetails: (DragTargetDetails details) {
          // widget.onAccepted(details.data);
          handleOnAccepted(details.data);
        },
      );
  }

}