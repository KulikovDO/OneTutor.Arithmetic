import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:one_tutor_arithmetic/data/task_name.dart';
import 'package:one_tutor_arithmetic/screens/final_screen.dart';
import 'package:one_tutor_arithmetic/widgets/background.dart';
import 'package:one_tutor_arithmetic/widgets/bottom_navigation_bar.dart';
import 'package:one_tutor_arithmetic/widgets/progress_indicator.dart' as pi;
import 'package:shared_preferences/shared_preferences.dart';

FlutterTts flutterTts = FlutterTts();

Future<void> speak(String text) async {
    
  await flutterTts.awaitSpeakCompletion(true);
  await flutterTts.speak(text);
  
}

class TaskScreen extends StatefulWidget {

  final TaskName taskName;

  TaskScreen({super.key, required this.taskName }) 
  {
    flutterTts.setSpeechRate(0.4);
  }

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {

  int iteration = 0;
  int numOfIterations = 10;
  double progress = 0;
  bool isError = false;
  bool isSubmitDisabled = true;
  // Widget task;
  // Assignment assignment TODO: base abstract class

  handleSubmit(){}

  submitAssignment() async {
    // setState(() {
    //   isSubmitDisabled = true;
    // }); 

    // bool answerIsCorrect = assignment.checkAnswer(enteredValue);

    // if(answerIsCorrect){

    //   await speak("That's correct");
    //   completeAssignment( );

    // } else{

    //   await speak("Please try again");
    //   setState(() {
    //     isError = true;
    //     isSubmitDisabled = false;
    //   });
    // }
  }

  completeAssignment(){

    if (!mounted) return;

    setState(() {

      iteration = iteration == numOfIterations ? 1 : iteration + 1;
      progress = iteration / numOfIterations;

    });

    if( iteration >= numOfIterations){

      if (!mounted) return;

      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (ctx) => const FinalScreen()
        ),
      );
        
    } else {

      initAssignment( );

    }
  }

  initAssignment() async {
    
    // assignment = assignment.prepareTask();

    // setState(() {
    //   enteredValue = -1;
    //   isError = false;
    //   textInputContainerKey = GlobalKey();
    //   isSubmitDisabled = true;
    // });
    
    // await speak(assignment.text);

  }


  readConfig() async {

    final prefs = await SharedPreferences.getInstance();
    numOfIterations = prefs.getInt('iterations') ?? 10;

  }

  @override
  void initState() {
    super.initState();
    readConfig();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text( "Task name" ),
      ),
      body:
        Stack(
          children: [
            const Background( ),

            Opacity(
              opacity: 0.15,
              child: Center(
                child: pi.ProgressIndicator(progress: progress)
              ),
            ),

            // task
            
          ],
        ),
      extendBody: true,
      resizeToAvoidBottomInset : false,
      bottomNavigationBar: BottomNavigationBarContainer(onPress: handleSubmit, isDisabled: isSubmitDisabled),
    );
  }
}

