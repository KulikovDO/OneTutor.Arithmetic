import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:one_tutor_arithmetic/screens/final_screen.dart';
import 'package:one_tutor_arithmetic/screens/fractions_screen/models/fractions_task.dart';
import 'package:one_tutor_arithmetic/screens/fractions_screen/widgets/box.dart';
import 'package:one_tutor_arithmetic/screens/fractions_screen/widgets/pie.dart';
import 'package:one_tutor_arithmetic/widgets/background.dart';
import 'package:one_tutor_arithmetic/widgets/bottom_navigation_bar.dart';
import 'package:one_tutor_arithmetic/widgets/text_input_container.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:one_tutor_arithmetic/widgets/progress_indicator.dart' as pi;


FlutterTts flutterTts = FlutterTts();


class FractionsScreen extends StatefulWidget {
  FractionsScreen({super.key}) 
  {
    flutterTts.setSpeechRate(0.4);
  }

  @override
  State<FractionsScreen> createState() => _FractionsScreenState();
}


class _FractionsScreenState extends State<FractionsScreen> {

  late Widget fractionsWidget;
  late FractionsTask task;
  int nominator = -1;
  int denominator = -1;
  int _iteration = 0;
  int numOfIterations = 10;
  double _progress = 0;
  bool isError = false;
  late GlobalKey nominatorTextInputContainerKey;
  late GlobalKey denominatorTextInputContainerKey;
  
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
    isError = false;
    nominatorTextInputContainerKey = GlobalKey();
    denominatorTextInputContainerKey = GlobalKey();

    task = task.prepareTask();

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
                        TextInputContainer(key: nominatorTextInputContainerKey, onValueEntered: handleNominatorEntered, isError: isError,),
                        const Text("/", style: TextStyle(fontSize: 45),),
                        TextInputContainer(key: denominatorTextInputContainerKey, onValueEntered: handleDenominatorEntered, isError: isError,),
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