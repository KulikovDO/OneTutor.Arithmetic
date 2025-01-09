import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:one_tutor_arithmetic/screens/final_screen.dart';
import 'package:one_tutor_arithmetic/screens/grouping_screen/models/grouping_task.dart';
import 'package:one_tutor_arithmetic/screens/grouping_screen/widgets/text_input_container.dart';
import 'package:one_tutor_arithmetic/screens/grouping_screen/widgets/touch_control.dart';
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

  late GroupingTask task;
  late Widget textInputContainer;
  late TouchControl touchControl;
  int answer = 0;
  int _iteration = 0;
  int numOfIterations = 10;
  double _progress = 0;

  Future<void> speak(String text) async {
    
    await flutterTts.awaitSpeakCompletion(true);
    await flutterTts.speak(text);
    
  }

  _readConfig() async {

    final prefs = await SharedPreferences.getInstance();
    numOfIterations = prefs.getInt('iterations') ?? 10;

  }

  asyncInitState() async =>  await _readConfig();

  @override
  initState() {

    super.initState();
    task = GroupingTask.create();

    asyncInitState();
    init();

  }

  init(){

    answer = 0;
    textInputContainer = TextInputContainer(key: GlobalKey(), text: "?", onValueEntered: handleValueEntered,);

    FlutterView view = PlatformDispatcher.instance.views.first;
    double screenWidth = view.physicalSize.width / view.devicePixelRatio;

    task = task.prepareTask(screenWidth);
    touchControl = TouchControl(key: GlobalKey(), task: task,);
    flutterTts.speak(task.text);

  }

  void handleValueEntered(int value) {

    setState(() {
      answer = value;
    });

  }

  handleSubmit() async{

    bool answerIsCorrect = answer == task.answer;

     if(answerIsCorrect){
      await speak("That's correct");
    } else {
      await speak("Please try again");
    }

    if(answerIsCorrect){

      setState(() {
        
        _iteration = _iteration == numOfIterations ? 1 : _iteration + 1;
        _progress = _iteration / numOfIterations;
        answer = 0;

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

        flutterTts.speak(task.text);
      }
    } 

  }

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
            const Background(),

            Opacity(
              opacity: 0.15,
              child: Center(
                child: pi.ProgressIndicator(progress: _progress)
              ),
            ),

            Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child:
                        task.richText
                    ),
                  ),
                ),

                // TouchControl(task: task, ),
                touchControl,

                const SizedBox(height: 30,),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text( "Number of groups: ", style: TextStyle( fontSize: 25, fontWeight: FontWeight.w500 )),
                    textInputContainer,
                  ]
                ),
              ]
            )
          ],
        ),
      extendBody: true,
      resizeToAvoidBottomInset : false,
      bottomNavigationBar: BottomNavigationBarContainer(onPress: handleSubmit, isDisabled: answer == ""),
    );
  }

}