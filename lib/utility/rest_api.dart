import '../models/character.dart';
import '../models/message.dart';
import '../models/option.dart';
import '../pref_data.dart';
import 'network/network_utility.dart';

Future<CharacterMessage> sendMessage({required int characterId, required CharacterMessageData message}) async {
  String token = await PrefData.getSessionToken();
  var res = await buildHttpResponse(
    'aidoctor/sendMessage',
    request: {'character_id': characterId, 'message': message, 'usertoken': token},
    method: HttpMethod.POST,
  );
  CharacterMessage characterMessage = CharacterMessage.fromJson(res['data']);
  return characterMessage;
}

Future<CharacterMessageData> getCharacterChats({required int characterId, int? page}) async {
  String token = await PrefData.getSessionToken();
  var res = await buildHttpResponse(
    'aidoctor/getCharacterChats?character_id=$characterId&page=$page&usertoken=$token',
    method: HttpMethod.GET,
  );
  CharacterMessageData messages = CharacterMessageData.fromJson(res);
  return messages;
}

Future<CharacterOptions> getCharacterOptions() async {
  var res = await buildHttpResponse('aidoctor/getOptions', method: HttpMethod.GET);
  CharacterOptions options = CharacterOptions.fromJson(res);
  return options;
}

Future<List<Character>> getCharacters() async {
  String token = await PrefData.getSessionToken();
  var res = await buildHttpResponse(
    'aidoctor/getCharacters?usertoken=$token',
    method: HttpMethod.GET,
  );

  List<Character> characters = (res['characters'] as List).map((e) => Character.fromJson(e)).toList();
  return characters;
}
