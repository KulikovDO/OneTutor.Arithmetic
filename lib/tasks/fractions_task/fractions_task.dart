import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:one_tutor_arithmetic/tasks/fractions_task/models/fractions_assignment.dart';
import 'package:one_tutor_arithmetic/tasks/fractions_task/widgets/box.dart';
import 'package:one_tutor_arithmetic/tasks/fractions_task/widgets/pie.dart';
import 'package:one_tutor_arithmetic/widgets/text_input_container.dart';


class FractionsTask extends StatefulWidget {
  final Function onValueEntered;
  final Function speakText;

  const FractionsTask({super.key, required this.onValueEntered, required this.speakText});

  @override
  State<FractionsTask> createState() => _FractionsTaskState();
}


class _FractionsTaskState extends State<FractionsTask> {

  late Widget fractionsWidget;
  late FractionsAssignment assignment;
  int nominator = -1;
  int denominator = -1;
  bool isError = false;
  late GlobalKey nominatorTextInputContainerKey;
  late GlobalKey denominatorTextInputContainerKey;
  

  void handleNominatorEntered(int value) {
   setState(() {
     nominator = value;
   }); 

   if(denominator != -1){
    widget.onValueEntered();
   }
  }

  void handleDenominatorEntered(int value) {
    setState(() {
     denominator = value;
   });
   if(nominator != -1){
    widget.onValueEntered();
   }
  }

  @override
  initState() {

    super.initState();
    assignment = FractionsAssignment.create();

    initAssignment();

  }

  initAssignment(){

    setState(() {
      nominator = -1;
      denominator = -1;
      isError = false;  
    });
    
    nominatorTextInputContainerKey = GlobalKey();
    denominatorTextInputContainerKey = GlobalKey();

    assignment = assignment.prepareTask();

    FlutterView view = PlatformDispatcher.instance.views.first;
    double screenWidth = view.physicalSize.width / view.devicePixelRatio;

    fractionsWidget = 
      assignment.isCircle
        ?
      Pie(key: GlobalKey(), size: 0.8 * screenWidth, overallFractions: assignment.overallFractions, coloredFractions: assignment.coloredFractions, color: assignment.color,)
        :
      Box(key: GlobalKey(), size: 0.9 * screenWidth, overallFractions: assignment.overallFractions, coloredFractions: assignment.coloredFractions, color: assignment.color,)
      ;

    widget.speakText(assignment.text);

  }

  bool checkAnswer() { 
    bool isAnswerCorrect = assignment.checkAnswer(nominator, denominator); 

    if(!isAnswerCorrect){
      setState(() {
        isError = true;
      });
    } else {
      setState(() {
        isError = false;
      });
    }

    return isAnswerCorrect;
  }

  @override
  Widget build(BuildContext context) {

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [

        Padding(
          padding: const EdgeInsets.all(4.0),
          child: assignment.richText,
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
    );
  }
}
