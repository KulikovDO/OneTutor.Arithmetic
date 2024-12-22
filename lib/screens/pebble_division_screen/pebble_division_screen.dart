import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:one_tutor_arithmetic/screens/pebble_division_screen/pebbles_provider.dart';
import 'package:one_tutor_arithmetic/screens/pebble_division_screen/widgets/draggable_pebble.dart';
import 'package:one_tutor_arithmetic/screens/pebble_division_screen/widgets/droppable_bucket.dart';
// import 'package:one_tutor_arithmetic/screens/days_of_week_screen/models/days_of_week_task.dart';
// import 'package:one_tutor_arithmetic/screens/days_of_week_screen/models/widgets/tappable_text_container.dart';
// import 'package:one_tutor_arithmetic/screens/final_screen.dart';
// import 'package:one_tutor_arithmetic/screens/pebble_division_screen/models/pebble_division_task.dart';
import 'package:one_tutor_arithmetic/widgets/background.dart';
// import 'package:one_tutor_arithmetic/widgets/bottom_navigation_bar.dart';
// import 'package:one_tutor_arithmetic/widgets/progress_indicator.dart' as pi;
// import 'package:shared_preferences/shared_preferences.dart';


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

  List<GlobalKey<DraggablePebbleState>> draggableKeys = [];
  List<DraggablePebble> draggablePebbles = [];

  List<GlobalKey<DroppableBucketState>> droppableKeys = [];
  List<DroppableBucket> droppableBuckets = [];

  // List<DraggablePebble> droppedPebbles = [];

  // List<List<DraggablePebble>> bucketPebbles = [];

  // Map<GlobalKey, List<DraggablePebble>> bucketPebbles = {};

  handleOnAccepted(GlobalKey<DroppableBucketState> droppableBucketKey, DraggablePebble draggablePebble){

    final map = ref.read(pebblesProvider);
    
    

    
    
    // print("handleOnAccepted");
    
    setState(() {
      draggablePebbles.remove(draggablePebble);
    //   // bucketPebbles[droppableBucketKey]!.add(draggablePebble);
    });

    
    GlobalKey? globalKey;
    bool keyExists = false;
    for(GlobalKey key in map.keys){

      if(map[key]!.contains(draggablePebble)){

        // map[key]!.remove(draggablePebble);
        globalKey = key;

        keyExists = true;

      } 

    }
    
    if(keyExists){
      map[globalKey!] = [];
    }
    
    if(!keyExists) {
      map[droppableBucketKey]!.add(draggablePebble);
    }
    
  }

 
  
  handleDragCompleted(GlobalKey key){
    // print(key);
  }

  @override
  initState() {

    super.initState();

    final map = ref.read(pebblesProvider);

    for(int i = 0; i < 6; i++){
      draggableKeys.add(GlobalKey());
    }

    draggablePebbles = List.generate(/*_numbers.length*/6,(index) => 
      DraggablePebble(key: draggableKeys[index], onDragCompleted: handleDragCompleted,)
    ); 

    for(int i = 0; i < 2; i++){
      droppableKeys.add(GlobalKey());
    }

    droppableBuckets = List.generate(/*_numbers.length*/2,(index) => 
      DroppableBucket(key: droppableKeys[index], onAccepted: handleOnAccepted,)
    ); 

    map.clear();
    for(int i = 0; i < 2; i++){
      // map.update(droppableKeys[i], (m) => []);
      map[droppableKeys[i]] = [];
    }
    


    // task = PebbleDivisionScreenTask.create();

    // asyncInitState();
    // init();

  }

  // init(){

  //   answer = "";
  //   task = task.prepareTask();
  //   flutterTts.speak(task.text);

  // }

  @override
  Widget build(BuildContext context) {

    // ref.listen(pebblesProvider, (prev, now) {
      
    //   print("changes");

    // });

    final container = ProviderScope.containerOf(context);
    container.listen(
        pebblesProvider,
        (prev, now) => print("changes")
      );
    
  
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Pebble Division"),
      ),
      body:
        Stack(
          children: [
            const Background( ),

            // Opacity(
            //   opacity: 0.15,
            //   child: Center(
            //     child: pi.ProgressIndicator(progress: _progress)
            //   ),
            // ),

            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                  

                // Expanded(
                //   child: SizedBox(
                //     width: double.infinity,
                //     child: 
                //       Center(
                //         child: Padding(
                //          padding: const EdgeInsets.only(left: 10, right: 10),
                //          child:
                //             task.richText
                //         ),
                //       ),
                //   )
                // ),

                  Expanded(
                  //flex: 4,
                  
                      child: Wrap(
                        spacing: 0,
                        runSpacing: 0,
                        children: draggablePebbles,
                      ),
                    
                  ),

                Expanded(
                  //flex: 4,
                  child: 
                    Center(
                      child: Wrap(
                        spacing: 10,
                        runSpacing: 10,
                        children: droppableBuckets,
                      ),
                    )
                ),

                // Expanded(
                //   flex: 5,
                //   child: 
                //      Column(
                //       mainAxisAlignment: MainAxisAlignment.center,
                //       crossAxisAlignment: CrossAxisAlignment.center,
                //       children:[
                //         TappableTextContainer(key: GlobalKey(), text: task.answerOptions[0].toString(), selectedText: answer, onTapped: onTapped,),
                //         TappableTextContainer(key: GlobalKey(), text: task.answerOptions[1].toString(), selectedText: answer, onTapped: onTapped,),
                //         TappableTextContainer(key: GlobalKey(), text: task.answerOptions[2].toString(), selectedText: answer, onTapped: onTapped,),
                //       ]
                //     ),
                // ),
              ]
            )
          ],
        ),
      extendBody: true,
      resizeToAvoidBottomInset : false,
      // bottomNavigationBar: BottomNavigationBarContainer(onPress: handleSubmit, isDisabled: answer == ""),
    );
  }
}