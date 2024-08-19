import 'package:flutter/material.dart';
import 'package:first_app/progress_indicator.dart' as pi;
import 'dart:math';
import 'package:flutter_tts/flutter_tts.dart';


var rng = Random();
FlutterTts flutterTts = FlutterTts();

class MainScreen extends StatefulWidget {
  MainScreen({super.key, required this.title}) 
  {
    flutterTts.setSpeechRate(0.4);
  }

  final String title;

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _firstNumber = 0;
  int _secondNumber = 0;
  int _attempt = 0;
  double _progress = 0;

  @override
  void initState(){

    super.initState();
    _incrementCounter();

  }

  void _displayProgress(){

    setState(() {
      _progress = _attempt / 10;
    });

  }


  void _handleFloatingActionButtonPress(){
    
    _displayProgress();
    _incrementCounter();

  }


  void _incrementCounter() async{
    
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
      _attempt = _attempt == 10 ? 1 : _attempt + 1;
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
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
        child: const Icon(Icons.restart_alt),
      ),
    );
  }
}
