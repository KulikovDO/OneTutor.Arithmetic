import 'package:flutter/material.dart';
import 'package:one_tutor_arithmetic/screens/pebble_division_screen/data/pebble_colors.dart';
import 'package:one_tutor_arithmetic/screens/pebble_division_screen/widgets/pebble.dart';

class Bucket extends StatefulWidget {

  final List<int> colors;

  const Bucket({
    super.key,
    required this.colors,
  });

  @override
  State<Bucket> createState() => _BucketState();
}

class _BucketState extends State<Bucket> {

  List<Widget> pebbles = [];
  
  @override
  void initState() {
    super.initState();
    for(int colorIndex in widget.colors){

      pebbles.add(Pebble(color: pebbleColors[colorIndex]));
    }


  }

  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;

    return Container(
      width: size.width / 3,
      height: size.width / 2.5, // suitable for 6 pebbles
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
          runSpacing: 0,
          children: pebbles,
        ),
      ),
    );
  }
}