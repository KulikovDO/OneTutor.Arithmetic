import 'package:first_app/home_screen.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:first_app/progress_indicator.dart' as pi;


var rng = Random();
FlutterTts flutterTts = FlutterTts();

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Practice Addition',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      // home: MyHomePage(title: 'Practice Addition'),
      home: Scaffold(
      appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: const Text("Practice Addition"),
        ),
        body: const HomeScreen(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({super.key, required this.title}) 
  {
    flutterTts.setSpeechRate(0.4);
  }

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
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
