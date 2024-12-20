import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:one_tutor_arithmetic/screens/pebble_division_screen/widgets/draggable_pebble.dart';
import 'package:one_tutor_arithmetic/screens/pebble_division_screen/widgets/droppable_bucket.dart';
// import 'package:one_tutor_arithmetic/screens/days_of_week_screen/models/days_of_week_task.dart';
// import 'package:one_tutor_arithmetic/screens/days_of_week_screen/models/widgets/tappable_text_container.dart';
// import 'package:one_tutor_arithmetic/screens/final_screen.dart';
// import 'package:one_tutor_arithmetic/screens/pebble_division_screen/models/pebble_division_task.dart';
import 'package:one_tutor_arithmetic/widgets/background.dart';
// import 'package:one_tutor_arithmetic/widgets/bottom_navigation_bar.dart';
// import 'package:one_tutor_arithmetic/widgets/progress_indicator.dart' as pi;
// import 'package:shared_preferences/shared_preferences.dart';


FlutterTts flutterTts = FlutterTts();


class PebbleDivisionScreen extends StatefulWidget {
  PebbleDivisionScreen({super.key}) 
  {
    flutterTts.setSpeechRate(0.4);
  }

  @override
  State<PebbleDivisionScreen> createState() => _PebbleDivisionScreenState();
}


class _PebbleDivisionScreenState extends State<PebbleDivisionScreen> {

  List<GlobalKey<DraggablePebbleState>> draggableKeys = [];
  List<DraggablePebble> draggablePebbles = [];

  handleOnAccepted(DraggablePebble draggablePebble){
    
    setState(() {
      draggablePebbles.remove(draggablePebble);
    });
    
  }

  // Future<void> speak(String text) async {
    
  //   await flutterTts.awaitSpeakCompletion(true);
  //   await flutterTts.speak(text);
    
  // }

  // late PebbleDivisionTask task;

  // String answer = "";
  // int _iteration = 0;
  // int numOfIterations = 10;
  // double _progress = 0;


  // handleSubmit() async{

  //   bool answerIsCorrect = answer == task.answer.toString();

  //    if(answerIsCorrect){
  //     await speak("That's correct");
  //   } else {
  //     await speak("Please try again");
  //   }

  //   if(answerIsCorrect){

  //     setState(() {
        
  //       _iteration = _iteration == numOfIterations ? 1 : _iteration + 1;
  //       _progress = _iteration / numOfIterations;
  //       answer = "";

  //     });

  //     if( _iteration >= numOfIterations){

  //       await Future.delayed(const Duration(milliseconds: 600));

  //       if (!mounted) return;

  //       Navigator.of(context).push(
  //         MaterialPageRoute(
  //           builder: (ctx) => const FinalScreen()
  //         ),
  //       );
          
  //     } else {

  //       setState(() {
        
  //         init();

  //       });

  //       flutterTts.speak(task.text);
  //     }
  //   } 

  // }

  // _readConfig() async {

  //   final prefs = await SharedPreferences.getInstance();
  //   numOfIterations = prefs.getInt('iterations') ?? 10;

  // }

  // onTapped(String dayOfWeek){
    
  //   setState(() {
  //     answer = dayOfWeek;
  //   });

  // }

  // asyncInitState() async =>  await _readConfig();
  
  handleDragCompleted(GlobalKey key){
    print(key);
  }

  @override
  initState() {

    super.initState();

    for(int i = 0; i < 6; i++){
      draggableKeys.add(GlobalKey());
    }

    draggablePebbles = List.generate(/*_numbers.length*/6,(index) => 
      DraggablePebble(key: draggableKeys[index], onDragCompleted: handleDragCompleted,)
    ); 



    // task = PebbleDivisionScreenTask.create();

    // asyncInitState();
    // init();

  }

  // init(){

  //   answer = "";
  //   task = task.prepareTask();
  //   flutterTts.speak(task.text);

  // }

  @override
  Widget build(BuildContext context) {
  
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Pebble Division"),
      ),
      body:
        Stack(
          children: [
            Background( ),

            // Opacity(
            //   opacity: 0.15,
            //   child: Center(
            //     child: pi.ProgressIndicator(progress: _progress)
            //   ),
            // ),

            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                  

                // Expanded(
                //   child: SizedBox(
                //     width: double.infinity,
                //     child: 
                //       Center(
                //         child: Padding(
                //          padding: const EdgeInsets.only(left: 10, right: 10),
                //          child:
                //             task.richText
                //         ),
                //       ),
                //   )
                // ),

                Expanded(
                  //flex: 4,
                  
                      child: Wrap(
                        spacing: 0,
                        runSpacing: 0,
                        children: draggablePebbles,
                      ),
                    
                ),

                Expanded(
                  //flex: 4,
                  child: 
                    Center(
                      child: Wrap(
                        spacing: 10,
                        runSpacing: 10,
                        children: [
                          DroppableBucket(onAccepted: handleOnAccepted),
                        ],
                      ),
                    )
                ),

                // Expanded(
                //   flex: 5,
                //   child: 
                //      Column(
                //       mainAxisAlignment: MainAxisAlignment.center,
                //       crossAxisAlignment: CrossAxisAlignment.center,
                //       children:[
                //         TappableTextContainer(key: GlobalKey(), text: task.answerOptions[0].toString(), selectedText: answer, onTapped: onTapped,),
                //         TappableTextContainer(key: GlobalKey(), text: task.answerOptions[1].toString(), selectedText: answer, onTapped: onTapped,),
                //         TappableTextContainer(key: GlobalKey(), text: task.answerOptions[2].toString(), selectedText: answer, onTapped: onTapped,),
                //       ]
                //     ),
                // ),
              ]
            )
          ],
        ),
      extendBody: true,
      resizeToAvoidBottomInset : false,
      // bottomNavigationBar: BottomNavigationBarContainer(onPress: handleSubmit, isDisabled: answer == ""),
    );
  }
}