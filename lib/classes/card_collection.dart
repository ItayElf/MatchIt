import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:match_it/classes/card_data.dart';

class CardCollection {
  final String name;
  final List<CardData> cards;

  const CardCollection({
    required this.name,
    required this.cards,
  });

  CardCollection copyWith({
    String? name,
    List<CardData>? cards,
  }) {
    return CardCollection(
      name: name ?? this.name,
      cards: cards ?? this.cards,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'cards': cards.map((x) => x.toMap()).toList(),
    };
  }

  factory CardCollection.fromMap(Map<String, dynamic> map) {
    return CardCollection(
      name: map['name'] as String,
      cards: List<CardData>.from(
        (map['cards']).map(
          (x) => CardData.fromMap(x),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory CardCollection.fromJson(String source) =>
      CardCollection.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'CardCollection(name: $name, cards: $cards)';

  @override
  bool operator ==(covariant CardCollection other) {
    if (identical(this, other)) return true;

    return other.name == name && listEquals(other.cards, cards);
  }

  @override
  int get hashCode => name.hashCode ^ cards.hashCode;
}
