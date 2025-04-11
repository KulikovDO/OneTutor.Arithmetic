import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:one_tutor_arithmetic/screens/final_screen.dart';
import 'package:one_tutor_arithmetic/screens/memory_screen/models/memory_task.dart';
import 'package:one_tutor_arithmetic/screens/memory_screen/widgets/delay_indicator.dart';
import 'package:one_tutor_arithmetic/screens/memory_screen/widgets/text_input_row.dart';
import 'package:one_tutor_arithmetic/widgets/background.dart';
import 'package:one_tutor_arithmetic/widgets/bottom_navigation_bar.dart';
import 'package:one_tutor_arithmetic/widgets/custom_floating_action_button.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:one_tutor_arithmetic/widgets/progress_indicator.dart' as pi;



FlutterTts flutterTts = FlutterTts();

class MemoryScreen extends StatefulWidget {
  MemoryScreen({super.key}) 
  {
    flutterTts.setSpeechRate(0.4);
  }

  @override
  State<MemoryScreen> createState() => _MemoryScreenState();
}


class _MemoryScreenState extends State<MemoryScreen> {
  late MemoryTask task;
  int _iteration = 0;
  int numOfIterations = 10;
  double _progress = 0;
  bool displayRichText = false;
  bool displayAnimation = false;
  bool displayTextInputs = false;
  bool isSubmitDisabled = true;
  List<int> enteredValues = [];
  bool speakingAnswerCorrectness = false;
  bool isError = false;
  late TextInputRow textInputRow;

  handleAnimationCompleted() {
    setState(() {
      displayAnimation = false;
      displayTextInputs = true;
    });
  }

  handleSubmit() {

    setState(() {
      isSubmitDisabled = true;
    }); 

    bool answerIsCorrect = task.checkAnswer(enteredValues);

    if(answerIsCorrect){

      flutterTts.speak("That's correct");
      flutterTts.completionHandler = () {

        completeIteration();

      };
    } else{
      flutterTts.speak("Please try again");
      flutterTts.completionHandler = () {

        textInputRow.reset.value = true;
        setState(() {
          isError = true;
          isSubmitDisabled = false;
        });

      };
    }
  }

  handleValuesEntered(List<int> values) {
    setState(() {
      enteredValues = [...values];
      isSubmitDisabled = false;
    });
  }

  handleRepeatTextButtonPressed() {
    
    setState(() {
      isSubmitDisabled = true;
    });
    
    flutterTts.speak(task.text);
    flutterTts.completionHandler = () {

      setState(() {
        isSubmitDisabled = false;
      });

    };
  }

  completeIteration(){

    textInputRow.reset.value = true;
    setState(() {

      _iteration = _iteration == numOfIterations ? 1 : _iteration + 1;
      _progress = _iteration / numOfIterations;

    });

    if( _iteration >= numOfIterations){

      if (!mounted) return;

      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (ctx) => const FinalScreen()
        ),
      );
        
    } else {
      init();
    }
  }

  init(){
    task = task.prepareTask();
    textInputRow = TextInputRow(numberOfTextInputs: task.numbers.length, onCompleted: handleValuesEntered);

    setState(() { 
      displayRichText = true;
      displayTextInputs = false;
      enteredValues.clear();
      isSubmitDisabled = true;
      isError = false;
    });

    flutterTts.speak(task.text);
    flutterTts.completionHandler = () {
      setState(() { 

        displayRichText = false; 
        displayAnimation = true;

      });
    };
  }

  _readConfig() async {

    final prefs = await SharedPreferences.getInstance();
    numOfIterations = prefs.getInt('iterations') ?? 10;

  }

  asyncInitState() async =>  await _readConfig();
  
  @override
  initState() {

    super.initState();
    task = MemoryTask.create();

    asyncInitState();
    init();

  }


  @override
  Widget build(BuildContext context) {
  
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Memory"),
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

            if(displayRichText)
              Center(
                child: task.richText
              ),

            if(displayTextInputs)
              Padding(
                padding: const EdgeInsets.only(top: 100),
                child: 
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomFloatingActionButton(
                      isDisabled: false,
                      onPressed: handleRepeatTextButtonPressed,
                      child: const Icon(
                        Icons.replay,
                        color: Colors.black,
                        size: 40,
                      ),   
                    ),
                  ],
                ),
              ),

            if(displayAnimation)
              Center(
                child: DelayIndicator( onCompleted: handleAnimationCompleted, repeatTimes: 5, )
              ),
            
            if(displayTextInputs)
              Center(
                child: textInputRow,
              ),
          ],
        ),
      extendBody: true,
      resizeToAvoidBottomInset : false,
      bottomNavigationBar: BottomNavigationBarContainer(onPress: handleSubmit, isDisabled: isSubmitDisabled),
    );
  }

  
}