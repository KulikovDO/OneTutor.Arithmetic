import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:one_tutor_arithmetic/screens/final_screen.dart';
import 'package:one_tutor_arithmetic/screens/sequence_screen/widgets/text_container.dart';
import 'package:one_tutor_arithmetic/screens/sequence_screen/widgets/text_input_container.dart';
import 'package:one_tutor_arithmetic/widgets/background.dart';
import 'package:one_tutor_arithmetic/widgets/bottom_navigation_bar.dart';
import 'package:one_tutor_arithmetic/widgets/progress_indicator.dart' as pi;
import 'package:shared_preferences/shared_preferences.dart';


FlutterTts flutterTts = FlutterTts();
var rng = Random();


class SequenceScreen extends StatefulWidget {
  SequenceScreen({super.key}) 
  {
    flutterTts.setSpeechRate(0.4);
  }

  @override
  State<SequenceScreen> createState() => _SequenceScreenState();
}


class _SequenceScreenState extends State<SequenceScreen> {

  Future<void> speak(String text) async {
    
    await flutterTts.awaitSpeakCompletion(true);
    await flutterTts.speak(text);
    
  }


  int missingValue = -1;
  int enteredValue = -1;
  String description = "What is the missing number?";
  List<Widget> textContainerList = [];
  int _iteration = 0;
  int numOfIterations = 10;
  double _progress = 0;

  handleSubmit() async{

    bool answerIsCorrect = missingValue == enteredValue;

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

    enteredValue = -1;
    int start = rng.nextInt( 20 -  6 );
    int missingNumberIndex = rng.nextInt( 4 ) + 1;

    textContainerList.clear();

    for(var i = 0; i < 6; i++){

      if(i == missingNumberIndex){
        textContainerList.add(TextInputContainer(key: GlobalKey(), text: "?", onValueEntered: onValueEntered,));
        missingValue = start + i;
      } else {
        textContainerList.add(TextContainer(key: GlobalKey(), text: (start + i).toString()));
      }

    }

  }

  asyncInitState() async {
    await _readConfig();
  }

  @override
  initState() {

    super.initState();
    init();
    asyncInitState();

    flutterTts.speak(description);

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
                            child: Text( description, style: const TextStyle( fontSize: 20, fontWeight: FontWeight.w500 ))
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