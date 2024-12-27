import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:one_tutor_arithmetic/screens/clock_screen/widgets/clock.dart';
import 'package:one_tutor_arithmetic/widgets/background.dart';


FlutterTts flutterTts = FlutterTts();


class ClockScreen extends StatefulWidget {
  ClockScreen({super.key}) 
  {
    flutterTts.setSpeechRate(0.4);
  }

  @override
  State<ClockScreen> createState() => _ClockScreenState();
}


class _ClockScreenState extends State<ClockScreen> {

  Future<void> speak(String text) async {
    
    await flutterTts.awaitSpeakCompletion(true);
    await flutterTts.speak(text);
    
  }

  @override
  Widget build(BuildContext context) {
  
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Clock"),
      ),
      body:
        const Stack(
          children: [
            Background( ),

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
                
                Center(child: Clock(width: 300.0))

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