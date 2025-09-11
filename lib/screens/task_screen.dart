import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:one_tutor_arithmetic/data/arithmetic_operation.dart';
import 'package:one_tutor_arithmetic/data/task_name.dart';
import 'package:one_tutor_arithmetic/screens/final_screen.dart';
import 'package:one_tutor_arithmetic/data/categories.dart';
import 'package:one_tutor_arithmetic/tasks/arithmetic_task/arithmetic_task.dart';
import 'package:one_tutor_arithmetic/tasks/clock_task/clock_task.dart';
import 'package:one_tutor_arithmetic/tasks/coins_task/coins_task.dart';
import 'package:one_tutor_arithmetic/tasks/days_of_week_task/days_of_week_task.dart';
import 'package:one_tutor_arithmetic/tasks/decomposition_task/decomposition_task.dart';
import 'package:one_tutor_arithmetic/tasks/even_odd_task/even_odd_task.dart';
import 'package:one_tutor_arithmetic/tasks/fractions_task/fractions_task.dart';
import 'package:one_tutor_arithmetic/tasks/grouping_task/grouping_task.dart';
import 'package:one_tutor_arithmetic/tasks/lollies_task/lollies_task.dart';
import 'package:one_tutor_arithmetic/tasks/memory_task/memory_task.dart';
import 'package:one_tutor_arithmetic/tasks/more_less_task/more_less_task.dart';
import 'package:one_tutor_arithmetic/tasks/ordering_task/ordering_task.dart';
import 'package:one_tutor_arithmetic/tasks/pebble_division_task/pebble_division_task.dart';
import 'package:one_tutor_arithmetic/tasks/sequence_task/sequence_task.dart';
import 'package:one_tutor_arithmetic/tasks/subtraction_decomposition_task/subtraction_decomposition_task.dart';
import 'package:one_tutor_arithmetic/widgets/background.dart';
import 'package:one_tutor_arithmetic/widgets/bottom_navigation_bar.dart';
import 'package:one_tutor_arithmetic/widgets/progress_indicator.dart' as pi;
import 'package:shared_preferences/shared_preferences.dart';


FlutterTts flutterTts = FlutterTts();

Future<void> speak(String text) async {
    
  await flutterTts.awaitSpeakCompletion(true);
  await flutterTts.speak(text);
  
}

class TaskScreen extends StatefulWidget {

  final TaskName taskName;

  TaskScreen({super.key, required this.taskName }) 
  {
    flutterTts.setSpeechRate(0.4);
  }

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {

  int iteration = 0;
  int numOfIterations = 10;
  double progress = 0;
  bool isSubmitDisabled = true;
  late String title;
  late Widget task;
  
  dynamic globalKey = GlobalKey();
  
  handleSpeakText(String text) async => await speak(text);

  
  handleValueEntered(){
    setState(() {
      isSubmitDisabled = false;
    });
  }


  handleSubmit() async {

    setState(() {
      isSubmitDisabled = true;
    }); 

    bool answerIsCorrect = globalKey.currentState!.checkAnswer();

    if(answerIsCorrect){

      await speak("That's correct");
      if (!mounted) return;
      completeIteration( );

    } else {

      await speak("Please try again");
      if (!mounted) return;
      setState(() {
        isSubmitDisabled = false;
      });

    }

  }


  completeIteration() async{

    if (!mounted) return;

    setState(() {

      iteration = iteration == numOfIterations ? 1 : iteration + 1;
      progress = iteration / numOfIterations;

    });

    if(iteration >= numOfIterations){

      // delay to display last bit of progress animation
      await Future.delayed(const Duration(milliseconds: 600));

      if (!mounted) return;

      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (ctx) => const FinalScreen()
        ),
      );
        
    } else {

      globalKey.currentState!.initAssignment( );
      setState(() {
        isSubmitDisabled = true;
      });

    }
  }


  readConfig() async {

    final prefs = await SharedPreferences.getInstance();
    numOfIterations = prefs.getInt('iterations') ?? 10;

  }

  @override
  void initState() {
    super.initState();
    title = categories.where((c) => c.taskName == widget.taskName).first.description;

    readConfig();

    if([TaskName.addition, TaskName.subtraction, TaskName.multiplication, TaskName.division].contains(widget.taskName)){
      ArithmeticOperation arithmeticOperation = taskNameToArithmeticOperation(widget.taskName);
      task = ArithmeticTask(key: globalKey, onValueEntered: handleValueEntered, speakText: handleSpeakText, arithmeticOperation: arithmeticOperation);
    } else if(widget.taskName == TaskName.ordering){
      task = OrderingTask(key: globalKey, onValueEntered: handleValueEntered, speakText: handleSpeakText,);
    } else if(widget.taskName == TaskName.sequence){
      task = SequenceTask(key: globalKey, onValueEntered: handleValueEntered, speakText: handleSpeakText,);
    } else if(widget.taskName == TaskName.evenOdd){
      task = EvenOddTask(key: globalKey, onValueEntered: handleValueEntered, speakText: handleSpeakText,);
    } else if(widget.taskName == TaskName.moreLess){
      task = MoreLessTask(key: globalKey, onValueEntered: handleValueEntered, speakText: handleSpeakText,);
    } else if(widget.taskName == TaskName.lollies){
      task = LolliesTask(key: globalKey, onValueEntered: handleValueEntered, speakText: handleSpeakText,);
    } else if(widget.taskName == TaskName.daysOfWeek){
      task = DaysOfWeekTask(key: globalKey, onValueEntered: handleValueEntered, speakText: handleSpeakText,);
    } else if(widget.taskName == TaskName.pebbleDivision){
      task = PebbleDivisionTask(key: globalKey, onValueEntered: handleValueEntered, speakText: handleSpeakText,);
    } else if(widget.taskName == TaskName.coins){
      task = CoinsTask(key: globalKey, onValueEntered: handleValueEntered, speakText: handleSpeakText,);
    } else if(widget.taskName == TaskName.grouping){
      task = GroupingTask(key: globalKey, onValueEntered: handleValueEntered, speakText: handleSpeakText,);
    } else if(widget.taskName == TaskName.clock){
      task = ClockTask(key: globalKey, onValueEntered: handleValueEntered, speakText: handleSpeakText,);
    } else if(widget.taskName == TaskName.fractions){
      task = FractionsTask(key: globalKey, onValueEntered: handleValueEntered, speakText: handleSpeakText,);
    } else if(widget.taskName == TaskName.memory){
      task = MemoryTask(key: globalKey, onValueEntered: handleValueEntered, speakText: handleSpeakText,);
    } else if(widget.taskName == TaskName.decomposition){
      task = DecompositionTask(key: globalKey, onValueEntered: handleValueEntered, speakText: handleSpeakText,);
    } else if(widget.taskName == TaskName.subtractionDecomposition){
      task = SubtractionDecompositionTask(key: globalKey, onValueEntered: handleValueEntered, speakText: handleSpeakText,);
    }else {
      throw Exception("Task not implemented yet");
    }

  }

  ArithmeticOperation taskNameToArithmeticOperation(TaskName taskName){

    if(taskName == TaskName.addition)
    {
      return ArithmeticOperation.addition;
    }
    if(taskName == TaskName.subtraction)
    {
      return ArithmeticOperation.subtraction;
    }
    if(taskName == TaskName.multiplication)
    {
      return ArithmeticOperation.multiplication;
    }
    if(taskName == TaskName.division)
    {
      return ArithmeticOperation.division;
    }

    throw ArgumentError();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text( /*widget.taskName.name.capitalize()*/title ),
      ),
      body:
        Stack(
          children: [
            const Background( ),

            Opacity(
              opacity: 0.15,
              child: Center(
                child: pi.ProgressIndicator(progress: progress)
              ),
            ),

            task
            
          ],
        ),
      extendBody: true,
      resizeToAvoidBottomInset : false,
      bottomNavigationBar: BottomNavigationBarContainer(onPress: handleSubmit, isDisabled: isSubmitDisabled),
    );
  }
}

