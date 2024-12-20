import 'package:flutter/material.dart';

class Bucket extends StatefulWidget {

  const Bucket({
    super.key 
  });

  @override
  State<Bucket> createState() => _BucketState();
}

class _BucketState extends State<Bucket> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;

    return Container(
      width: size.width / 3,
      height: size.width / 3,
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
      )
    );
  }
}