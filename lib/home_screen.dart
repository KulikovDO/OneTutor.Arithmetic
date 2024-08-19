import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  void _handleOnPressed(){
    print("_handleOnPressed");
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 200.0,
        height: 50.0,
        child: 
          ElevatedButton(
            onPressed: _handleOnPressed,
            child: const Padding(
              padding: EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.play_arrow,
                  ),
                  SizedBox(
                    width: 5.0,
                  ),
                  Text('Start'),
                  
                ],
              )
            ),
            
          ),
      )
    );
  }
}