import 'dart:async';

import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/material.dart';

class SettingsModel with ChangeNotifier, WidgetsBindingObserver {
  SettingsModel() {
    WidgetsBinding.instance.addObserver(this);
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

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.paused) {
      // App is in the background
      FlameAudio.bgm.pause();
    } else if (state == AppLifecycleState.resumed) {
      // App is in the foreground
      if (_isMusicOn) {
        FlameAudio.bgm.resume();
      }
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }
}
