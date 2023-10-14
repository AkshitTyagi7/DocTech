import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

import '../../utility/common.dart';

import '../models/character.dart';
import '../models/option.dart';
import '../utility/tts.dart';
import '../widgets/selection.dart';
import '../widgets/sliders.dart';
import '../widgets/spaces.dart';

class ChooseVoice extends StatefulWidget {
  final List<CharacterOption> voices;

  final ValueChanged<double> onSpeedChanged;
  final ValueChanged<double> onPitchChanged;
  final ValueChanged<CharacterOption> onVoiceChanged;
  const ChooseVoice({super.key, required this.voices, required this.onSpeedChanged, required this.onVoiceChanged, required this.onPitchChanged});

  @override
  State<ChooseVoice> createState() => _ChooseVoiceState();
}

class _ChooseVoiceState extends State<ChooseVoice> {
  double speed = 1;
  double pitch = 0;
  CharacterOption? selectedVoice;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SingleSelect(
            options: widget.voices,
            onSelected: (voice) async {
              log(voice);
              setState(() {
                selectedVoice = voice;
              });

              playDemo();
              widget.onVoiceChanged(voice);
            }),
        mediumSmallSpace(),
        Visibility(
          maintainAnimation: true,
          maintainState: true,
          visible: selectedVoice != null,
          child: AnimatedOpacity(
            duration: const Duration(seconds: 1),
            curve: Curves.fastOutSlowIn,
            opacity: selectedVoice != null ? 1.0 : 0.0,
            child: Column(
              children: [
                AppSlider(context,
                    lable: "Speed",
                    max: 4,
                    min: 0.25,
                    value: speed,
                    onChanged: (audiospeed) => setState(() {
                          speed = audiospeed;
                        }),
                    onChangeEnd: (p0) {
                      widget.onSpeedChanged(p0);
                      playDemo();
                    }),
                AppSlider(context,
                    lable: "Pitch",
                    max: 20,
                    min: -20,
                    value: pitch,
                    onChanged: (audiopitch) => setState(() {
                          pitch = audiopitch;
                        }),
                    onChangeEnd: (p0) {
                      widget.onSpeedChanged(p0);
                      playDemo();
                    }),
              ],
            ),
          ),
        ),
      ],
    );
  }

  void playDemo() async {
    // ignore: unused_local_variable
    AudioPlayer audio = await texttospeech(
      text: "Demo",
      voice:
          CharacterVoice(id: selectedVoice!.id, name: selectedVoice!.name, code: selectedVoice!.language, pitch: pitch.toInt(), speed: speed.toInt()),
    );
  }
}
