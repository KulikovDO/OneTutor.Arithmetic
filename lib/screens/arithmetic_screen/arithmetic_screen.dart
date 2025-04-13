import 'package:one_tutor_arithmetic/data/arithmetic_operation.dart';
import 'package:one_tutor_arithmetic/screens/arithmetic_screen/models/arithmetic_task.dart';
import 'package:one_tutor_arithmetic/widgets/bottom_navigation_bar.dart';
import 'package:one_tutor_arithmetic/widgets/text_input_container.dart';
import 'package:one_tutor_arithmetic/screens/final_screen.dart';
import 'package:one_tutor_arithmetic/misc/extensions.dart';
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

  int prevFirstNumber = 0;
  int prevSecondNumber = 0;
  int _iteration = 0;
  int numOfIterations = 10;
  double _progress = 0;
  bool displayMainScreenIntro = true;
  late ArithmeticTask task;
  int enteredValue = -1;
  bool isError = false;
  late GlobalKey textInputContainerKey;

  Future<void> speak(String text) async {
    
    await flutterTts.awaitSpeakCompletion(true);
    await flutterTts.speak(text);
    
  }

  _readConfig() async {

    final prefs = await SharedPreferences.getInstance();
    numOfIterations = prefs.getInt('iterations') ?? 10;

  }

  handleValueEntered(int value){

    setState(() {
      enteredValue = value;
    });

  }


  void handleSubmit( ) async{

    bool answerIsCorrect = task.checkAnswer(enteredValue);

    if(answerIsCorrect){
      setState(() {
        isError = false;
      });
      await speak("That's correct");
    } else {
      setState(() {
        isError = true;
      });
      await speak("Please try again");
    }

    if(answerIsCorrect){

      setState(() {
        
        _iteration = _iteration == numOfIterations ? 1 : _iteration + 1;
        _progress = _iteration / numOfIterations;

      });

      if( _iteration >= numOfIterations){

        await Future.delayed(const Duration(milliseconds: 600));

        if (!mounted) return;

        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (ctx) => const FinalScreen()
          ),
        );
          
      } else {

        setState(() {
        
          init();

        });
      }
    } 

  }

  asyncInitState() async => await _readConfig();
  
  
  @override
  initState() {
    super.initState();
    task = ArithmeticTask.create(widget.arithmeticOperation);
    asyncInitState();
    init();
  }

  init(){

    task = task.prepareTask();
    flutterTts.speak(task.text);
    prevFirstNumber = task.firstNumber;
    prevSecondNumber = task.secondNumber;
    enteredValue = -1;
    isError = false;
    textInputContainerKey = GlobalKey();
    
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
                          TextInputContainer(key: textInputContainerKey, onValueEntered: handleValueEntered, isError: isError,)
                        ]
                      ),
                  ),
                ),
            ),
          ],
        ),
      extendBody: true,
      resizeToAvoidBottomInset : false,
      bottomNavigationBar: BottomNavigationBarContainer(onPress: handleSubmit, isDisabled: enteredValue == -1),
    );
  }
}
