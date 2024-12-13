import 'package:one_tutor_arithmetic/data/arithmetic_operation.dart';
import 'package:one_tutor_arithmetic/screens/arithmetic_screen/models/addition_operation.dart';
import 'package:one_tutor_arithmetic/screens/arithmetic_screen/models/division_operation.dart';
import 'package:one_tutor_arithmetic/screens/arithmetic_screen/models/multiplication_operation.dart';
import 'package:one_tutor_arithmetic/screens/arithmetic_screen/models/subtraction_operation.dart';

class ArithmeticTask {
  const ArithmeticTask({
    required this.firstNumber,
    required this.secondNumber,
    required this.text,
    required this.operationSymbol,
    required this.arithmeticOperation,
  });

  final int firstNumber;
  final int secondNumber;
  final String text;
  final String operationSymbol;
  final ArithmeticOperation arithmeticOperation;

  static ArithmeticTask create(ArithmeticOperation arithmeticOperation){

    return ArithmeticTask(
      firstNumber: -1, 
      secondNumber: -1, 
      text: "", 
      operationSymbol: "", 
      arithmeticOperation: arithmeticOperation);

  }

  ArithmeticTask prepareTask(){

    switch(arithmeticOperation){
      case ArithmeticOperation.addition:
        return AdditionOperation.prepareTask(firstNumber, secondNumber);
      case ArithmeticOperation.subtraction:
        return SubtractionOperation.prepareTask(firstNumber, secondNumber);
      case ArithmeticOperation.multiplication:
        return MultiplicationOperation.prepareTask(firstNumber, secondNumber);
      case ArithmeticOperation.division:
        return DivisionOperation.prepareTask(firstNumber, secondNumber);
    }

  }

  bool checkAnswer(int value) {
    switch(arithmeticOperation){
      case ArithmeticOperation.addition:
        return AdditionOperation.checkAnswer(this, value);
      case ArithmeticOperation.subtraction:
        return SubtractionOperation.checkAnswer(this, value);
      case ArithmeticOperation.multiplication:
        return MultiplicationOperation.checkAnswer(this, value);
      case ArithmeticOperation.division:
        return DivisionOperation.checkAnswer(this, value);
    }
  }
}