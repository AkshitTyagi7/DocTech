class Character {
  final int id;
  final String name;
  final String image;
  final String lastMessage;
  final CharacterVoice voice;

  Character({required this.id, required this.name, required this.image, required this.lastMessage, required this.voice});

  factory Character.fromJson(Map<String, dynamic> json) {
    return Character(
        id: json['id'], name: json['name'], image: json['image'], lastMessage: json['lastMessage'], voice: CharacterVoice.fromJson(json['voice']));
  }
}

class CharacterVoice {
  final int id;
  final String name;
  final String code;
  final int pitch;
  final int speed;

  CharacterVoice({
    required this.id,
    required this.name,
    required this.code,
    required this.pitch,
    required this.speed,
  });

  factory CharacterVoice.fromJson(Map<String, dynamic> json) {
    return CharacterVoice(
      id: json['id'],
      name: json['name'],
      code: json['code'],
      pitch: json['pitch'],
      speed: json['speed'],
    );
  }
}
