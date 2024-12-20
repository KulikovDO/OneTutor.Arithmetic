import 'package:flutter/material.dart';
import 'package:one_tutor_arithmetic/screens/pebble_division_screen/widgets/pebble.dart';

class DraggablePebble extends StatefulWidget {

  // final Color? color;

  const DraggablePebble({
    super.key,
    // this.color,
  });

  @override
  State<DraggablePebble> createState() => _DraggablePebbleState();
}

class _DraggablePebbleState extends State<DraggablePebble> {

  late Pebble pebble;

  @override
  void initState() {
    
    super.initState();
    pebble = Pebble(key: GlobalKey());

  }

  @override
  Widget build(BuildContext context) {
    
    return 
      Draggable(
        feedback: pebble,
        childWhenDragging: const SizedBox(width: 0, height: 0),
        child: pebble,
      );
  }

}