import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:one_tutor_arithmetic/screens/fractions_screen/widgets/text_input_container.dart';
import 'package:one_tutor_arithmetic/screens/final_screen.dart';
import 'package:one_tutor_arithmetic/screens/fractions_screen/models/fractions_task.dart';
import 'package:one_tutor_arithmetic/screens/fractions_screen/widgets/box.dart';
import 'package:one_tutor_arithmetic/screens/fractions_screen/widgets/pie.dart';
import 'package:one_tutor_arithmetic/widgets/background.dart';
import 'package:one_tutor_arithmetic/widgets/bottom_navigation_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:one_tutor_arithmetic/widgets/progress_indicator.dart' as pi;


FlutterTts flutterTts = FlutterTts();


class FractionsScreen extends ConsumerStatefulWidget {
  FractionsScreen({super.key}) 
  {
    flutterTts.setSpeechRate(0.4);
  }

  @override
  ConsumerState<FractionsScreen> createState() => _FractionsScreenState();
}


class _FractionsScreenState extends ConsumerState<FractionsScreen> {

  late Widget fractionsWidget;
  late Widget textInputContainerNominator;
  late Widget textInputContainerDenominator;
  late FractionsTask task;
  int nominator = -1;
  int denominator = -1;
  int _iteration = 0;
  int numOfIterations = 10;
  double _progress = 0;
  
  Future<void> speak(String text) async {
    
    await flutterTts.awaitSpeakCompletion(true);
    await flutterTts.speak(text);
    
  }

  asyncInitState() async =>  await _readConfig();

  _readConfig() async {

    final prefs = await SharedPreferences.getInstance();
    numOfIterations = prefs.getInt('iterations') ?? 10;

  }

  void handleNominatorEntered(int value) {
   setState(() {
     nominator = value;
   }); 
  }

  void handleDenominatorEntered(int value) {
    setState(() {
     denominator = value;
   }); 
  }

  @override
  initState() {

    super.initState();
    task = FractionsTask.create();

    asyncInitState();
    init();

  }

  init(){

    nominator = -1;
    denominator = -1;

    task = task.prepareTask();

    textInputContainerNominator = TextInputContainer(key: GlobalKey(), text: "?", onValueEntered: handleNominatorEntered);
    textInputContainerDenominator = TextInputContainer(key: GlobalKey(), text: "?", onValueEntered: handleDenominatorEntered);

    FlutterView view = PlatformDispatcher.instance.views.first;
    double screenWidth = view.physicalSize.width / view.devicePixelRatio;

    fractionsWidget = 
      task.isCircle
        ?
      Pie(key: GlobalKey(), size: 0.8 * screenWidth, overallFractions: task.overallFractions, coloredFractions: task.coloredFractions, color: task.color,)
        :
      Box(key: GlobalKey(), size: 0.9 * screenWidth, overallFractions: task.overallFractions, coloredFractions: task.coloredFractions, color: task.color,)
      ;

    flutterTts.speak(task.text);

  }



  void handleSubmit() async {

    bool answerIsCorrect = task.checkAnswer(nominator, denominator);

     if(answerIsCorrect){
      await speak("That's correct");
    } else {
      await speak("Please try again");
    }

    if(answerIsCorrect){

      setState(() {
        
        _iteration = _iteration == numOfIterations ? 1 : _iteration + 1;
        _progress = _iteration / numOfIterations;
        nominator = -1;
        denominator = -1;

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
        title: const Text("Fractions"),
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
              crossAxisAlignment: CrossAxisAlignment.center,
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [

                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: task.richText,
                ),

                const SizedBox(
                  height: 50.0,
                ),

                

                Center(
                  child: fractionsWidget,
                ),
                

                Expanded(
                  flex: 5,
                  child: 
                     Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children:[
                        textInputContainerNominator,
                        const Text("/", style: TextStyle(fontSize: 45),),
                        textInputContainerDenominator,
                      ]
                    ),
                ),
                    
               
              ]
            ),
            
          ],
        ),
      extendBody: true,
      resizeToAvoidBottomInset : false,
      bottomNavigationBar: BottomNavigationBarContainer(onPress: handleSubmit, isDisabled: nominator == -1 || denominator == -1),
    );
  }
}