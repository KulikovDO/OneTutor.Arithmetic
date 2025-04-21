import 'dart:math';
import 'package:one_tutor_arithmetic/data/arithmetic_operation.dart';
import 'package:one_tutor_arithmetic/tasks/arithmetic_task/models/arithmetic_assignment.dart';


Random rng = Random();

class SubtractionOperation{

  static ArithmeticAssignment prepareTask(int prevFirstNumber, int prevSecondNumber){
      
    int firstNumber = 0;
    int secondNumber = 0;
    
    do{
      
      secondNumber = rng.nextInt( 5 ) + 1;
      firstNumber = secondNumber + rng.nextInt( 5 ) + 1;

    }
    while( firstNumber == prevFirstNumber && secondNumber == prevSecondNumber );

    final text = 'How much is $firstNumber minus $secondNumber?';

    return ArithmeticAssignment(
      firstNumber: firstNumber,
      secondNumber: secondNumber,
      text: text,
      operationSymbol: "-",
      arithmeticOperation: ArithmeticOperation.subtraction,
    );

  }

  static bool checkAnswer(ArithmeticAssignment task, int enteredValue) => task.firstNumber - task.secondNumber == enteredValue;

}