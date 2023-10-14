import 'package:cached_network_image/cached_network_image.dart';
import 'package:doctech/models/character.dart';
import 'package:flutter/material.dart';

import '../screens/chat/character_chat.dart';

class CharacterItem extends StatelessWidget {
  final Character character;
  const CharacterItem({super.key, required this.character});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (_) => CharacterChatScreen(character: character)));
      },
      child: Container(
        //     decoration: BoxDecoration(
        //       borderRadius: BorderRadius.all(Radius.circular(8)),
        // border: Border.all(color: Colors.green,width: 2)
        // ),
        //   padding: EdgeInsets.all(15),
        margin: EdgeInsets.only(bottom: 27),
        alignment: Alignment.topLeft,

        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipRRect(
                borderRadius: BorderRadius.circular(900),
                child: CachedNetworkImage(
                  imageUrl: character.image,
                  width: 65.35,
                  height: 59.95,
                  fit: BoxFit.cover,
                  placeholder: (context, s) => Container(color: Colors.grey.withOpacity(0.5)),
                )),
            Container(
              width: MediaQuery.of(context).size.width - 99,
              padding: EdgeInsets.only(left: 13),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(character.name, textAlign: TextAlign.left, style: Theme.of(context).textTheme.titleLarge),
                  Container(
                    padding: EdgeInsets.only(top: 5, bottom: 11),
                    child: Text(
                        (character.lastMessage.isEmpty
                            ? 'No conversation yet'
                            : (character.lastMessage.length > 80 ? character.lastMessage.substring(0, 80) + '.....' : character.lastMessage)),
                        textAlign: TextAlign.left),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
