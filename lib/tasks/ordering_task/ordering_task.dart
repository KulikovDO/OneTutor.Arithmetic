import 'package:flutter/material.dart';
import 'package:one_tutor_arithmetic/tasks/ordering_task/models/ordering_assignment.dart';
import 'package:one_tutor_arithmetic/widgets/drag_and_droppable_text_container.dart';


class OrderingTask extends StatefulWidget {
  final Function onValueEntered;
  final Function speakText;
  const OrderingTask({super.key, required this.onValueEntered, required this.speakText});

  @override
  State<OrderingTask> createState() => _OrderingTaskState();
}


class _OrderingTaskState extends State<OrderingTask> {

  int? _acceptedData;
  
  late OrderingAssignment assignment;
  
  List<GlobalKey<DragAndDroppableTextContainerState>> draggableKeys = [];
  List<GlobalKey<DragAndDroppableTextContainerState>> droppableKeys = [];

  List<DragAndDroppableTextContainer> draggableList = [];
  List<DragAndDroppableTextContainer> droppableList = [];

  bool isError = false;

  onAccepted(int data){
    setState(() {
      _acceptedData = data; 
    });

    bool isAnswerGiven = checkAnswerIsGiven();
    if(isAnswerGiven){
      widget.onValueEntered();
    }
  
  }

  checkAnswerIsGiven( ) {

    bool answerNotNull = true;    
    
    for(var droppableKey in droppableKeys)
    {

      if(droppableKey.currentState == null || droppableKey.currentState!.text == null){

        answerNotNull = false;
        break;

      }

    }

    return answerNotNull;

  }


  bool checkAnswer( ) {

    List<int> answers = [];
    
    for(var droppableKey in droppableKeys)
    {

      if(droppableKey.currentState == null || droppableKey.currentState!.text == null){

        return false;

      }

      answers.add(int.parse(droppableKey.currentState!.text!));
    }

    return assignment.checkAnswer(answers);
  }

  
  initAssignment(){

      assignment = assignment.prepareTask();
      
      setState(() {
        isError = false;
        _acceptedData = null; 
      
        draggableKeys.clear();
        draggableList.clear();

        droppableKeys.clear();
        droppableList.clear();

        for(int i = 0; i < 3; i++){
          draggableKeys.add(GlobalKey());
          droppableKeys.add(GlobalKey());
        }

        draggableList = List.generate( assignment.numbers.length,(index) => 
          DragAndDroppableTextContainer(key: draggableKeys[index], acceptedData: _acceptedData, text: assignment.numbers[index], isDraggable: true, onAccepted: onAccepted,)
        );
        
        droppableList = List.generate( assignment.numbers.length, (index) => 
          DragAndDroppableTextContainer(key: droppableKeys[index], acceptedData: _acceptedData, text: null, isDraggable: false, onAccepted: onAccepted,)
        );
      });
      widget.speakText(assignment.text);

  }

  @override
  initState() {

    super.initState();
    assignment = OrderingAssignment.create();
    initAssignment();

  }

  @override
  Widget build(BuildContext context) {
  
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [

        Expanded(
          child: SizedBox(
            width: double.infinity,
            child: 
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: assignment.richText
                ),
              ),
          )
        ),

        Expanded(
          flex: 3,
          child: SizedBox(
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: draggableList,
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: droppableList
                ),
              ],
              ),
            ),
          ),
        
        const Expanded(
          child: SizedBox(
            width: double.infinity,
          )
        ),
      ],
    );
  }

}