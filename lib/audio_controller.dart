import 'package:flutter_soloud/flutter_soloud.dart';

class AudioController {

  SoLoud? _soloud;

  Future<void> initialize() async {
    _soloud = SoLoud.instance;
    await _soloud!.init();
  }

  void dispose() {
    _soloud?.deinit();
  }

  Future<void> playSound(String assetKey) async {
    final source = await _soloud!.loadAsset(assetKey);
    await _soloud!.play(source);
  }

}