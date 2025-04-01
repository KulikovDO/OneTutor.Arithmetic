import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:one_tutor_arithmetic/screens/memory_screen/models/memory_task.dart';
import 'package:one_tutor_arithmetic/widgets/background.dart';
import 'package:one_tutor_arithmetic/widgets/bottom_navigation_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:one_tutor_arithmetic/widgets/progress_indicator.dart' as pi;



FlutterTts flutterTts = FlutterTts();


class MemoryScreen extends StatefulWidget {
  MemoryScreen({super.key}) 
  {
    flutterTts.setSpeechRate(0.4);
  }

  @override
  State<MemoryScreen> createState() => _MemoryScreenState();
}


class _MemoryScreenState extends State<MemoryScreen> {
  late MemoryTask task;
  int _iteration = 0;
  int numOfIterations = 10;
  double _progress = 0;

  handleSubmit(){
    setState(() {
        
      init();

    });
  }

  init(){

    task = task.prepareTask();
    flutterTts.speak(task.text);

  }

  _readConfig() async {

    final prefs = await SharedPreferences.getInstance();
    numOfIterations = prefs.getInt('iterations') ?? 10;

  }

  asyncInitState() async =>  await _readConfig();
  
  @override
  initState() {

    super.initState();
    task = MemoryTask.create();

    asyncInitState();
    init();

  }

  @override
  Widget build(BuildContext context) {
  
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Memory"),
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
              crossAxisAlignment: CrossAxisAlignment.center,
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
              ]
            )

            
          ],
        ),
      extendBody: true,
      resizeToAvoidBottomInset : false,
      bottomNavigationBar: BottomNavigationBarContainer(onPress: handleSubmit, isDisabled: false),
    );
  }
}