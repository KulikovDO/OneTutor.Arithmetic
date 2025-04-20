import 'package:flutter/material.dart';
import 'package:one_tutor_arithmetic/tasks/pebble_division_task/data/pebble_colors.dart';
import 'package:one_tutor_arithmetic/tasks/pebble_division_task/widgets/pebble.dart';
import 'dart:math' as math;


var rng = math.Random();


class DraggablePebble extends StatefulWidget {

  const DraggablePebble({ super.key });

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
    pebble = Pebble(key: key, color: pebbleColors[colorIndex], width: 60.0);
  }

  @override
  Widget build(BuildContext context) {
   
    return 
      Draggable<DraggablePebble>(
        data: widget,
        feedback: pebble,
        childWhenDragging: const SizedBox(width: 0, height: 0),
        child: pebble,
      );
  }

}