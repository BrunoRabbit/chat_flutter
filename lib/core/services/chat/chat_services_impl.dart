import 'dart:async';
import 'dart:convert';

import 'package:chat_flutter/core/models/chat_user.dart';
import 'package:chat_flutter/core/models/chat_message.dart';
import 'package:chat_flutter/core/services/chat/chat_services.dart';

import 'package:web_socket_channel/web_socket_channel.dart';

class ChatServicesImpl implements ChatServices {
  @override
  Stream<List<ChatMessage>> messagesStream(WebSocketChannel channel) {
    return channel.stream.map<List<ChatMessage>>((response) {
      final List<dynamic> responseData = json.decode(response);

      final List<ChatMessage> userData =
          responseData.map<ChatMessage>((messageData) {
        return ChatMessage.fromMap(messageData);
      }).toList();

      return userData;
    });
  }

  @override
  Future<ChatMessage?> save(
      String text, ChatUser loggedUser, WebSocketChannel channel) async {
    final msg = ChatMessage(
      id: '',
      text: text,
      createdAt: DateTime.now().toIso8601String(),
      userId: loggedUser.id,
      userName: loggedUser.name,
      imageUrl: loggedUser.imageUrl,
    );
    try {
      channel.sink.add(msg.toJson());

      return msg;
    } catch (e) {
      throw Exception('Connection Error');
    }
  }
}
