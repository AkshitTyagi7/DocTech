import 'dart:convert';
import 'dart:io';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import 'package:remove_emoji/remove_emoji.dart';
import 'package:audioplayers/audioplayers.dart';

import '../models/character.dart';
import 'common.dart';

final remove = RemoveEmoji();
AudioPlayer audioPlayer = AudioPlayer();

Future<AudioPlayer> texttospeech({
  required CharacterVoice voice,
  required String text,
}) async {
  try {
    await audioPlayer.stop();
    log(text);
    return audioPlayer

    var audiores =
        await http.post(Uri.parse(''),
            headers: {"Content-Type": "application/json"},
            body: jsonEncode({
              "audioConfig": {
                "audioEncoding": "MP3",
                "sampleRateHertz": 22050,
                "effectsProfileId": ["small-bluetooth-speaker-class-device"],
                "pitch": voice.pitch,
                "speakingRate": voice.speed
              },
              "input": {"text": remove.clean(text.replaceAll(":)", "").replaceAll(":(", ""))},
              "voice": {"languageCode": voice.code, "name": voice.name}
            }));

    Map jsonResponse = jsonDecode(audiores.body);
    print(jsonResponse);
    var audiobase64 = jsonResponse["audioContent"];
    final decodebase64 = base64Decode(audiobase64);
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/audio.mp3');
    await file.writeAsBytes(decodebase64);
// Play the audio file
    await audioPlayer.play(DeviceFileSource(file.path));

    return audioPlayer;
  } catch (e) {
    print(e);
    return audioPlayer;
  }
}
