import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:one_tutor_arithmetic/screens/decomposition_screen/models/decomposition_task.dart';
import 'package:one_tutor_arithmetic/screens/final_screen.dart';
import 'package:one_tutor_arithmetic/widgets/background.dart';
import 'package:one_tutor_arithmetic/widgets/bottom_navigation_bar.dart';
import 'package:one_tutor_arithmetic/widgets/text_input_container.dart';
import 'package:one_tutor_arithmetic/widgets/progress_indicator.dart' as pi;
import 'package:shared_preferences/shared_preferences.dart';


FlutterTts flutterTts = FlutterTts();

Future<void> speak(String text) async {
    
  await flutterTts.awaitSpeakCompletion(true);
  await flutterTts.speak(text);
  
}


class DecompositionScreen extends StatefulWidget {
  DecompositionScreen({super.key}) 
  {
    flutterTts.setSpeechRate(0.4);
  }
  @override
  State<DecompositionScreen> createState() => _DecompositionScreenState();
}


class _DecompositionScreenState extends State<DecompositionScreen> {

  int _iteration = 0;
  int numOfIterations = 10;
  double _progress = 0;
  late DecompositionTask task;
  int enteredValue = -1;
  bool isError = false;
  bool isSubmitDisabled = true;
  late GlobalKey textInputContainerKey;

  handleValueEntered(int value){
    setState(() {
      enteredValue = value;
      isSubmitDisabled = false;
    });
  }

  handleSubmit() async {

    setState(() {
      isSubmitDisabled = true;
    }); 

    bool answerIsCorrect = task.checkAnswer(enteredValue);

    if(answerIsCorrect){

      await speak("That's correct");
      completeIteration( );

    } else{

      await speak("Please try again");
      setState(() {
        isError = true;
        isSubmitDisabled = false;
      });

    }

  }

  completeIteration(){

    if (!mounted) return;

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

      init( );

    }
  }

  asyncInitState() async => await _readConfig();

  _readConfig() async {

    final prefs = await SharedPreferences.getInstance();
    numOfIterations = prefs.getInt('iterations') ?? 10;

  }

  init() async {
    task = task.prepareTask();
    setState(() {
      enteredValue = -1;
      isError = false;
      textInputContainerKey = GlobalKey();
      isSubmitDisabled = true;
    });
    
    await speak(task.text);

    // flutterTts.speak(task.text);
    // flutterTts.completionHandler = () {
    //   setState(() {
    //   });
    // };
  }

  @override
  void initState() {
    super.initState();
    task = DecompositionTask.create().prepareTask();
    asyncInitState();
    init();
  }

  @override
  Widget build(BuildContext context) {
  
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Decomposition"),
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
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [

                Expanded(
                  child: SizedBox(
                    width: double.infinity,
                    child: 
                      Center(
                        child: Padding(
                         padding: const EdgeInsets.only(left: 10, right: 10),
                         child:
                            task.richText
                        ),
                      ),
                  )
                ),

                Expanded(
                  flex: 5,
                  child: 
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children:[
                        Text("${task.sum} = ${task.firstNumber} + ", style: const TextStyle( fontSize: 50, fontWeight: FontWeight.w500 )),
                        TextInputContainer(key: textInputContainerKey, isError: isError, onValueEntered: handleValueEntered ),
                      ]
                    ),
                ),
              ]
            )

            

            
          ],
        ),
      extendBody: true,
      resizeToAvoidBottomInset : false,
      bottomNavigationBar: BottomNavigationBarContainer(onPress: handleSubmit, isDisabled: isSubmitDisabled),
    );
  }
}