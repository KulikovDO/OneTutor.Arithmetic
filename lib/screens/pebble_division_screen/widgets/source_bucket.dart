import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:one_tutor_arithmetic/screens/pebble_division_screen/pebbles_provider.dart';
import 'package:one_tutor_arithmetic/screens/pebble_division_screen/widgets/draggable_pebble.dart';


class SourceBucket extends ConsumerStatefulWidget {

  final int numOfPebbles;

  const SourceBucket({
    super.key,
    required this.numOfPebbles,
  });

  @override
  ConsumerState<SourceBucket> createState() => SourceBucketState();
}

class SourceBucketState extends ConsumerState<SourceBucket> {
  
  @override
  void initState() {
    super.initState();

    List<GlobalKey> draggableKeys = [];
    List<DraggablePebble> draggablePebbles = [];
    
    for(int i = 0; i < widget.numOfPebbles; i++){
      draggableKeys.add(GlobalKey());
    }

    draggablePebbles = List.generate(widget.numOfPebbles,(index) => 
      DraggablePebble(key: draggableKeys[index])
    ); 

    final map = ref.read(pebblesProvider);

    map[widget.key! as GlobalKey] = draggablePebbles;

  }
  
  @override
  Widget build(BuildContext context) {

    final map = ref.watch(pebblesProvider);
    
    return Wrap(
      spacing: 1,
      runSpacing: 1,
      children: map[widget.key] ?? [],
    );
                  
  }
}