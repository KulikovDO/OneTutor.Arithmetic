import 'package:first_app/audio_controller.dart';
import 'package:first_app/main_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({required this.audioController, super.key});

  final AudioController audioController;

  void _handleOnPressed(BuildContext context){
    // Navigator.of(context).push(
    //   MaterialPageRoute(
    //     builder: (ctx) => MainScreen(),
    //   ),
    // );
    audioController.playSound("assets/audio/win-fantasia.mp3");
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 200.0,
        height: 50.0,
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