import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:one_tutor_arithmetic/screens/final_screen.dart';
import 'package:one_tutor_arithmetic/screens/more_less_screen/models/more_less_task.dart';
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

  late MoreLessTask task;

  var richText = RichText(
        text: TextSpan(
          style: const TextStyle(fontSize: 20, color: Colors.black,),
          children: [
            TextSpan(text: 5.toString(), style: const TextStyle(fontWeight: FontWeight.bold)),
            const TextSpan(text: " is "),
            TextSpan(text: 10.toString(), style: const TextStyle(fontWeight: FontWeight.bold)),
            const TextSpan(text: " less than which number?"),
          ],
        ),
      );
  

  @override
  initState() {

    super.initState();
    task = MoreLessTask.create();

    // asyncInitState();
    init();

  }

  init(){

    task = task.prepareTask();
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
                          // Text( task.text, style: const TextStyle( fontSize: 20, fontWeight: FontWeight.w500 ))
                            task.richText
 
                            
       
                        ),
                      ),
                  )
                ),

                // Expanded(
                //   flex: 5,
                //   child: 
                //     Wrap(
                //       spacing: 20,
                //       runSpacing: 20,
                //       children: tappableTextContainerList,
                //     )
                // ),
              ]
            )
          ],
        ),
      extendBody: true,
      resizeToAvoidBottomInset : false,
      // bottomNavigationBar: BottomNavigationBarContainer(onPress: handleSubmit, isDisabled: false),
    );
  }
}