import 'dart:math';
import 'package:one_tutor_arithmetic/model/task.dart';


var rng = Random();

class MultiplicationOperation{

  static Task prepareTask(int prevFirstNumber, int prevSecondNumber){
      
    int firstNumber = 0;
    int secondNumber = 0;

    do{
      
      firstNumber = rng.nextInt( 5 ) + 1;
      secondNumber = rng.nextInt( 5 ) + 1;

    }
    while( firstNumber == prevFirstNumber && secondNumber == prevSecondNumber );

    final text = 'How much is $firstNumber times $secondNumber?';

    return Task(firstNumber: firstNumber, secondNumber: secondNumber, text: text, operationSymbol: "*");

  }

  static bool checkAnswer(Task task, int enteredValue) => task.firstNumber * task.secondNumber == enteredValue;

}