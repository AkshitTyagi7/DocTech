import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart';

import 'common.dart';

void speechToText(
    {required SpeechToText stt,
    ValueChanged<String>? text,
    required VoidCallback onRecording,
    required VoidCallback onNoResult,
    required ValueChanged<String> onResult}) async {
  String lastWords = '';
  await stt
      .listen(
    partialResults: true,
    pauseFor: Duration(seconds: 2),
    onResult: (result) {
      lastWords = result.recognizedWords;
      log(lastWords);
      log('hiiii');
      text!(result.recognizedWords);
      if (result.finalResult) {
        onResult(result.recognizedWords);
      }
    },
  )
      .then((value) async {
    onRecording();

    await Future.delayed(Duration(seconds: 5));
    if (lastWords.isEmpty) {
      print('No result');
      stt.stop();
      onNoResult();
    }
  });
}
