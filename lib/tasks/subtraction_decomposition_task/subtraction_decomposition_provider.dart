import 'package:flutter_riverpod/flutter_riverpod.dart';

class SubtractionDecompositionState {
  final bool shouldAnimateOnes;
  final bool shouldResetAnimationOnes;
  SubtractionDecompositionState(this.shouldAnimateOnes, this.shouldResetAnimationOnes);
}

class SubtractionDecompositionNotifier extends StateNotifier<SubtractionDecompositionState> {
  SubtractionDecompositionNotifier() : super(
    SubtractionDecompositionState(false, false)
  );

  void animateOnes(){
    state = SubtractionDecompositionState(true, false);
  }

  void resetAnimationOnes(){
    state = SubtractionDecompositionState(false, true);
  }
}

final subtractionDecompositionProvider = StateNotifierProvider<SubtractionDecompositionNotifier, SubtractionDecompositionState>((ref) {
  return SubtractionDecompositionNotifier();
});

// 4. Consume in UI (e.g., a ConsumerWidget)
// Text(ref.watch(counterProvider).count.toString()),
// ElevatedButton(
//   onPressed: () => ref.read(counterProvider.notifier).increment(),
//   child: const Text('Increment'),
// ),