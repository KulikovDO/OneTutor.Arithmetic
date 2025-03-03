import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:one_tutor_arithmetic/screens/coins_screen/models/coins_task.dart';
import 'package:one_tutor_arithmetic/screens/coins_screen/widgets/fifty_cents.dart';
import 'package:one_tutor_arithmetic/screens/coins_screen/widgets/one_dollar.dart';
import 'package:one_tutor_arithmetic/screens/coins_screen/widgets/tappable_text_container.dart';
import 'package:one_tutor_arithmetic/screens/coins_screen/widgets/twenty_cents.dart';
import 'package:one_tutor_arithmetic/screens/final_screen.dart';
import 'package:one_tutor_arithmetic/screens/pebble_division_screen/widgets/droppable_bucket.dart';
import 'package:one_tutor_arithmetic/widgets/background.dart';
import 'package:one_tutor_arithmetic/widgets/bottom_navigation_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:one_tutor_arithmetic/widgets/progress_indicator.dart' as pi;


FlutterTts flutterTts = FlutterTts();


class CoinsScreen extends StatefulWidget {
  CoinsScreen({super.key}) 
  {
    flutterTts.setSpeechRate(0.4);
  }

  @override
  State<CoinsScreen> createState() => _CoinsScreenState();
}


class _CoinsScreenState extends State<CoinsScreen> {

  List<DroppableBucket> droppableBuckets = [];
  late CoinsTask task;
  String answer = "";
  int _iteration = 0;
  int numOfIterations = 10;
  double _progress = 0;
  List<Widget> coins = [];
  
  Future<void> speak(String text) async {
    
    await flutterTts.awaitSpeakCompletion(true);
    await flutterTts.speak(text);
    
  }

  asyncInitState() async =>  await _readConfig();

  _readConfig() async {

    final prefs = await SharedPreferences.getInstance();
    numOfIterations = prefs.getInt('iterations') ?? 10;

  }

  @override
  initState() {

    super.initState();
    task = CoinsTask.create();

    asyncInitState();
    init();

  }

  init(){

    answer = "";
    
    coins.clear();

    task = task.prepareTask();

    for(int i = 0; i < task.coins.length; i++){
      for(int j = 0; j < task.coins[i]; j++){

        if(i == 0){
          coins.add(OneDollar(key: GlobalKey()));
        }

        if(i == 1){
          coins.add(FiftyCents(key: GlobalKey()));
        }

        if(i == 2){
          coins.add(TwentyCents(key: GlobalKey()));
        }

      }

    }

    flutterTts.speak(task.text);

  }

  handleOnTapped(String value){
    
    setState(() {
      answer = value;
    });

  }

  void handleSubmit() async {

    bool answerIsCorrect = task.checkAnswer(answer);

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

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Coins"),
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
                  child: Wrap(
                    spacing: 5,
                    runSpacing: 5,
                    // alignment: WrapAlignment.center,
                    // runAlignment: WrapAlignment.center,
                    children: 
                      coins,
                  ),
                ),
                

                Expanded(
                  flex: 5,
                  child: 
                     Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children:[
                        TappableTextContainer(key: GlobalKey(), text: task.answerOptions[0].toString(), selectedText: answer, onTapped: handleOnTapped,),
                        TappableTextContainer(key: GlobalKey(), text: task.answerOptions[1].toString(), selectedText: answer, onTapped: handleOnTapped,),
                        TappableTextContainer(key: GlobalKey(), text: task.answerOptions[2].toString(), selectedText: answer, onTapped: handleOnTapped,),
                      ]
                    ),
                ),
                    
               
              ]
            ),
            
          ],
        ),
      extendBody: true,
      resizeToAvoidBottomInset : false,
      bottomNavigationBar: BottomNavigationBarContainer(onPress: handleSubmit, isDisabled: answer == ""),
    );
  }
}