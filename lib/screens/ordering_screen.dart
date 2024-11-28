import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:one_tutor_arithmetic/widgets/background.dart';
import 'package:one_tutor_arithmetic/widgets/bottom_navigation_bar.dart';
import 'package:one_tutor_arithmetic/widgets/draggable_text_container.dart';
import 'package:one_tutor_arithmetic/widgets/droppable_text_container.dart';


FlutterTts flutterTts = FlutterTts();
var rng = Random();


class OrderingScreen extends StatefulWidget {
  OrderingScreen({super.key}) 
  {
    flutterTts.setSpeechRate(0.4);
  }

  @override
  State<OrderingScreen> createState() => _OrderingScreenState();
}


class _OrderingScreenState extends State<OrderingScreen> {

  final List<String> description = ["Put these numbers in order from highest to lowest", "Put these numbers in order from lowest to highest"];

  int? _acceptedData;
  final List<String> _numbers = [];
  int shouldReset = 0;
  int order = 0;
  
  List<GlobalKey<DroppableTextContainerState>> widgetKeys = [];

  onAccepted(int data){

    setState(() {
      _acceptedData = data; 
    });
    
  }

  void _handleSubmit() {

    // print(widgetKeys.length);

    // for(var widgetKey in widgetKeys)
    // {
    //   print(widgetKey.currentState!.acceptedData);
    // }

    setState(() {
      _acceptedData = null; 
      _numbers.clear();
      _numbers.addAll(_generateNumbers());
      order = rng.nextInt( 2 );
      shouldReset++;
    });

    flutterTts.speak(description[order]);

  }

  List<String> _generateNumbers(){

    List<String> numbers = [];
    
    int number = 0;

    for(int i = 0; i < 3; i++)
    {

      do
      {
        number = rng.nextInt( 10 ) + 1;
      }
      while(numbers.contains(number.toString()));

      numbers.add(number.toString());

    }

    return numbers;

  }

  @override
  initState() {

    super.initState();
    order = rng.nextInt( 2 );
    _numbers.addAll(_generateNumbers());

    for(int i = 0; i < 3; i++){
      widgetKeys.add(GlobalKey());
    }

    flutterTts.speak(description[order]);

  }

  @override
  Widget build(BuildContext context) {
  
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Ordering"),
      ),
      body:
        Stack(
            children: [
              const Background( ),
        
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
                      child: Text( description[order], style:  const TextStyle( fontSize: 20, fontWeight: FontWeight.w500 ))
                    ),
                  ),
              )
            ),

            Expanded(
              flex: 3,
              child: SizedBox(
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(_numbers.length,(index) => 
                        DraggableTextContainer(acceptedData: _acceptedData, text: _numbers[index], shouldReset: shouldReset,)
                      ),
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate( _numbers.length, (index) => 
                        DroppableTextContainer(key: widgetKeys[index], onAccepted: onAccepted, shouldReset: shouldReset,)
                      ),
                    ),
                  ],
                  ),
                ),
              ),
            
            const Expanded(
              child: SizedBox(
                width: double.infinity,
              )
            ),
            ],
          ),
          ]
        ),
      extendBody: true,
      bottomNavigationBar: BottomNavigationBarContainer(onPress: _handleSubmit,),
    );
  }
  
  

}