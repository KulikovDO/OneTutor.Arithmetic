import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:one_tutor_arithmetic/screens/final_screen.dart';
import 'package:one_tutor_arithmetic/screens/pebble_division_screen/models/pebble_division_task.dart';
import 'package:one_tutor_arithmetic/screens/pebble_division_screen/pebbles_provider.dart';
import 'package:one_tutor_arithmetic/screens/pebble_division_screen/widgets/droppable_bucket.dart';
import 'package:one_tutor_arithmetic/screens/pebble_division_screen/widgets/source_bucket.dart';
import 'package:one_tutor_arithmetic/widgets/text_input_container.dart';
import 'package:one_tutor_arithmetic/widgets/background.dart';
import 'package:one_tutor_arithmetic/widgets/bottom_navigation_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:one_tutor_arithmetic/widgets/progress_indicator.dart' as pi;



FlutterTts flutterTts = FlutterTts();


class PebbleDivisionScreen extends ConsumerStatefulWidget {
  PebbleDivisionScreen({super.key}) 
  {
    flutterTts.setSpeechRate(0.4);
  }

  @override
  ConsumerState<PebbleDivisionScreen> createState() => _PebbleDivisionScreenState();
}


class _PebbleDivisionScreenState extends ConsumerState<PebbleDivisionScreen> {

  List<DroppableBucket> droppableBuckets = [];
  late PebbleDivisionTask task;
  int enteredValue = -1;
  int _iteration = 0;
  int numOfIterations = 10;
  double _progress = 0;
  late SourceBucket sourceBucket;
  bool isError = false;
  late GlobalKey textInputContainerKey;

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
    task = PebbleDivisionTask.create();

    asyncInitState();
    init();

  }

  init(){

    enteredValue = -1;
    isError = false;
    droppableBuckets.clear();
    textInputContainerKey = GlobalKey();

    task = task.prepareTask();

    sourceBucket = SourceBucket( key: GlobalKey(), numOfPebbles: task.numOfPebbles,);

    final map = ref.read(pebblesProvider);
    map.clear();

    
    for(int i = 0; i < task.numOfBuckets; i++){
      GlobalKey key = GlobalKey();
      
      map[key] = [];
      droppableBuckets.add(DroppableBucket(key: key));
    }

    flutterTts.speak(task.text);

  }


  void handleValueEntered(int value){
    setState(() {
      enteredValue = value;
    });
  }

  void handleSubmit() async {

    bool answerIsCorrect = task.checkAnswer(enteredValue);

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
        enteredValue = -1;

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
        title: const Text("Pebble Division"),
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
              children: [
                
                Expanded(child: 
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: task.richText,
                      ),
                      sourceBucket,
                    ]
                  
                  ),
                ),
                  
                Wrap(
                  alignment: WrapAlignment.center,
                  spacing: 10,
                  runSpacing: 10,
                  children: droppableBuckets,
                ),

                if(droppableBuckets.length < 3)
                  const SizedBox(
                    height: 100,
                  ),

                Padding(
                  padding: const EdgeInsets.only(top: 10, bottom: 90),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text( "${task.numOfPebbles} : ${task.numOfBuckets} = ", style:  const TextStyle( fontSize: 50, fontWeight: FontWeight.w500 )),
                      TextInputContainer(key: textInputContainerKey, onValueEntered: handleValueEntered, isError: isError,),
                    ]
                  ),
                ),
               
              ]
            ),
            
          ],
        ),
      extendBody: true,
      resizeToAvoidBottomInset : false,
      bottomNavigationBar: BottomNavigationBarContainer(onPress: handleSubmit, isDisabled: enteredValue == -1),
    );
  }
}