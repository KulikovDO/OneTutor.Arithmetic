import 'dart:math';
import 'package:flutter/material.dart';
import 'package:collection/collection.dart';


Random rng = Random();
Function eq = const ListEquality().equals;
const numOfOptions = 2; // 1 dollar, 50 cents, 20 cents

class CoinsTask {

  const CoinsTask({
      required this.coins,
      required this.answer,
      required this.answerOptions,
      required this.text,
      required this.richText,
    });

  final List<int> coins;
  final String answer;
  final List<String> answerOptions;
  final String text;
  final Widget richText;

  static CoinsTask create() => const CoinsTask( coins: [], answer: "", answerOptions: [], text: "", richText: Text(""));

  CoinsTask prepareTask(){

    List<int> coins = [];
    
    do{
      
      coins = [];
    

      for(int i = 0; i < numOfOptions; i++){

        coins.add(rng.nextInt(3));

      }

    } while (coins.sum <= 2 || eq(this.coins, coins)); // less than 2 coin

    double answer = calcAnswer(coins);
    String answerText = answerToText(answer);
    List<String> answerOptions = prepareAnswerOptions(answer);

    String text = "How much money there is on the screen?";

    Widget richText = RichText(
      text: TextSpan(
        style: const TextStyle(fontSize: 20, color: Colors.black,),
        children: [
          TextSpan(text: text),
        ],
      ),
    );


    return CoinsTask(coins: coins, answer: answerText, answerOptions: answerOptions, text: text, richText: richText);

  }

  double calcAnswer(List<int> coins){

    double answer = 0;

    for(int i = 0; i < coins.length; i++){
      for(int j = 0; j < coins[i]; j++){

        if(i == 0){
          answer += 1;
        }

        if(i == 1){
          answer += 0.5;
        }

        if(i == 2){
          answer += 0.2;
        }

      }
    }

    return answer;
  }

  String answerToText(double answer){

    String dollars = answer.toString().split('.')[0];
    String cents = answer.toString().split('.')[1];

    if(cents.length > 2){
      
      // cents = int.parse(cents.substring(0, 2)).round().toString();
      cents =
        (
          int.parse(
            cents.substring(0, 2)
          )
          / 10
        )
        .round()
        .toString()
      ;

    }

    if(cents.length == 1){
      cents = (int.parse(cents)*10).toString();
    }

    String answerText = "";

    if(dollars == "1"){
      answerText = "1 dollar";
    } else if(dollars != "0") {
      answerText = "$dollars dollars";
    }

    if(cents != "0"){
      answerText += " $cents cents";
    }

    return answerText;

  }

  List<String> prepareAnswerOptions(double answer){

    List<double> answerOptions = [answer];
    List<String> answerTextOptions = [];

    // TODO: +- smallest coin
    answerOptions.add(answer - 0.5);
    answerOptions.add(answer + 0.5);
    
    // int optionToGenerateAnswers = rng.nextInt(3);

    // if(optionToGenerateAnswers == 0){

    //   answerOptions.add(answer - 0.1);
    //   answerOptions.add(answer + 0.1);

    // } else if(optionToGenerateAnswers == 1){

    //   answerOptions.add(answer + 0.1);
    //   answerOptions.add(answer + 0.2);

    // } else {

    //   answerOptions.add(answer - 0.1);
    //   answerOptions.add(answer - 0.2);

    // } 

    for(double answerOption in answerOptions){
      answerTextOptions.add( answerToText(answerOption) );
    }

    answerTextOptions.shuffle();

    return answerTextOptions;

  }

  bool checkAnswer(String answer) => answer == this.answer;

}