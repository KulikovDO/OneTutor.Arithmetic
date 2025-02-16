import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:one_tutor_arithmetic/screens/final_screen.dart';
import 'package:one_tutor_arithmetic/screens/ordering_screen/models/ordering_task.dart';
import 'package:one_tutor_arithmetic/widgets/background.dart';
import 'package:one_tutor_arithmetic/widgets/bottom_navigation_bar.dart';
import 'package:one_tutor_arithmetic/widgets/drag_and_droppable_text_container.dart';
import 'package:one_tutor_arithmetic/widgets/progress_indicator.dart' as pi;
import 'package:shared_preferences/shared_preferences.dart';

FlutterTts flutterTts = FlutterTts();


class OrderingScreen extends StatefulWidget {
  OrderingScreen({super.key}) 
  {
    flutterTts.setSpeechRate(0.4);
  }

  @override
  State<OrderingScreen> createState() => _OrderingScreenState();
}


class _OrderingScreenState extends State<OrderingScreen> {

  int? _acceptedData;
  
  int _iteration = 0;
  int numOfIterations = 10;
  double _progress = 0;

  late OrderingTask task;
  
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

  checkAnswerIsGiven( ) {

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


  bool checkAnswer( ) {

    List<int> answers = [];
    
    for(var droppableKey in droppableKeys)
    {

      if(droppableKey.currentState == null || droppableKey.currentState!.text == null){

        return false;

      }

      answers.add(int.parse(droppableKey.currentState!.text!));
    }

    return task.checkAnswer(answers);
  }

  
  init(){

      task = task.prepareTask();
      flutterTts.speak(task.text);

      _acceptedData = null; 
      
      draggableKeys.clear();
      draggableList.clear();

      droppableKeys.clear();
      droppableList.clear();

      for(int i = 0; i < 3; i++){
        draggableKeys.add(GlobalKey());
        droppableKeys.add(GlobalKey());
      }

      draggableList = List.generate( task.numbers.length,(index) => 
        DragAndDroppableTextContainer(key: draggableKeys[index], acceptedData: _acceptedData, text: task.numbers[index], isDraggable: true, onAccepted: onAccepted,)
      );    

      droppableList = List.generate( task.numbers.length, (index) => 
        DragAndDroppableTextContainer(key: droppableKeys[index], acceptedData: _acceptedData, text: null, isDraggable: false, onAccepted: onAccepted,)
      );

  }


  _handleSubmit() async{

    bool answerIsCorrect = checkAnswer();

    if(answerIsCorrect){
      await speak("That's correct");
    } else {
      await speak("Please try again");
    }

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
      }
    } 

  }


  asyncInitState() async => await _readConfig();
  

  @override
  initState() {

    super.initState();

    task = OrderingTask.create();

    asyncInitState();

    init();
    flutterTts.speak(task.text);

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
                            child: task.richText
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