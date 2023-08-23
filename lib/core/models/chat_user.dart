class ChatUser {
  ChatUser({
    required this.id,
    required this.name,
    required this.email,
    required this.imageUrl,
  });

  final String id;
  final String name;
  final String email;
  final String imageUrl;

  @override
  String toString() {
    return 'ChatUser(id: $id, name: $name, email: $email, imageUrl: $imageUrl)';
  }
}
