import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:one_tutor_arithmetic/screens/final_screen.dart';
import 'package:one_tutor_arithmetic/screens/grouping_screen/models/grouping_task.dart';
import 'package:one_tutor_arithmetic/widgets/text_input_container.dart';
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
  late TouchControl touchControl;
  int enteredValue = 0;
  int _iteration = 0;
  int numOfIterations = 10;
  double _progress = 0;
  bool isError = false;

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

    enteredValue = -1;
    isError = false;

    FlutterView view = PlatformDispatcher.instance.views.first;
    double screenWidth = view.physicalSize.width / view.devicePixelRatio;

    task = task.prepareTask(screenWidth);
    touchControl = TouchControl(key: GlobalKey(), task: task,);
    flutterTts.speak(task.text);

  }

  void handleValueEntered(int value) {

    setState(() {
      enteredValue = value;
    });

  }

  handleSubmit() async{

    bool answerIsCorrect = enteredValue == task.answer;

    if(answerIsCorrect){
      setState(() {
        isError = false;
      });
      await speak("That's correct");
    } else {
      setState(() {
        isError = true;
      });
      await speak("Please try again");
    }

    if(answerIsCorrect){

      setState(() {
        
        _iteration = _iteration == numOfIterations ? 1 : _iteration + 1;
        _progress = _iteration / numOfIterations;
        enteredValue = 0;

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

                touchControl,

                const SizedBox(height: 30,),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text( "Number of groups: ", style: TextStyle( fontSize: 25, fontWeight: FontWeight.w500 )),
                    TextInputContainer(key: GlobalKey(), text: enteredValue == -1 ? "?" : enteredValue.toString(), onValueEntered: handleValueEntered,isError: isError),
                  ]
                ),
              ]
            )
          ],
        ),
      extendBody: true,
      resizeToAvoidBottomInset : false,
      bottomNavigationBar: BottomNavigationBarContainer(onPress: handleSubmit, isDisabled: enteredValue == ""),
    );
  }

}