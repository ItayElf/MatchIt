import 'dart:convert';

class CardData {
  final String name;
  final String? imageUrl;
  final String? description;

  const CardData({
    required this.name,
    this.imageUrl,
    this.description,
  });

  CardData copyWith({
    String? name,
    String? imageUrl,
    String? description,
  }) {
    return CardData(
      name: name ?? this.name,
      imageUrl: imageUrl ?? this.imageUrl,
      description: description ?? this.description,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'imageUrl': imageUrl,
      'description': description,
    };
  }

  factory CardData.fromMap(Map<String, dynamic> map) {
    return CardData(
      name: map['name'] as String,
      imageUrl: map['imageUrl'] != null ? map['imageUrl'] as String : null,
      description:
          map['description'] != null ? map['description'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory CardData.fromJson(String source) =>
      CardData.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'CardData(name: $name, imageUrl: $imageUrl, description: $description)';

  @override
  bool operator ==(covariant CardData other) {
    if (identical(this, other)) return true;

    return other.name == name &&
        other.imageUrl == imageUrl &&
        other.description == description;
  }

  @override
  int get hashCode => name.hashCode ^ imageUrl.hashCode ^ description.hashCode;
}
