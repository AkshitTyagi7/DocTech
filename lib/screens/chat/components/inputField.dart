import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

import '../../../utility/common.dart';
import '../../../utility/stt.dart';
import '../../../utility/tts.dart';
import '../../../widgets/spaces.dart';

class MessageInput extends StatefulWidget {
  final TextEditingController messageController;
  final Function(String, bool) onMessageSend;
  final speech;
  const MessageInput({super.key, required this.onMessageSend, required this.messageController, required this.speech});
  @override
  State<MessageInput> createState() => _MessageInputState();
}

class _MessageInputState extends State<MessageInput> {
  String iconPath = 'assets/icons/mic.png';
  late StreamSubscription stream;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    stream = audioPlayer.onPlayerStateChanged.listen((event) {
      if (event == PlayerState.playing) {
        setState(() {
          iconPath = 'assets/icons/stop.png';
        });
      }
      if (event == PlayerState.completed) {
        setState(() {
          iconPath = 'assets/icons/mic.png';
        });
      }
    });
  }

  @override
  void dispose() {
    audioPlayer.stop();
    // TODO: implement dispose
    super.dispose();

    stream.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15.0),
      child: Row(
        children: [
          Expanded(
            child: Container(
              child: TextField(
                controller: widget.messageController,
                onChanged: (value) {
                  setState(() {
                    if (value.isEmpty) {
                      iconPath = 'assets/icons/mic.png';
                    } else {
                      iconPath = 'assets/icons/send.png';
                    }
                  });
                },
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(left: 10, top: 10, bottom: 10),
                  hintText: "Send a message",
                  filled: true,
                  //No border
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),

                  //Rounded border
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
          ),
          smallSpace(),
          GestureDetector(
            onTap: () {
              if (iconPath == "assets/icons/send.png") {
                widget.onMessageSend(widget.messageController.text, false);
                setState(() {
                  iconPath = "assets/icons/mic.png";
                });
                return;
              }
              if (iconPath == "assets/icons/listening.png") {
                return;
              }
              if (iconPath == "assets/icons/stop.png") {
                iconPath = "assets/icons/mic.png";
                audioPlayer.stop();
                setState(() {});
                return;
              }
              speechToText(
                  stt: widget.speech,
                  onRecording: () {
                    setState(() {
                      iconPath = 'assets/icons/listening.png';
                    });
                    log('recording');
                  },
                  onNoResult: () {
                    setState(() {
                      iconPath = 'assets/icons/mic.png';
                    });
                  },
                  onResult: (value) {
                    log('message');
                    log(value);
                    setState(() {
                      iconPath = 'assets/icons/mic.png';
                      widget.onMessageSend(widget.messageController.text, true);
                    });
                  },
                  text: (value) {
                    log(value);
                    widget.messageController.text = value;
                  });
              /*               widget.onMessageSend(widget.messageController.text);
     */
            },
            child: Image.asset(
              iconPath,
            ),
          ),
        ],
      ),
    );
  }
}
