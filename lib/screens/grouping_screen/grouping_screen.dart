import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:one_tutor_arithmetic/screens/final_screen.dart';
import 'package:one_tutor_arithmetic/widgets/background.dart';
import 'package:one_tutor_arithmetic/widgets/bottom_navigation_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:one_tutor_arithmetic/widgets/progress_indicator.dart' as pi;


FlutterTts flutterTts = FlutterTts();


class GroupingScreen extends StatefulWidget {
  GroupingScreen({super.key}) 
  {
    flutterTts.setSpeechRate(0.4);
  }

  @override
  State<GroupingScreen> createState() => _GroupingScreenState();
}


class _GroupingScreenState extends State<GroupingScreen> {

  // late GroupingTask task;

  // String answer = "";
  // int _iteration = 0;
  // int numOfIterations = 10;
  // double _progress = 0;

  // Future<void> speak(String text) async {
    
  //   await flutterTts.awaitSpeakCompletion(true);
  //   await flutterTts.speak(text);
    
  // }

  // _readConfig() async {

  //   final prefs = await SharedPreferences.getInstance();
  //   numOfIterations = prefs.getInt('iterations') ?? 10;

  // }

  // asyncInitState() async =>  await _readConfig();

  @override
  initState() {

    super.initState();
    // task = GroupingTask.create();

    // asyncInitState();
    // init();

  }

  // init(){

  //   answer = "";
  //   task = task.prepareTask();
  //   flutterTts.speak(task.text);

  // }

  // onTapped(String number){
    
  //   setState(() {
  //     answer = number;
  //   });

  // }

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

  @override
  Widget build(BuildContext context) {
  
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Grouping"),
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