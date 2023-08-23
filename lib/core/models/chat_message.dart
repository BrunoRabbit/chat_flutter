import 'dart:convert';

class ChatMessage {
  ChatMessage({
    required this.id,
    required this.text,
    required this.createdAt,
    required this.userId,
    required this.userName,
    required this.imageUrl,
  });

  final String id;
  final String text;
  final String createdAt;

  final String userId;
  final String userName;
  final String imageUrl;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'text': text,
      'createdAt': createdAt,
      'userId': userId,
      'userName': userName,
      'imageUrl': imageUrl,
    };
  }

  factory ChatMessage.fromMap(Map<String, dynamic> map) {
    return ChatMessage(
      id: map['id'].toString(),
      text: map['text'] as String,
      createdAt: map['createdAt'] as String,
      userId: map['userId'] as String,
      userName: map['userName'] as String,
      imageUrl: map['imageUrl'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ChatMessage.fromJson(String source) =>
      ChatMessage.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ChatMessage(id: $id, text: $text, createdAt: $createdAt, userId: $userId, userName: $userName, imageUrl: $imageUrl)';
  }
}
