import 'package:chat_flutter/core/models/chat_message.dart';
import 'package:chat_flutter/core/models/chat_user.dart';
import 'package:chat_flutter/core/services/chat/chat_services_impl.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

abstract class ChatServices {
  Stream<List<ChatMessage>> messagesStream(WebSocketChannel channel);

  Future<ChatMessage?> save(
    String text,
    ChatUser loggedUser,
    WebSocketChannel channel,
  );

  factory ChatServices() {
    return ChatServicesImpl();
  }
}
