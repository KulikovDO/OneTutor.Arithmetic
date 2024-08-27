import 'package:flutter/material.dart';


class DecoratedButton extends StatelessWidget {
  
  final double width;
  final double height;
  final String text;
  final IconData icon;
  final Function onPressed;
  
  const DecoratedButton({
    super.key, 
    required this.width, 
    required this.height, 
    required this.text, 
    required this.icon, 
    required this.onPressed
  });


  void _handleOnPressed(BuildContext context) {
    
  }

  @override
  Widget build(BuildContext context) {

    return ElevatedButton(
      onPressed: () { 
        _handleOnPressed(context);
      },
      child: SizedBox(
        width: width,
        height: height,
        child:
          ElevatedButton(
            onPressed: () { 
              _handleOnPressed(context);
            },
            child: const Padding(
              padding: EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    icon,
                  ),
                  SizedBox(
                    width: 5.0,
                  ),
                  Text( text ),
                  
                ],
              )
            ),
          ),
      ),
    );


  }

}