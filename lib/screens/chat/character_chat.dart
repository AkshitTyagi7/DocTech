import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

import 'package:speech_to_text/speech_to_text.dart';
import '../../models/character.dart';
import '../../models/message.dart';
import '../../utility/common.dart';
import '../../utility/rest_api.dart';
import '../../utility/tts.dart';
import '../../widgets/spaces.dart';
import 'components/character_chat_item.dart';
import 'components/info.dart';
import 'components/inputField.dart';

class CharacterChatScreen extends StatefulWidget {
  final Character character;
  const CharacterChatScreen({super.key, required this.character});

  @override
  State<CharacterChatScreen> createState() => _CharacterChatScreenState();
}

class _CharacterChatScreenState extends State<CharacterChatScreen> {
  final TextEditingController messageController = TextEditingController();
  CharacterMessageData messages = CharacterMessageData(messages: [], systemMessage: '');
  SpeechToText _speechToText = SpeechToText();
// ignore: unused_field
  bool _speechEnabled = false;
  bool _isLoading = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    init();
  }

  /* Dispose */
  @override
  void dispose() {
    // In practice, this will rarely be called. We assume that the listeners
    // will be added and removed in a coherent fashion such that when the object
    // is no longer being used, there's no listener, and so it will get garbage
    // collected.

    super.dispose();
    _speechToText.cancel();
  }

  void init() async {
    messages = await getCharacterChats(characterId: widget.character.id.validate());
    _speechEnabled = await _speechToText.initialize();
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          actions: [
            IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
          ],
          title: Text(widget.character.name.validate()),
        ),
        body: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : Padding(
                padding: const EdgeInsets.all(16.0),
                child: Center(
                  child: Column(
                    children: [
                      CharacterInfo(character: widget.character),
                      largeSpace(),
                      Expanded(
                          child: ListView(reverse: true, children: [
                        for (final message in messages.messages.reversed) CharacterChatItem(message: message),
                      ])),
                      MessageInput(
                        speech: _speechToText,
                        messageController: messageController,
                        onMessageSend: (message, doTTS) async {
                          messages.messages.add(CharacterMessage(content: message, role: 'user'));

                          messageController.clear();
                          setState(() {});
                          CharacterMessage response = await sendMessage(characterId: widget.character.id.validate(), message: messages);
                          doTTS ? await texttospeech(voice: widget.character.voice, text: response.content) : null;
                          messages.messages.add(response);
                          setState(() {});
                        },
                      )
                    ],
                  ),
                ),
              ));
  }
}
