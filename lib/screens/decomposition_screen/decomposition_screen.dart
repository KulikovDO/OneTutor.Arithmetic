import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:one_tutor_arithmetic/widgets/background.dart';



FlutterTts flutterTts = FlutterTts();


class DecompositionScreen extends StatefulWidget {
  DecompositionScreen({super.key}) 
  {
    flutterTts.setSpeechRate(0.4);
  }

  @override
  State<DecompositionScreen> createState() => _DecompositionScreenState();
}


class _DecompositionScreenState extends State<DecompositionScreen> {


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
            
            // Opacity(
            //   opacity: 0.15,
            //   child: Center(
            //     child: pi.ProgressIndicator(progress: _progress)
            //   ),
            // ),

            
          ],
        ),
      extendBody: true,
      resizeToAvoidBottomInset : false,
      // bottomNavigationBar: BottomNavigationBarContainer(onPress: handleSubmit, isDisabled: false),
    );
  }
}