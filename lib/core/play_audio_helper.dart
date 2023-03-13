import 'dart:async';
import 'package:audioplayers/audioplayers.dart' as ap;
import 'package:flutter/foundation.dart';

class PlayAudioHelper {
  final _audioPlayer = ap.AudioPlayer();
  late StreamSubscription<void> _playerStateChangedSubscription;
  late StreamSubscription<Duration?> _durationChangedSubscription;
  late StreamSubscription<Duration> _positionChangedSubscription;
  Duration? position;
  Duration? duration;

  dispose() {
    _playerStateChangedSubscription.cancel();
    _positionChangedSubscription.cancel();
    _durationChangedSubscription.cancel();
    _audioPlayer.dispose();
  }

  bool isPlaying() {
    return _audioPlayer.state == ap.PlayerState.playing;
  }

  void toggleAudioStatus(String source) {
    if (isPlaying()) {
      pause();
    } else {
      play(source);
    }
  }

  init(void Function(void Function()) onChange) {
    // call setState on the onChange method form the view
    _playerStateChangedSubscription = _audioPlayer.onPlayerComplete.listen((state) async {
      await stop();
      onChange((){});
    });
    _positionChangedSubscription = _audioPlayer.onPositionChanged.listen(
      (position) {
        this.position = position;
        onChange((){});
      },
    );
    _durationChangedSubscription = _audioPlayer.onDurationChanged.listen(
      (duration) {
        this.duration = duration;
        onChange((){});
      },
    );
  }

  Future<void> play(String source) {
    return _audioPlayer.play(
      kIsWeb ? ap.UrlSource(source) : ap.DeviceFileSource(source),
    );
  }

  void Function(double)? onSliderChange(v) {
    if (duration != null) {
      final position = v * duration!.inMilliseconds;
      _audioPlayer.seek(Duration(milliseconds: position.round()));
    }
    return null;
  }

  double getSliderValue() {
    return canSetValue && duration != null && position != null
        ? position!.inMilliseconds / duration!.inMilliseconds
        : 0.0;
  }

  bool canSetValue = false;

  beforeSliderBuild() {
    if (duration != null && position != null) {
      canSetValue = position!.inMilliseconds > 0;
      canSetValue &= position!.inMilliseconds < duration!.inMilliseconds;
    }
  }

  Future<void> pause() => _audioPlayer.pause();

  Future<void> stop() => _audioPlayer.stop();
}
