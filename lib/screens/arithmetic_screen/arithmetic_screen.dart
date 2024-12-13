import 'package:flutter/services.dart';
import 'package:one_tutor_arithmetic/data/arithmetic_operation.dart';
import 'package:one_tutor_arithmetic/screens/arithmetic_screen/widgets/text_input_container.dart';
import 'package:one_tutor_arithmetic/screens/final_screen.dart';
import 'package:one_tutor_arithmetic/misc/extensions.dart';
import 'package:one_tutor_arithmetic/screens/arithmetic_screen/models/addition_operation.dart';
import 'package:one_tutor_arithmetic/screens/arithmetic_screen/models/division_operation.dart';
import 'package:one_tutor_arithmetic/screens/arithmetic_screen/models/multiplication_operation.dart';
import 'package:one_tutor_arithmetic/screens/arithmetic_screen/models/subtraction_operation.dart';
import 'package:one_tutor_arithmetic/model/task.dart';
import 'package:flutter/material.dart';
import 'package:one_tutor_arithmetic/widgets/background.dart';
import 'package:one_tutor_arithmetic/widgets/progress_indicator.dart' as pi;
import 'package:flutter_tts/flutter_tts.dart';
import 'package:shared_preferences/shared_preferences.dart';


FlutterTts flutterTts = FlutterTts();

class ArithmeticScreen extends StatefulWidget {

  final ArithmeticOperation arithmeticOperation;

  ArithmeticScreen({super.key, required this.arithmeticOperation}) 
  {
    flutterTts.setSpeechRate(0.4);
  }

  @override
  State<ArithmeticScreen> createState() => _ArithmeticScreenState();
}

class _ArithmeticScreenState extends State<ArithmeticScreen> {

  int _firstNumber = 0;
  int _secondNumber = 0;
  int _iteration = 0;
  int numOfIterations = 10;
  double _progress = 0;
  bool displayMainScreenIntro = true;
  late Task task;

  onSubmitted(String value){
    // widget.onValueEntered(int.parse(value));

    print(int.parse(value));

  }

  void onValueEntered(int value){
    setState(() {
      // enteredValue = value;
    });
  }
  
  @override
  initState() {
    super.initState();
    
    switch(widget.arithmeticOperation){
      case ArithmeticOperation.addition:
        task = AdditionOperation.prepareTask(_firstNumber, _secondNumber);
        break;
      case ArithmeticOperation.subtraction:
        task = SubtractionOperation.prepareTask(_firstNumber, _secondNumber);
        break;
      case ArithmeticOperation.multiplication:
        task = MultiplicationOperation.prepareTask(_firstNumber, _secondNumber);
        break;
      case ArithmeticOperation.division:
        task = DivisionOperation.prepareTask(_firstNumber, _secondNumber);
        break;
    }

    setState(() {
      _firstNumber = task.firstNumber;
      _secondNumber = task.secondNumber;
      _iteration = _iteration == numOfIterations ? 1 : _iteration + 1;
    });

  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text( widget.arithmeticOperation.name.capitalize() ),
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

            SizedBox(
                width: double.infinity,
                child: 
                  Center(
                    child: Padding(
                      padding: EdgeInsets.only(left: 10, right: 10, bottom: height / 3),
                      child: 
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text( "${task.firstNumber} ${task.operationSymbol} ${task.secondNumber} = ", style:  const TextStyle( fontSize: 50, fontWeight: FontWeight.w500 )),

                            TextInputContainer(onValueEntered: onValueEntered,)
                          ]
                        ),
                      
                      
                    ),
                  ),
              )
          ],
        ),
      extendBody: true,
      resizeToAvoidBottomInset : false,
    );
  }
}
