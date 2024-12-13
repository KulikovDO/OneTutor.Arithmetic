import 'package:one_tutor_arithmetic/data/task_name.dart';
import 'package:one_tutor_arithmetic/intros/main_screen_intro.dart';
import 'package:one_tutor_arithmetic/model/tile_content.dart';
import 'package:one_tutor_arithmetic/screens/final_screen.dart';
import 'package:one_tutor_arithmetic/misc/extensions.dart';
import 'package:one_tutor_arithmetic/screens/arithmetic_screen/models/addition_operation.dart';
import 'package:one_tutor_arithmetic/screens/arithmetic_screen/models/division_operation.dart';
import 'package:one_tutor_arithmetic/screens/arithmetic_screen/models/multiplication_operation.dart';
import 'package:one_tutor_arithmetic/screens/arithmetic_screen/models/subtraction_operation.dart';
import 'package:one_tutor_arithmetic/model/task.dart';
import 'package:flutter/material.dart';
import 'package:one_tutor_arithmetic/widgets/bottom_navigation_bar.dart';
import 'package:one_tutor_arithmetic/widgets/progress_indicator.dart' as pi;
import 'package:flutter_tts/flutter_tts.dart';
import 'package:shared_preferences/shared_preferences.dart';


FlutterTts flutterTts = FlutterTts();

class MainScreen extends StatefulWidget {
  MainScreen({super.key, required this.tileContent}) 
  {
    flutterTts.setSpeechRate(0.4);
  }

  final TileContent tileContent;

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
  late Task task;

  @override
  initState() {

    super.initState();
    asyncInitState();

  }

  asyncInitState() async {
    await _readConfig();
    await _incrementCounter();

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


  _incrementCounter() async{

    if( _iteration >= numOfIterations){

      await Future.delayed(const Duration(milliseconds: 600));

      if (!mounted) return;

      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (ctx) => const FinalScreen()
        ),
      );
        

    } else {

      // TODO: refactoring
      switch(widget.tileContent.taskName){

        case TaskName.addition:
          task = AdditionOperation.prepareTask(_firstNumber, _secondNumber);
          break;
        case TaskName.subtraction:
          task = SubtractionOperation.prepareTask(_firstNumber, _secondNumber);
          break;
        case TaskName.multiplication:
          task = MultiplicationOperation.prepareTask(_firstNumber, _secondNumber);
          break;
        case TaskName.division:
          task = DivisionOperation.prepareTask(_firstNumber, _secondNumber);
          break;
        case TaskName.ordering:
          throw UnimplementedError();
        case TaskName.sequence:
          throw UnimplementedError();
        case TaskName.evenOdd:
          throw UnimplementedError();
      }
      
      if(!displayMainScreenIntro) {
        flutterTts.speak(task.text);
      }
      
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
    displayMainScreenIntro = prefs.getBool('display_main_screen_intro') ?? true;

    setState(() {
      displayMainScreenIntro = prefs.getBool('display_main_screen_intro') ?? true;
    });

  }

  _handleOnPressedGotIt() async {
    
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('display_main_screen_intro', false);
    flutterTts.speak(task.text);
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
        title: Text(widget.tileContent.taskName.name.capitalize()),
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

          Center(
            child: Text(String.fromCharCode(widget.tileContent.icon.codePoint),
                style: TextStyle(
                  inherit: false,
                  fontSize: 70,
                  fontWeight: FontWeight.w800,
                  fontFamily: widget.tileContent.icon.fontFamily,
                  color: Colors.white
                ),
              ),
          ),

          if(displayMainScreenIntro)
            MainScreenIntro(
              onPressed: _handleOnPressedGotIt,
            ),
          
        ]
      ),
      extendBody: true,
      bottomNavigationBar: BottomNavigationBarContainer(onPress: _handleFloatingActionButtonPress, isDisabled: false),
    );
  }
}
