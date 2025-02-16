import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:one_tutor_arithmetic/screens/final_screen.dart';
import 'package:one_tutor_arithmetic/screens/more_less_screen/models/more_less_task.dart';
import 'package:one_tutor_arithmetic/screens/more_less_screen/widgets/tappable_text_container.dart';
import 'package:one_tutor_arithmetic/widgets/background.dart';
import 'package:one_tutor_arithmetic/widgets/bottom_navigation_bar.dart';
import 'package:one_tutor_arithmetic/widgets/progress_indicator.dart' as pi;
import 'package:shared_preferences/shared_preferences.dart';


FlutterTts flutterTts = FlutterTts();
var rng = Random();


class MoreLessScreen extends StatefulWidget {
  MoreLessScreen({super.key}) 
  {
    flutterTts.setSpeechRate(0.4);
  }

  @override
  State<MoreLessScreen> createState() => _MoreLessScreenState();
}


class _MoreLessScreenState extends State<MoreLessScreen> {

  Future<void> speak(String text) async {
    
    await flutterTts.awaitSpeakCompletion(true);
    await flutterTts.speak(text);
    
  }

  late MoreLessTask task;
  List<Widget> tappableTextContainerList = [];
  String answer = "";
  int _iteration = 0;
  int numOfIterations = 10;
  double _progress = 0;


  handleSubmit() async{

    bool answerIsCorrect = answer == task.answer.toString();

     if(answerIsCorrect){
      await speak("That's correct");
    } else {
      await speak("Please try again");
    }

    if(answerIsCorrect){

      setState(() {
        
        _iteration = _iteration == numOfIterations ? 1 : _iteration + 1;
        _progress = _iteration / numOfIterations;
        answer = "";

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

  _readConfig() async {

    final prefs = await SharedPreferences.getInstance();
    numOfIterations = prefs.getInt('iterations') ?? 10;

  }

  onTapped(String number){
    
    setState(() {
      answer = number;
    });

  }

  asyncInitState() async =>  await _readConfig();
  

  @override
  initState() {

    super.initState();
    task = MoreLessTask.create();

    asyncInitState();
    init();

  }


  init() {

    task = task.prepareTask();
    tappableTextContainerList.clear();
    flutterTts.speak(task.text);

  }

  @override
  Widget build(BuildContext context) {
  
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("More or Less Numbers"),
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
                        TappableTextContainer(key: GlobalKey(), text: task.answerOptions[0].toString(), selectedText: answer, onTapped: onTapped,),
                        TappableTextContainer(key: GlobalKey(), text: task.answerOptions[1].toString(), selectedText: answer, onTapped: onTapped,),
                        TappableTextContainer(key: GlobalKey(), text: task.answerOptions[2].toString(), selectedText: answer, onTapped: onTapped,),
                      ]
                    ),
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