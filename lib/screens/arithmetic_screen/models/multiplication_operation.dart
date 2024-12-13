import 'dart:math';
// import 'package:one_tutor_arithmetic/model/task.dart';
import 'package:one_tutor_arithmetic/data/arithmetic_operation.dart';
import 'package:one_tutor_arithmetic/screens/arithmetic_screen/models/arithmetic_task.dart';


var rng = Random();

class MultiplicationOperation{

  static ArithmeticTask prepareTask(int prevFirstNumber, int prevSecondNumber){
      
    int firstNumber = 0;
    int secondNumber = 0;

    do{
      
      firstNumber = rng.nextInt( 5 ) + 1;
      secondNumber = rng.nextInt( 5 ) + 1;

    }
    while( firstNumber == prevFirstNumber && secondNumber == prevSecondNumber );

    final text = 'How much is $firstNumber times $secondNumber?';

    return ArithmeticTask(
      firstNumber: firstNumber, 
      secondNumber: secondNumber, 
      text: text, 
      operationSymbol: "*",
      arithmeticOperation: ArithmeticOperation.multiplication,
    );

  }

  static bool checkAnswer(ArithmeticTask task, int enteredValue) => task.firstNumber * task.secondNumber == enteredValue;

}