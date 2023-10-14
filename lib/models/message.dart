class CharacterMessage {
  String content;
  String role; /*   DateTime createdAt;
 */
  CharacterMessage({
    required this.content,
    required this.role,
    /* required this.createdAt, */
  });

  factory CharacterMessage.fromJson(Map<String, dynamic> json) {
    return CharacterMessage(
      content: json['content'],
      role: json['role'],
/*       createdAt: DateTime.parse(json['date']),
 */
    );
  }

  /* toJson method */
  Map<String, dynamic> toJson() {
    return {
      'content': content,
      'role': role,
    };
  }
}

class CharacterMessageData {
  List<CharacterMessage> messages;
  final String systemMessage;
  CharacterMessageData({
    required this.messages,
    required this.systemMessage,
  });

  /* From Json Method */
  factory CharacterMessageData.fromJson(Map<String, dynamic> json) {
    return CharacterMessageData(
      messages: (json['messages'] as List).map((e) => CharacterMessage.fromJson(e)).toList(),
      systemMessage: json['systemMessage'] ?? '',
    );
  }

  /* To json method */
  Map<String, dynamic> toJson() {
    return {
      'messages': messages.map((e) => e.toJson()).toList(),
      'systemMessage': systemMessage,
    };
  }
}
