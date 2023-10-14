import 'package:flutter/material.dart';

import '../../../models/message.dart';

class CharacterChatItem extends StatelessWidget {
  final CharacterMessage message;
  const CharacterChatItem({super.key, required this.message});
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: message.role == 'user' ? Alignment.centerRight : Alignment.centerLeft,
      margin: message.role == 'user' ? const EdgeInsets.only(left: 50, bottom: 20) : const EdgeInsets.only(right: 50, bottom: 20),
      decoration: BoxDecoration(
          color: message.role == 'user' ? Theme.of(context).colorScheme.primary : Colors.grey.withOpacity(0.2),
          borderRadius: BorderRadius.only(
            bottomLeft: const Radius.circular(15),
            bottomRight: const Radius.circular(15),
            topLeft: message.role == 'user' ? const Radius.circular(15) : const Radius.circular(0),
            topRight: message.role == 'user' ? const Radius.circular(0) : const Radius.circular(15),
          )),
      padding: const EdgeInsets.all(16),
      child: Text(message.content,
          style: message.role == 'user'
              ? Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: Colors.white,
                  )
              : Theme.of(context).textTheme.bodyMedium!.copyWith(
                    height: 1.5,
                    color: Colors.black,
                  )),
    );
  }
}
