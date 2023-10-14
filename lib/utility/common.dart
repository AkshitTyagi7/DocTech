import 'package:flutter/material.dart';

import '../models/character.dart';

String languageCode(BuildContext context) => Localizations.localeOf(context).languageCode;
// ignore: avoid_print
void log(message) => print(message);
Widget divider = const Divider(
  color: Color.fromRGBO(190, 190, 190, 1),
  height: 0,
);
Gradient primarySecondaryGradient(BuildContext context) => const LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        Color.fromRGBO(251, 78, 210, 1),
        Color.fromRGBO(125, 45, 246, 1),
      ],
    );

EdgeInsets commonPadding = const EdgeInsets.only(left: 20, right: 20);
/* Create Show Snackbar */

void showSnackBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(message),
    duration: const Duration(seconds: 2),
  ));
}

CharacterVoice defaultVoice = CharacterVoice(id: -1, name: 'en-US-Neural2-J', code: 'en-US', pitch: 0, speed: 1);
