import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../models/character.dart';
import '../../../widgets/spaces.dart';
import '../../../widgets/widgets.dart';

class CharacterInfo extends StatelessWidget {
  final Character character;
  const CharacterInfo({super.key, required this.character});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
/*         Navigator.push(context, MaterialPageRoute(builder: (_) => CharacterChatScreen(character: character)));
 */
      },
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              AppNetworkImage(character.image.validate(), height: 95, width: 95),
              smallSpace(),
              Text(character.name.validate(), style: Theme.of(context).textTheme.titleLarge),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    smallSpace(),
/*                     categoryCards(context, character.categorys),
 */
                    smallSpace(),

                    //If greeting is more than

                    /*                  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SvgPicture.asset("assets/icons/itoken.svg"),
                        xSmallSpace(),
                        Text(character.itokenCount.toString(), style: Theme.of(context).textTheme.bodyMedium),
                        smallSpace(),
                        SvgPicture.asset("assets/icons/like.svg"),
                        xSmallSpace(),
                        Text(character.likeCount.toString(), style: Theme.of(context).textTheme.bodyMedium),
                        const Spacer(),
                        CircleNetworkImage(character.characterImage.validate(), height: 25, width: 25),
                        xSmallSpace(),
                        Text(character.createrName.validate(), style: Theme.of(context).textTheme.bodyMedium),
                      ],
                    ), */
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
