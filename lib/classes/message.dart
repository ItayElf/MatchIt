import 'dart:convert';

class Message {
  final String type;
  final dynamic content;

  const Message({
    required this.type,
    required this.content,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'type': type,
      'content': content,
    };
  }

  factory Message.fromMap(Map<String, dynamic> map) {
    return Message(
      type: map['type'] as String,
      content: map['content'] as dynamic,
    );
  }

  String toJson() => json.encode(toMap());

  factory Message.fromJson(String source) =>
      Message.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Message(type: $type, content: $content)';

  @override
  bool operator ==(covariant Message other) {
    if (identical(this, other)) return true;

    return other.type == type && other.content == content;
  }

  @override
  int get hashCode => type.hashCode ^ content.hashCode;
}
