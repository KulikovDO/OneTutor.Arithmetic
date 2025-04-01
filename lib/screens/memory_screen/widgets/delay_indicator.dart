import 'package:flutter/material.dart';
import 'package:one_tutor_arithmetic/widgets/progress_indicator.dart' as pi;

class DelayIndicator extends StatefulWidget {

  const DelayIndicator({super.key});
  @override
  State<DelayIndicator> createState() => _DelayIndicatorState();

}

class _DelayIndicatorState extends State<DelayIndicator>{

  double _progress = 0.0;  

  @override
  Widget build(BuildContext context) {

    return Center(
      child: pi.ProgressIndicator(progress: _progress)
    );
  }

}