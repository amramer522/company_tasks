import 'dart:async';
import 'dart:io';
import 'dart:ui';

import 'package:permission_handler/permission_handler.dart';
import 'package:record/record.dart';

enum NumberTypes { seconds, minutes }

class RecordAudioHelper {
  final _audioRecorder = Record();
  int _recordDuration = 0;
  Timer? _timer;
  StreamSubscription<RecordState>? _recordSub;
  RecordState _recordState = RecordState.stop;
  StreamSubscription<Amplitude>? _amplitudeSub;
  Amplitude? amplitude;

  void init(void Function(void Function()) onChange) {
    // call setState on the onChange method form the view

    _recordSub = _audioRecorder.onStateChanged().listen((recordState) {
      _recordState = recordState;
      onChange((){});
    });

    _amplitudeSub =
        _audioRecorder.onAmplitudeChanged(const Duration(milliseconds: 300)).listen((amp) {
      amplitude = amp;
      onChange((){});
    });
  }

  Future<void> start(void Function(void Function()) onChange) async {
    // call setState on the onChange method form the view

    try {
      if (await _audioRecorder.hasPermission()) {
        // We don't do anything with this but printing
        final isSupported = await _audioRecorder.isEncoderSupported(
          AudioEncoder.aacLc,
        );
        print('${AudioEncoder.aacLc.name} supported: $isSupported');

        // final devs = await _audioRecorder.listInputDevices();
        // final isRecording = await _audioRecorder.isRecording();

        await _audioRecorder.start();
        _recordDuration = 0;

        _startTimer(onChange);
      }
    } catch (e) {
      print(e);
    }
  }

  bool isPause() {
    return _recordState == RecordState.pause;
  }

  bool isRecord() {
    return _recordState == RecordState.record;
  }

  bool isStop() {
    return _recordState == RecordState.stop;
  }

  bool showTimer() {
    return _recordState != RecordState.stop;
  }

  String formatNumber(NumberTypes type) {
    int number = 0;
    if (type == NumberTypes.seconds) {
      number = _recordDuration % 60;
    } else {
      number = _recordDuration ~/ 60;
    }
    String numberStr = number.toString();
    if (number < 10) {
      numberStr = '0$numberStr';
    }
    return numberStr;
  }

  void _startTimer(void Function(void Function()) onChange) {
    // call setState on the onChange method form the view

    _timer?.cancel();

    _timer = Timer.periodic(const Duration(seconds: 1), (Timer t) {
      _recordDuration++;
      onChange((){});
    });
  }

  Future<String?> stop() async {
    _timer?.cancel();
    _recordDuration = 0;

    final path = await _audioRecorder.stop();

    if (path != null) {
      return path;
    }
  }

  Future<void> pause() async {
    _timer?.cancel();
    await _audioRecorder.pause();
  }

  Future<void> resume(void Function(void Function()) onChange) async {
    // call setState on the onChange method form the view

    _startTimer(onChange);
    await _audioRecorder.resume();
  }

  Future<void> dispose() async {
    _timer?.cancel();
    await _recordSub?.cancel();
    await _amplitudeSub?.cancel();
    await _audioRecorder.dispose();
  }
}
