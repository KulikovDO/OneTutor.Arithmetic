// pebbles_provider
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:one_tutor_arithmetic/screens/pebble_division_screen/widgets/draggable_pebble.dart';

final Map<GlobalKey, List<DraggablePebble>> _bucketPebbles = {};

final pebblesProvider = StateProvider<Map<GlobalKey, List<DraggablePebble>>>((ref) {
  return _bucketPebbles;
});