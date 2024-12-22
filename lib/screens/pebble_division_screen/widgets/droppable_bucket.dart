import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:one_tutor_arithmetic/screens/pebble_division_screen/pebbles_provider.dart';
import 'package:one_tutor_arithmetic/screens/pebble_division_screen/widgets/bucket.dart';
import 'package:one_tutor_arithmetic/screens/pebble_division_screen/widgets/draggable_pebble.dart';

const int bucketCapacity = 6;

class DroppableBucket extends ConsumerStatefulWidget {

  final Function onAccepted;

  const DroppableBucket({
    super.key,
    required this.onAccepted,
  });

  @override
  ConsumerState<DroppableBucket> createState() => DroppableBucketState();
}

class DroppableBucketState extends ConsumerState<DroppableBucket> {



  List<DraggablePebble> draggablePebbles = [];

  handleOnAccepted(DraggablePebble draggablePebble){

    if(draggablePebbles.length < bucketCapacity){
      widget.onAccepted(widget.key, draggablePebble);
      // draggablePebbles.add(draggablePebble);
    }
  }

  @override
  void initState() {
    super.initState();

    // final map = ref.read(pebblesProvider);
  }

  

  @override
  Widget build(BuildContext context) {

    final map = ref.read(pebblesProvider);

    return 
      DragTarget<DraggablePebble>(
        builder: (
          BuildContext context,
          List<dynamic> accepted,
          List<dynamic> rejected,
        ) {
          return Bucket(draggablePebbles: /*draggablePebbles*/
            map[widget.key]!
          );
        },
        onAcceptWithDetails: (DragTargetDetails details) {
          // widget.onAccepted(details.data);

          // final map = ref.read(pebblesProvider);
          // map[widget.key]!.add(details.data);

          handleOnAccepted(details.data);


        },
      );
  }
}