import 'package:flutter/material.dart';

class TextInputRow extends StatefulWidget {

  // final Function onCompleted;

  const TextInputRow({
    super.key, 
    // required this.onCompleted,
  });

  @override
  State<TextInputRow> createState() => _TextInputRowState();

}

class _TextInputRowState extends State<TextInputRow> with SingleTickerProviderStateMixin {

  

  @override
  Widget build(BuildContext context) {

    return 
      Row(
        children: [
          
        ],
      );
  }
}