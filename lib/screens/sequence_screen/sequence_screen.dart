import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:one_tutor_arithmetic/screens/final_screen.dart';
import 'package:one_tutor_arithmetic/screens/sequence_screen/models/sequence_task.dart';
import 'package:one_tutor_arithmetic/screens/sequence_screen/widgets/text_container.dart';
import 'package:one_tutor_arithmetic/screens/sequence_screen/widgets/text_input_container.dart';
import 'package:one_tutor_arithmetic/widgets/background.dart';
import 'package:one_tutor_arithmetic/widgets/bottom_navigation_bar.dart';
import 'package:one_tutor_arithmetic/widgets/progress_indicator.dart' as pi;
import 'package:shared_preferences/shared_preferences.dart';


FlutterTts flutterTts = FlutterTts();

class SequenceScreen extends StatefulWidget {
  SequenceScreen({super.key}) 
  {
    flutterTts.setSpeechRate(0.4);
  }

  @override
  State<SequenceScreen> createState() => _SequenceScreenState();
}


class _SequenceScreenState extends State<SequenceScreen> {

  late SequenceTask task;

  Future<void> speak(String text) async {
    
    await flutterTts.awaitSpeakCompletion(true);
    await flutterTts.speak(text);
    
  }

  int enteredValue = -1;
  List<Widget> textContainerList = [];
  int _iteration = 0;
  int numOfIterations = 10;
  double _progress = 0;

  handleSubmit() async{

    bool answerIsCorrect = task.checkAnswer(enteredValue);

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

        flutterTts.speak(task.text);
      }
    } 
  }

  void onValueEntered(int value){
    setState(() {
      enteredValue = value;
    });
  }

  _readConfig() async {

    final prefs = await SharedPreferences.getInstance();
    numOfIterations = prefs.getInt('iterations') ?? 10;

  }

  init(){

    task = task.prepareTask();
    flutterTts.speak(task.text);
    enteredValue = -1;

    textContainerList.clear();
    for(int option in task.options){
      if(option == -1){
        textContainerList.add(TextInputContainer(key: GlobalKey(), text: "?", onValueEntered: onValueEntered,));
      } else {
        textContainerList.add(TextContainer(key: GlobalKey(), text: option.toString()));
      }
    }
  }

  asyncInitState() async {
    await _readConfig();
  }

  @override
  initState() {

    super.initState();
    task = SequenceTask.create();
    init();
    asyncInitState();

  }

  @override
  Widget build(BuildContext context) {
  
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Sequence"),
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

            SizedBox(
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: 
                  [
                    SizedBox(
                      width: double.infinity,
                      child: 
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10, right: 10),
                            child: task.richText
                          ),
                        ),
                    ),
                    ...textContainerList,
                  ]
              ),
            ),
          ],
        ),
      extendBody: true,
      resizeToAvoidBottomInset : false,
      bottomNavigationBar: BottomNavigationBarContainer(onPress: handleSubmit, isDisabled: enteredValue == -1),
    );
  }
}