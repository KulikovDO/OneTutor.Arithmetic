import 'dart:math';
import 'package:first_app/model/task.dart';


var rng = Random();

class DivisionOperation{

  static Task prepareTask(int prevFirstNumber, int prevSecondNumber){
      
    int firstNumber = 0;
    int secondNumber = 0;
    
    do{
      
      secondNumber = rng.nextInt( 5 ) + 1;
      firstNumber = secondNumber * ( rng.nextInt( 5 ) + 1 );

    }
    while( firstNumber == prevFirstNumber && secondNumber == prevSecondNumber );

    final text = 'How much is $firstNumber divided by $secondNumber?';

    return Task(firstNumber: firstNumber, secondNumber: secondNumber, text: text);

  }
  
}