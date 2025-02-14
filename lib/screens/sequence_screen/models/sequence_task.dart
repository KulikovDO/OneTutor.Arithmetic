class SequenceTask {
  const SequenceTask({
    required this.text,
  });

  final String text;

  static SequenceTask create() => const SequenceTask( text: "" );

  SequenceTask prepareTask() {
    return const SequenceTask(
      text: "What is the missing number?"
    );
  }
}