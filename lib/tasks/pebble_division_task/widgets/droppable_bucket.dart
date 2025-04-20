import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:one_tutor_arithmetic/tasks/pebble_division_task/pebbles_provider.dart';
import 'package:one_tutor_arithmetic/tasks/pebble_division_task/widgets/bucket.dart';
import 'package:one_tutor_arithmetic/tasks/pebble_division_task/widgets/draggable_pebble.dart';

const int bucketCapacity = 6;

class DroppableBucket extends ConsumerWidget {

  const DroppableBucket({ super.key, });

  handleOnAccepted(DraggablePebble draggablePebble, WidgetRef ref){

    final map = ref.read(pebblesProvider);

    if(map[key!]!.length < bucketCapacity){
      
      ref.watch(pebblesProvider.notifier).movePebble(key as GlobalKey, draggablePebble);

    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final map = ref.watch(pebblesProvider);

    return 
      DragTarget<DraggablePebble>(
        builder: (
          BuildContext context,
          List<dynamic> accepted,
          List<dynamic> rejected,
        ) {
          return Bucket(draggablePebbles: map[key] ?? []);
        },
        onAcceptWithDetails: (DragTargetDetails details) {
          handleOnAccepted(details.data, ref);
        },
      );
  }
}