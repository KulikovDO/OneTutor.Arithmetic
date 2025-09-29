import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:one_tutor_arithmetic/tasks/subtraction_decomposition_task/data/highlight_option.dart';

class SubtractionDecompositionState {
  final HighlightOption highlightOption;
  final bool shouldAnimate;
  final bool shouldResetAnimation;
  SubtractionDecompositionState(this.shouldAnimate, this.shouldResetAnimation, this.highlightOption);
}

class SubtractionDecompositionNotifier extends StateNotifier<SubtractionDecompositionState> {
  SubtractionDecompositionNotifier() : super(
    SubtractionDecompositionState(false, false, HighlightOption.none)
  );

  void animateOnes() => state = SubtractionDecompositionState(true, false, HighlightOption.ones);
  
  void resetAnimationOnes() => state = SubtractionDecompositionState(false, true, HighlightOption.ones);

  void animateCancelOut() => state = SubtractionDecompositionState(true, false, HighlightOption.cancelOut);
  
  void resetAnimationCancelOut() => state = SubtractionDecompositionState(false, true, HighlightOption.cancelOut);
  
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