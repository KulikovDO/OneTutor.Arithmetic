import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:one_tutor_arithmetic/screens/final_screen.dart';
import 'package:one_tutor_arithmetic/widgets/background.dart';
import 'package:one_tutor_arithmetic/widgets/bottom_navigation_bar.dart';
import 'package:one_tutor_arithmetic/widgets/drag_and_droppable_text_container.dart';
import 'package:flutter/foundation.dart';
import 'package:one_tutor_arithmetic/widgets/progress_indicator.dart' as pi;
import 'package:shared_preferences/shared_preferences.dart';

FlutterTts flutterTts = FlutterTts();
var rng = Random();


class OrderingScreen extends StatefulWidget {
  OrderingScreen({super.key}) 
  {
    flutterTts.setSpeechRate(0.4);
  }

  @override
  State<OrderingScreen> createState() => _OrderingScreenState();
}


class _OrderingScreenState extends State<OrderingScreen> {

  final List<String> description = ["Put these numbers in order from highest to lowest", "Put these numbers in order from lowest to highest"];

  int? _acceptedData;
  final List<String> _numbers = [];
  int _order = 0;
  int _iteration = 0;
  int numOfIterations = 10;
  double _progress = 0;
  
  List<GlobalKey<DragAndDroppableTextContainerState>> draggableKeys = [];
  List<GlobalKey<DragAndDroppableTextContainerState>> droppableKeys = [];

  List<DragAndDroppableTextContainer> draggableList = [];
  List<DragAndDroppableTextContainer> droppableList = [];

  Future<void> speak(String text) async {
    
    await flutterTts.awaitSpeakCompletion(true);
    await flutterTts.speak(text);
    
  }

  _readConfig() async {

    final prefs = await SharedPreferences.getInstance();
    numOfIterations = prefs.getInt('iterations') ?? 10;

  }


  onAccepted(int data){
    setState(() {
      _acceptedData = data; 
    });
  
  }

  checkAnswerIsGiven(){

    bool answerNotNull = true;    
    
    for(var droppableKey in droppableKeys)
    {

      if(droppableKey.currentState == null || droppableKey.currentState!.text == null){

        answerNotNull = false;
        break;

      }

    }

    return answerNotNull;

  }


  Future<bool> checkAnswer() async{

    List<int> answers = [];
    
    for(var droppableKey in droppableKeys)
    {

      if(droppableKey.currentState == null || droppableKey.currentState!.text == null){

        return false;

      }

      answers.add(int.parse(droppableKey.currentState!.text!));
    }

    List<int> correctAnswers = [...answers];

    if(_order == 0) {
      correctAnswers.sort((b, a) => a.compareTo(b)); // descending
    } else {
      correctAnswers.sort((a, b) => a.compareTo(b)); // ascending
    }

    bool answerIsCorrect =  listEquals(answers, correctAnswers);

    if(answerIsCorrect){
      await speak("That's correct");
    } else {
      await speak("Please try again");
    }

    return answerIsCorrect;

  }

  
  init(){

      _acceptedData = null; 

      _numbers.clear();
      _numbers.addAll(_generateNumbers());
      _order = rng.nextInt( 2 );
      
      draggableKeys.clear();
      draggableList.clear();

      droppableKeys.clear();
      droppableList.clear();

      for(int i = 0; i < 3; i++){
        draggableKeys.add(GlobalKey());
        droppableKeys.add(GlobalKey());
      }

      draggableList = List.generate(_numbers.length,(index) => 
        DragAndDroppableTextContainer(key: draggableKeys[index], acceptedData: _acceptedData, text: _numbers[index], isDraggable: true, onAccepted: onAccepted,)
      );    

      droppableList = List.generate( _numbers.length, (index) => 
        DragAndDroppableTextContainer(key: droppableKeys[index], acceptedData: _acceptedData, text: null, isDraggable: false, onAccepted: onAccepted,)
      );

  }

  List<String> _generateNumbers(){

    List<String> numbers = [];
    
    int number = 0;

    for(int i = 0; i < 3; i++)
    {

      do
      {
        number = rng.nextInt( 10 ) + 1;
      }
      while(numbers.contains(number.toString()));

      numbers.add(number.toString());

    }

    return numbers;

  }


  _handleSubmit() async{

    bool answerIsCorrect = await checkAnswer();

    if(answerIsCorrect){

      setState(() {
        
        _iteration = _iteration == numOfIterations ? 1 : _iteration + 1;
        _progress = _iteration / numOfIterations;

      });

      if( _iteration >= numOfIterations){

    await Future.delayed(const Duration(milliseconds: 600));

    if (!mounted) return;

        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (ctx) => const FinalScreen()
          ),
        );
          
      } else {

        setState(() {
        
          init();

        });

        flutterTts.speak(description[_order]);
      }
    } 

  }

  asyncInitState() async {
    await _readConfig();
  }

  @override
  initState() {

    super.initState();

    asyncInitState();

    init();
    flutterTts.speak(description[_order]);

  }

  @override
  Widget build(BuildContext context) {
  
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Ordering"),
      ),
      body:
        Stack(
          children: [
            
            const Background( ),

            Opacity(
              opacity: 0.15,
              child: Center(
                child: pi.ProgressIndicator(progress: _progress)
              ),
            ),
      
            Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                Expanded(
                  child: SizedBox(
                    width: double.infinity,
                    child: 
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          child: Text( description[_order], style:  const TextStyle( fontSize: 20, fontWeight: FontWeight.w500 ))
                        ),
                      ),
                  )
                ),

                Expanded(
                  flex: 3,
                  child: SizedBox(
                    width: double.infinity,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: draggableList,
                        ),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: droppableList
                        ),
                      ],
                      ),
                    ),
                  ),
                
                const Expanded(
                  child: SizedBox(
                    width: double.infinity,
                  )
                ),
                ],
              ),
          ]
        ),
      extendBody: true,
      bottomNavigationBar: BottomNavigationBarContainer(onPress: _handleSubmit, isDisabled: /*!answerIsGiven,*/!checkAnswerIsGiven()),
    );
  }

}