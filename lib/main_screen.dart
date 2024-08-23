import 'package:first_app/final_screen.dart';
import 'package:flutter/material.dart';
import 'package:first_app/progress_indicator.dart' as pi;
import 'dart:math';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:shared_preferences/shared_preferences.dart';


var rng = Random();
FlutterTts flutterTts = FlutterTts();

class MainScreen extends StatefulWidget {
  MainScreen({super.key}) 
  {
    flutterTts.setSpeechRate(0.4);
  }

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _firstNumber = 0;
  int _secondNumber = 0;
  int _iteration = 0;
  int numOfIterations = 10;
  double _progress = 0;

  @override
  void initState(){

    super.initState();
    _readConfig();
    _incrementCounter();

  }

  void _displayProgress(){

    setState(() {
      _progress = _iteration / numOfIterations;
    });

  }


  void _handleFloatingActionButtonPress(){
    
    _displayProgress();
    _incrementCounter();

  }


  void _incrementCounter() async{

    if( _iteration >= numOfIterations){

      await Future.delayed(const Duration(milliseconds: 600));

      if (!mounted) return;

      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (ctx) => const FinalScreen()
        ),
      );
        

    } else {
    
      int firstNumber = 0;
      int secondNumber = 0;

      do{
        
        firstNumber = rng.nextInt( 5 ) + 1;
        secondNumber = rng.nextInt( 5 ) + 1;

      }
      while( firstNumber == _firstNumber && secondNumber == _secondNumber );

      final text = 'How much is $firstNumber plus $secondNumber?';
      flutterTts.speak(text);
      
      setState(() {
        _firstNumber = firstNumber;
        _secondNumber = secondNumber;
        _iteration = _iteration == numOfIterations ? 1 : _iteration + 1;
      });

    }

  }

  void _readConfig() async {

    final prefs = await SharedPreferences.getInstance();
    numOfIterations = prefs.getInt('iterations') ?? 10;

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        automaticallyImplyLeading: false,
        title: const Text("Practice Addition"),
      ),
      body: Stack(
        children: <Widget>[ 
          
          Container(
            color: Colors.amber,
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                  Expanded(
                    child: Container(
                      color: Colors.red,
                      width: double.infinity,
                      child: Center(
                        child: Text(
                          "$_firstNumber",
                          style: const TextStyle(color: Colors.white, fontSize: 100),
                        ),
                      )
                    )
                  ),
                  
                  Expanded(
                    child: Container(
                      color: Colors.blue,
                      width: double.infinity,
                      child: Center(
                        child: Text(
                          "$_secondNumber",
                          style: const TextStyle(color: Colors.white, fontSize: 100),
                        ),
                      )
                    )
                  ),
                ]
              ),
          ),
          Opacity(
            opacity: 0.15,
            child: Center(
              child: pi.ProgressIndicator(progress: _progress)
            ),
          ),
        ]
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _handleFloatingActionButtonPress,
        tooltip: 'Restart',
        child: const Icon(Icons.navigate_next),
      ),
    );
  }
}
