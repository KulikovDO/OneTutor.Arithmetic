import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:one_tutor_arithmetic/data/task_name.dart';
import 'package:one_tutor_arithmetic/misc/extensions.dart';
import 'package:one_tutor_arithmetic/screens/final_screen.dart';
import 'package:one_tutor_arithmetic/tasks/decomposition_task/decomposition_task.dart';
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
  bool isSubmitDisabled = true;
  GlobalKey<DecompositionTaskState> globalKey = GlobalKey<DecompositionTaskState>();

  // Widget task = DecompositionTask(onValueEntered: handleValueEntered);
  
  handleSpeakText(String text) async => await speak(text);

  
  handleValueEntered(int value){
    setState(() {
      isSubmitDisabled = false;
    });
  }



  handleSubmit() async {

    setState(() {
      isSubmitDisabled = true;
    }); 

    bool answerIsCorrect = globalKey.currentState!.checkAnswer();

    if(answerIsCorrect){

      await speak("That's correct");
      if (!mounted) return;
      completeIteration( );

    } else{

      await speak("Please try again");
      if (!mounted) return;
      setState(() {
        isSubmitDisabled = false;
      });

    }

  }


  completeIteration(){

    if (!mounted) return;

    setState(() {

      iteration = iteration == numOfIterations ? 1 : iteration + 1;
      progress = iteration / numOfIterations;

    });

    if(iteration >= numOfIterations){

      if (!mounted) return;

      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (ctx) => const FinalScreen()
        ),
      );
        
    } else {

      globalKey.currentState!.initAssignment( );
      setState(() {
        isSubmitDisabled = true;
      });

    }
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
        title: Text( widget.taskName.name.capitalize() ),
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

            DecompositionTask(key: globalKey, onValueEntered: handleValueEntered, speakText: handleSpeakText,)
            
          ],
        ),
      extendBody: true,
      resizeToAvoidBottomInset : false,
      bottomNavigationBar: BottomNavigationBarContainer(onPress: handleSubmit, isDisabled: isSubmitDisabled),
    );
  }
}

