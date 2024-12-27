import 'package:flutter/material.dart';
import 'package:one_tutor_arithmetic/screens/pebble_division_screen/widgets/draggable_pebble.dart';


class Bucket extends StatelessWidget {

  final List<DraggablePebble> draggablePebbles;

  const Bucket({
    super.key,
    required this.draggablePebbles,
  });

  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;

    return Container(
      width: size.width / 3,
      height: size.width / 3, // suitable for 6 pebbles
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.07),
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(15),
          bottomRight: Radius.circular(15),
        ),
        border: const Border(
          right: BorderSide(
            color: Colors.black,
            width: 3.0,
          ),
          left: BorderSide(
            color: Colors.black,
            width: 3.0,
          ),
          bottom: BorderSide(
            color: Colors.black,
            width: 3.0,
          ),
        )
      ),
      child: Center(
        child: Wrap(
          spacing: 1,
          runSpacing: 1,
          children: draggablePebbles,
        ),
      ),
    );
  }
}