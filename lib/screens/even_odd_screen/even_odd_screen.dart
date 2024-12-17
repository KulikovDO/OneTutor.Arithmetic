import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:one_tutor_arithmetic/screens/even_odd_screen/widgets/tappable_text_contrainer.dart';
import 'package:one_tutor_arithmetic/screens/final_screen.dart';
import 'package:one_tutor_arithmetic/widgets/background.dart';
import 'package:one_tutor_arithmetic/widgets/bottom_navigation_bar.dart';
import 'package:one_tutor_arithmetic/widgets/progress_indicator.dart' as pi;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:collection/collection.dart';


FlutterTts flutterTts = FlutterTts();
var rng = Random();
Function unOrdDeepEq = const DeepCollectionEquality.unordered().equals;


class EvenOddScreen extends StatefulWidget {
  EvenOddScreen({super.key}) 
  {
    flutterTts.setSpeechRate(0.4);
  }

  @override
  State<EvenOddScreen> createState() => _EvenOddScreenState();
}


class _EvenOddScreenState extends State<EvenOddScreen> {

  List<String> numbers = [];
  List<String> selectedNumbers = [];
  int isEven = 1;

  List<Widget> tappableTextContainerList = [];
  int _iteration = 0;
  int numOfIterations = 10;
  double _progress = 0;
  final List<String> description = [ "Select the odd numbers", "Select the even numbers"];

  Future<void> speak(String text) async {
    
    await flutterTts.awaitSpeakCompletion(true);
    await flutterTts.speak(text);
    
  }

  List<String> generateNumbers(){

    List<String> numbers = [];
    
    int number = 0;

    for(int i = 0; i < 6; i++)
    {

      do
      {
        number = rng.nextInt( 30 ) + 1;
      }
      while(numbers.contains(number.toString()));

      numbers.add(number.toString());

    }

    return numbers;

  }

  Future<bool> checkAnswer() async{

    List<String> evenNumbers = [];
    List<String> oddNumbers = [];

    for(String number in numbers){
      if(int.parse(number)%2 == 0){
        evenNumbers.add(number);
      } else {
        oddNumbers.add(number);
      }
    }

    bool answerIsCorrect = isEven == 1 ? unOrdDeepEq(selectedNumbers, evenNumbers) : unOrdDeepEq(selectedNumbers, oddNumbers);

    if(answerIsCorrect){
      await speak("That's correct");
    } else {
      await speak("Please try again");
    }

    return answerIsCorrect;

  }


  handleSubmit() async{

    bool answerIsCorrect = await checkAnswer();

    if(answerIsCorrect){

      setState(() {
        
        _iteration = _iteration == numOfIterations ? 1 : _iteration + 1;
        _progress = _iteration / numOfIterations;

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

        flutterTts.speak(description[isEven]);
      }
    } 

  }

  _readConfig() async {

    final prefs = await SharedPreferences.getInstance();
    numOfIterations = prefs.getInt('iterations') ?? 10;

  }

  onTapped(String number, bool isSelected){
    
    if(isSelected){
      selectedNumbers.add(number);
    } else {
      selectedNumbers.removeWhere((item) => item == number);
    }

  }


  init() {

    isEven = rng.nextInt(2);
    numbers.clear();
    numbers.addAll(generateNumbers());
    selectedNumbers.clear();
    tappableTextContainerList.clear();

    for(String number in numbers){

      tappableTextContainerList.add(TappableTextContainer(key: GlobalKey(), text: number, onTapped: onTapped,));

    }

  }

  asyncInitState() async =>  await _readConfig();
  

  @override
  initState() {

    super.initState();
    init();
    asyncInitState();

    flutterTts.speak(description[isEven]);

  }

  @override
  Widget build(BuildContext context) {
  
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Even and Odd Numbers"),
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
              children: [

                Expanded(
                  child: SizedBox(
                    width: double.infinity,
                    child: 
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          child: Text( description[isEven], style:  const TextStyle( fontSize: 20, fontWeight: FontWeight.w500 ))
                        ),
                      ),
                  )
                ),

                Expanded(
                  flex: 5,
                  child: 
                    Wrap(
                      spacing: 20,
                      runSpacing: 20,
                      children: tappableTextContainerList,
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