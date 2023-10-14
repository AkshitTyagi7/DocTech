import 'package:flutter/material.dart';

class CharacterOption {
  final int id;
  final String name;
  final String? title;
  final String language;
  final String? image;

/*   final DateTime createdAt; */
  CharacterOption({
    required this.id,
    required this.name,
    required this.language,
    this.title,
    this.image,
/*     required this.createdAt, */
  });

  factory CharacterOption.fromJson(Map<String, dynamic> json) {
    return CharacterOption(
      id: json['id'],
      name: json['name'],
      title: json['title'],
      language: json['language_code'] ?? json['language'] ?? 'en',
      image: json['image'],
/*       createdAt: DateTime.parse(json['created_at']), */
    );
  }
}

class CharacterOptions {
  final List<CharacterOption> characteristics;

  final List<CharacterOption> voices;

  CharacterOptions({
    required this.characteristics,
    required this.voices,
  });

  factory CharacterOptions.fromJson(Map<String, dynamic> json) {
    CharacterOptions option = CharacterOptions(
      characteristics: (json['characteristics'] as List).map((e) => CharacterOption.fromJson(e)).toList(),
      voices: (json['voices'] as List).map((e) => CharacterOption.fromJson(e)).toList(),
    );
    return option;
  }
}
