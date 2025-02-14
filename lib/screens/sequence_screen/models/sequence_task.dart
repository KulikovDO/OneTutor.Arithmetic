import 'dart:math';

var rng = Random();

class SequenceTask {
  const SequenceTask({
    required this.options,
    required this.answer,
    required this.text,
  });

  final String text;
  final int answer;
  final List<int> options;

  static SequenceTask create() => const SequenceTask( options: [], answer: -1, text: "" );

  SequenceTask prepareTask() {

    int start = rng.nextInt( 20 -  6 );
    int missingNumberIndex = rng.nextInt( 4 ) + 1;
    int answer = -1;
    List<int> options = [];
    

    for(var i = 0; i < 6; i++){

      if(i == missingNumberIndex){
        options.add(-1);
        answer = start + i;
      } else {
        options.add(start + i);
      }

    }
    return SequenceTask(
      options: options,
      answer: answer,
      text: "What is the missing number?"
    );
  }

  bool checkAnswer(int answer) => answer == this.answer;
}