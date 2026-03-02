import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:one_tutor_arithmetic/tasks/subtraction_decomposition_task/data/highlight_option.dart';

class SubtractionDecompositionState {
  final bool shouldAnimate;
  final bool shouldResetAnimation;
  final HighlightOption highlightOption;
  final Map<int, int> selectedNumbers;
  final bool canCancelOut;
  
  SubtractionDecompositionState(this.shouldAnimate, this.shouldResetAnimation, this.highlightOption, this.selectedNumbers, this.canCancelOut);
}

class SubtractionDecompositionNotifier extends StateNotifier<SubtractionDecompositionState> {
  SubtractionDecompositionNotifier() : super(
    SubtractionDecompositionState(false, false, HighlightOption.none, {}, false) // initial state
  );

  void animate(HighlightOption highlightOption) => state = SubtractionDecompositionState(true, false, highlightOption, {}, false);
  
  void resetAnimation(HighlightOption highlightOption) => state = SubtractionDecompositionState(false, true, highlightOption, {}, false);

  bool selectNumber(int row, int number) {

    if(state.selectedNumbers.containsKey(row)){
      return false;
    } else {
      state.selectedNumbers[row] = number;
      
      if(state.selectedNumbers.length == 2){

        if(state.selectedNumbers[1] == state.selectedNumbers[2]){
          state = SubtractionDecompositionState(state.shouldAnimate, state.shouldResetAnimation, state.highlightOption, state.selectedNumbers, true);
        } else {
          state = SubtractionDecompositionState(state.shouldAnimate, state.shouldResetAnimation, state.highlightOption, state.selectedNumbers, false);
        }  
      } else {
        state = SubtractionDecompositionState(state.shouldAnimate, state.shouldResetAnimation, state.highlightOption, state.selectedNumbers, false);
      }

      return true;
    }
  }

  void deselectNumber(int row) {

    if(state.selectedNumbers.containsKey(row)){
      state.selectedNumbers.remove(row);
      state = SubtractionDecompositionState(state.shouldAnimate, state.shouldResetAnimation, state.highlightOption, state.selectedNumbers, false);
    } 
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