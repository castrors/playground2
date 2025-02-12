import 'dart:async';

import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/foundation.dart';

class SettingsModel with ChangeNotifier {
  SettingsModel() {
    unawaited(FlameAudio.bgm.play('music.mp3', volume: _isMusicOn ? 1 : 0));
  }
  bool _isMusicOn = true;
  bool _isSoundOn = true;

  bool get isMusicOn => _isMusicOn;

  bool get isSoundOn => _isSoundOn;

  Future<void> toggleMusic() async {
    _isMusicOn = !_isMusicOn;
    unawaited(FlameAudio.bgm.play('music.mp3', volume: _isMusicOn ? 1 : 0));
    notifyListeners();
  }

  void toggleSound() {
    _isSoundOn = !_isSoundOn;
    FlameAudio.play(
      _isSoundOn ? 'collect.wav' : 'drop.wav',
    );
    notifyListeners();
  }
}
