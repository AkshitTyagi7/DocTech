import 'package:doctech/components/character_item.dart';
import 'package:doctech/models/character.dart';
import 'package:doctech/utility/common.dart';
import 'package:doctech/utility/rest_api.dart';
import 'package:doctech/widgets/spaces.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../routes/app_routes.dart';

class DoctoListingScreen extends StatefulWidget {
  const DoctoListingScreen({super.key});

  @override
  State<DoctoListingScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<DoctoListingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, Routes.createCharacter);
        },
        child: Icon(Icons.add),
      ),
      appBar: AppBar(
        elevation: 0,
        title: Text(
          "AI Doctors",
          style: TextStyle(color: Colors.black, fontSize: 20),
        ),
        leading: Container(
          padding: EdgeInsets.all(10),
          height: 30,
          width: 10,
          child: Image.asset(
            'assets/logo.png',
            fit: BoxFit.fill,
            height: 30,
          ),
        ),
        backgroundColor: Theme.of(context).colorScheme.background,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            largeSpace(),
            Expanded(
                child: FutureBuilder(
                    future: getCharacters(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return ListView.builder(
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) {
                              return CharacterItem(character: snapshot.data![index]);
                            });
                      } else if (snapshot.hasError) {
                        print(snapshot.stackTrace.toString());
                        return Text(snapshot.error.toString() + snapshot.stackTrace.toString());
                      }
                      return CircularProgressIndicator();
                    })
/*               ListView(
                children: [
                  CharacterItem(
                      character: Character(
                          id: 1,
                          name: 'Ben',
                          voice: CharacterVoice(id: 1, name: 'en-US-Neural2-J', code: 'en-US', pitch: 0, speed: 1),
                          image:
                              'https://images.rawpixel.com/image_800/cHJpdmF0ZS9sci9pbWFnZXMvd2Vic2l0ZS8yMDIzLTA3L2FpZ2VuZXJhdGVkLTI0MDcyMy1yb2JfcmF3cGl4ZWxfc2VuaW9yX2luZGlhbl9kb2N0b3Jfc21hbGxfc21pbGVfZmF0X2luZGlhbl9ncF9pbl9fZjQyNmFjODEtYmMyOC00ZmFjLThjOWUtZmQ2NGE3Y2RjYzAxLWhxLXNjYWxlLTVfMDB4LmpwZw.jpg',
                          lastMessage: 'Hello')),
                  smallSpace(),
                  CharacterItem(
                      character: Character(
                          id: 1,
                          name: 'Ben',
                          voice: CharacterVoice(id: 1, name: 'en-US-Neural2-J', code: 'en-US', pitch: 0, speed: 1),
                          image:
                              'https://images.rawpixel.com/image_800/cHJpdmF0ZS9sci9pbWFnZXMvd2Vic2l0ZS8yMDIzLTA3L2FpZ2VuZXJhdGVkLTI0MDcyMy1yb2JfcmF3cGl4ZWxfc2VuaW9yX2luZGlhbl9kb2N0b3Jfc21hbGxfc21pbGVfZmF0X2luZGlhbl9ncF9pbl9fZjQyNmFjODEtYmMyOC00ZmFjLThjOWUtZmQ2NGE3Y2RjYzAxLWhxLXNjYWxlLTVfMDB4LmpwZw.jpg',
                          lastMessage: 'Hello')),
                ],
              ), */
                ),
          ],
        ),
      ),
    );
  }
}
