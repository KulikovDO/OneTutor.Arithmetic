import 'package:flutter/material.dart';
import 'package:one_tutor_arithmetic/tasks/coins_task/models/coins_assignment.dart';
import 'package:one_tutor_arithmetic/tasks/coins_task/widgets/fifty_cents.dart';
import 'package:one_tutor_arithmetic/tasks/coins_task/widgets/one_dollar.dart';
import 'package:one_tutor_arithmetic/widgets/tappable_text_container.dart';
import 'package:one_tutor_arithmetic/tasks/coins_task/widgets/twenty_cents.dart';


class CoinsTask extends StatefulWidget {
  
  final Function onValueEntered;
  final Function speakText;
  
  const CoinsTask({super.key, required this.onValueEntered, required this.speakText});

  @override
  State<CoinsTask> createState() => _CoinsTaskState();
}


class _CoinsTaskState extends State<CoinsTask> {

  late CoinsAssignment assignment;
  String enteredValue = "";
  List<Widget> coins = [];
  bool isError = false;

  bool checkAnswer() { 
    bool isAnswerCorrect = assignment.checkAnswer(enteredValue); 

    setState(() {
      isError = !isAnswerCorrect;
    });

    return isAnswerCorrect;
  }

  
  @override
  initState() {

    super.initState();
    assignment = CoinsAssignment.create();

    initAssignment();

  }

  initAssignment(){

    assignment = assignment.prepareTask();
    
    setState(() {
      enteredValue = "";
      coins.clear();
      isError = false;
      for(int i = 0; i < assignment.coins.length; i++){
        for(int j = 0; j < assignment.coins[i]; j++){

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
    });

    widget.speakText(assignment.text);

  }

  handleOnTapped(String value){
    
    setState(() {
      enteredValue = value;
    });

    widget.onValueEntered();

  }

  

  @override
  Widget build(BuildContext context) {

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      // mainAxisAlignment: MainAxisAlignment.center,
      children: [

        Padding(
          padding: const EdgeInsets.all(4.0),
          child: assignment.richText,
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
                // TODO: isError
                TappableTextContainer(key: GlobalKey(), mainText: assignment.answerOptions[0].toString(), additionalText: "", isFullWidth: true, selectedText: enteredValue, onTapped: handleOnTapped,),
                TappableTextContainer(key: GlobalKey(), mainText: assignment.answerOptions[1].toString(), additionalText: "", isFullWidth: true, selectedText: enteredValue, onTapped: handleOnTapped,),
                TappableTextContainer(key: GlobalKey(), mainText: assignment.answerOptions[2].toString(), additionalText: "", isFullWidth: true, selectedText: enteredValue, onTapped: handleOnTapped,),
              ]
            ),
        ),
            
        
      ]
    );
  }
}