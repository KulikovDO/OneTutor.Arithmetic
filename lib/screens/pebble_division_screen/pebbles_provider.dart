import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:one_tutor_arithmetic/screens/pebble_division_screen/widgets/draggable_pebble.dart';

class PebblesNotifier extends StateNotifier<Map<GlobalKey, List<DraggablePebble>>>{
  PebblesNotifier() : super({});


  void movePebble(GlobalKey globalKey, DraggablePebble draggablePebble){
    removePebble(draggablePebble);
    addPebble(globalKey, draggablePebble);
  }



  void addPebble(GlobalKey globalKey, DraggablePebble draggablePebble) {

    List<DraggablePebble> draggablePebbles = [...state[globalKey]!, draggablePebble];

    state = {
      ...state,
      globalKey: draggablePebbles
    };

  }

  void removePebble(DraggablePebble draggablePebble){

    GlobalKey? globalKey;
    bool keyExists = false;
    
    for(GlobalKey key in state.keys){

      if(state[key]!.contains(draggablePebble)){

        globalKey = key;
        keyExists = true;

      } 

      if(keyExists){
        List<DraggablePebble> draggablePebbles = state[globalKey]!.where((x) => x != draggablePebble).toList();
        state = {
          ...state,
          globalKey!: draggablePebbles
        };
      }

    }

  }

}


final pebblesProvider = StateNotifierProvider<PebblesNotifier, Map<GlobalKey, List<DraggablePebble>>>((ref) {
  return PebblesNotifier();
});

