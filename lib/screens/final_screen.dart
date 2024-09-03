import 'package:one_tutor_arithmetic/widgets/audio_controller.dart';
import 'package:one_tutor_arithmetic/widgets/background.dart';
import 'package:one_tutor_arithmetic/screens/start_screen.dart';
import 'package:one_tutor_arithmetic/widgets/decorated_button.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:confetti/confetti.dart';
import 'dart:io' show Platform, exit;
import 'package:flutter/services.dart';


class FinalScreen extends StatefulWidget {
  const FinalScreen({super.key});

  @override
  State<FinalScreen> createState() => _FinalScreenState();
}

class _FinalScreenState extends State<FinalScreen> {

  late AudioController _audioController;
  final _confettiController = ConfettiController();


  @override
  void initState(){

    super.initState();
    _initAudioController();
    _confettiController.play();

  }


  void _initAudioController() async {

    _audioController = AudioController();
    await _audioController.initialize();
    _audioController.playSound("assets/audio/win-fantasia.mp3");

  }


  void _handleOnPressedExit( ){

    if (Platform.isAndroid) {
      SystemNavigator.pop();
    } else if (Platform.isIOS) {
      exit(0);
    }

  }


  void _handleOnPressedMainMenu(BuildContext context) {
    
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => const StartScreen(),
      ),
    );
    
  }
  

  @override
  Widget build(BuildContext context) {

    return 
      Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          automaticallyImplyLeading: false,
          title: const Text( "OneTutor: Arithmetic" ),
        ),
        body:
          Stack(
            children: [
              const Background( ),
              Center(
                child: 
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Well Done!!!",
                        style: GoogleFonts.merriweather(
                          textStyle: const TextStyle(fontSize: 35, fontWeight: FontWeight.bold)
                        ),
                      ),
                      const SizedBox(
                        height: 50.0,
                      ),
                      ConfettiWidget(
                        confettiController: _confettiController, 
                        shouldLoop: true,
                        blastDirectionality: BlastDirectionality.explosive,
                      ),
                      DecoratedButton(
                        width: 200.0,
                        height: 50.0,
                        text: "Main Menu", 
                        icon: Icons.menu, 
                        onPressed: () {
                          _handleOnPressedMainMenu(context);
                        }
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      DecoratedButton(
                        width: 200.0,
                        height: 50.0,
                        text: "Exit", 
                        icon: Icons.exit_to_app, 
                        onPressed: () {
                          _handleOnPressedExit();
                        }
                      ),
                    ]
                  ),
              ),
            ],
          ),
        );

  }

}
