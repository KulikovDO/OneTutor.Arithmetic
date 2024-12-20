import 'package:flutter/material.dart';
import 'package:one_tutor_arithmetic/screens/pebble_division_screen/data/pebble_colors.dart';
import 'package:one_tutor_arithmetic/screens/pebble_division_screen/widgets/pebble.dart';
import 'dart:math' as math;


var rng = math.Random();


class DraggablePebble extends StatefulWidget {

  final Function onDragCompleted;
  
  const DraggablePebble({ super.key, required this.onDragCompleted, });

  @override
  State<DraggablePebble> createState() => _DraggablePebbleState();
}

class _DraggablePebbleState extends State<DraggablePebble> {

  int colorIndex = 0;
  late Pebble pebble;
  late GlobalKey key;
  

  @override
  void initState() {
    super.initState();
    key = GlobalKey();
    colorIndex = rng.nextInt(pebbleColors.length );
    pebble = Pebble(key: key, color: pebbleColors[colorIndex]);
  }

  @override
  Widget build(BuildContext context) {
    
    return 
      Draggable<int>(
        data: colorIndex,
        feedback: pebble,
        childWhenDragging: const SizedBox(width: 0, height: 0),
        onDragCompleted: (){
          widget.onDragCompleted(key);
        },
        child: pebble,
      );
  }

}