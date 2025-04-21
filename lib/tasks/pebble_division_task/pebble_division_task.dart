import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:one_tutor_arithmetic/tasks/pebble_division_task/models/pebble_division_assignment.dart';
import 'package:one_tutor_arithmetic/tasks/pebble_division_task/pebbles_provider.dart';
import 'package:one_tutor_arithmetic/tasks/pebble_division_task/widgets/droppable_bucket.dart';
import 'package:one_tutor_arithmetic/tasks/pebble_division_task/widgets/source_bucket.dart';
import 'package:one_tutor_arithmetic/widgets/text_input_container.dart';


class PebbleDivisionTask extends ConsumerStatefulWidget {
  final Function onValueEntered;
  final Function speakText;
  const PebbleDivisionTask({super.key, required this.onValueEntered, required this.speakText});

  @override
  ConsumerState<PebbleDivisionTask> createState() => _PebbleDivisionTaskState();
}


class _PebbleDivisionTaskState extends ConsumerState<PebbleDivisionTask> {

  List<DroppableBucket> droppableBuckets = [];
  late PebbleDivisionAssignment assignment;
  int enteredValue = -1;
  late SourceBucket sourceBucket;
  bool isError = false;
  late GlobalKey textInputContainerKey;

  @override
  initState() {

    super.initState();
    assignment = PebbleDivisionAssignment.create();
    initAssignment();

  }

  initAssignment(){

    setState(() {
      enteredValue = -1;
      isError = false;
      droppableBuckets.clear();
      textInputContainerKey = GlobalKey();

      assignment = assignment.prepareTask();

      sourceBucket = SourceBucket( key: GlobalKey(), numOfPebbles: assignment.numOfPebbles,);

      final map = ref.read(pebblesProvider);
      map.clear();

      
      for(int i = 0; i < assignment.numOfBuckets; i++){
        GlobalKey key = GlobalKey();
        
        map[key] = [];
        droppableBuckets.add(DroppableBucket(key: key));
      }
    });

    widget.speakText(assignment.text);

  }


  void handleValueEntered(int value){
    setState(() {
      enteredValue = value;
    });
    widget.onValueEntered();
  }

  bool checkAnswer() { 
    bool isAnswerCorrect = assignment.checkAnswer(enteredValue);

    setState(() {
      isError = !isAnswerCorrect;
    });

    return isAnswerCorrect;
  }

  @override
  Widget build(BuildContext context) {

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        
        Expanded(child: 
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: assignment.richText,
              ),
              sourceBucket,
            ]
          
          ),
        ),
          
        Wrap(
          alignment: WrapAlignment.center,
          spacing: 10,
          runSpacing: 10,
          children: droppableBuckets,
        ),

        if(droppableBuckets.length < 3)
          const SizedBox(
            height: 100,
          ),

        Padding(
          padding: const EdgeInsets.only(top: 10, bottom: 90),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text( "${assignment.numOfPebbles} : ${assignment.numOfBuckets} = ", style:  const TextStyle( fontSize: 50, fontWeight: FontWeight.w500 )),
              TextInputContainer(key: textInputContainerKey, onValueEntered: handleValueEntered, isError: isError,),
            ]
          ),
        ),
        
      ]
    );
  }

}