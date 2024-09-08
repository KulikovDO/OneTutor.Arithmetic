import 'package:one_tutor_arithmetic/data/arithmetic_operation.dart';
import 'package:one_tutor_arithmetic/intros/main_screen_intro.dart';
import 'package:one_tutor_arithmetic/screens/final_screen.dart';
import 'package:one_tutor_arithmetic/misc/extensions.dart';
import 'package:one_tutor_arithmetic/model/addition_operation.dart';
import 'package:one_tutor_arithmetic/model/division_operation.dart';
import 'package:one_tutor_arithmetic/model/multiplication_operation.dart';
import 'package:one_tutor_arithmetic/model/subtraction_operation.dart';
import 'package:one_tutor_arithmetic/model/task.dart';
import 'package:flutter/material.dart';
import 'package:one_tutor_arithmetic/widgets/progress_indicator.dart' as pi;
import 'package:flutter_tts/flutter_tts.dart';
import 'package:shared_preferences/shared_preferences.dart';


FlutterTts flutterTts = FlutterTts();

class MainScreen extends StatefulWidget {
  MainScreen({super.key, required this.arithmeticOperation}) 
  {
    flutterTts.setSpeechRate(0.4);
  }

  final ArithmeticOperation arithmeticOperation;

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _firstNumber = 0;
  int _secondNumber = 0;
  int _iteration = 0;
  int numOfIterations = 10;
  double _progress = 0;
  bool displayMainScreenIntro = true;

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
    
      Task task;
      
      switch(widget.arithmeticOperation){

        case ArithmeticOperation.addition:
          task = AdditionOperation.prepareTask(_firstNumber, _secondNumber);
          break;
        case ArithmeticOperation.subtraction:
          task = SubtractionOperation.prepareTask(_firstNumber, _secondNumber);
          break;
        case ArithmeticOperation.multiplication:
          task = MultiplicationOperation.prepareTask(_firstNumber, _secondNumber);
          break;
        case ArithmeticOperation.division:
          task = DivisionOperation.prepareTask(_firstNumber, _secondNumber);
          break;
      }
      
      flutterTts.speak(task.text);
      
      setState(() {
        _firstNumber = task.firstNumber;
        _secondNumber = task.secondNumber;
        _iteration = _iteration == numOfIterations ? 1 : _iteration + 1;
      });

    }

  }

  _readConfig() async {

    final prefs = await SharedPreferences.getInstance();
    numOfIterations = prefs.getInt('iterations') ?? 10;

  }

  _handleOnPressedGotIt() {
    setState(() {
      displayMainScreenIntro = false;
    });
  }

  

  @override
  Widget build(BuildContext context) {
    bool isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;

    List<Expanded> numberComponents = [
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
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.arithmeticOperation.name.capitalize()),
      ),
      body: Stack(
        children: [ 

          isPortrait
            ?
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: numberComponents
          )
            :
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: numberComponents
          ),

          Opacity(
            opacity: 0.15,
            child: Center(
              child: pi.ProgressIndicator(progress: _progress)
            ),
          ),
          if(displayMainScreenIntro)
            MainScreenIntro(
              onPressed: _handleOnPressedGotIt,
            ),
          
        ]
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: displayMainScreenIntro ? const Color.fromARGB(255, 96, 91, 102) : Theme.of(context).colorScheme.secondaryContainer,
        onPressed: displayMainScreenIntro ? null : _handleFloatingActionButtonPress,
        tooltip: 'Restart',
        child: const Icon(Icons.navigate_next),
      ),
    );
  }
}
