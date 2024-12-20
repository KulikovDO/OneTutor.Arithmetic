import 'package:flutter/material.dart';
import 'package:one_tutor_arithmetic/screens/pebble_division_screen/widgets/bucket.dart';

class DroppableBucket extends StatefulWidget {

  const DroppableBucket({
    super.key 
  });

  @override
  State<DroppableBucket> createState() => _DroppableBucketState();
}

class _DroppableBucketState extends State<DroppableBucket> {

  List<int> colors = [];

  handleOnAccepted(int colorIndex){

    setState(() {
      colors.add(colorIndex);
    });

  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return 
      DragTarget<int>(
        builder: (
          BuildContext context,
          List<dynamic> accepted,
          List<dynamic> rejected,
        ) {
          return Bucket(colors: colors);
        },
        onAcceptWithDetails: (DragTargetDetails details) {
          // widget.onAccepted(details.data);
          handleOnAccepted(details.data);
        },
      );
  }

}