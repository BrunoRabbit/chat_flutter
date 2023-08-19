import 'package:chat_flutter/core/models/chat_message.dart';
import 'package:chat_flutter/core/services/auth/auth_service.dart';
import 'package:chat_flutter/core/services/chat/chat_services.dart';
import 'package:chat_flutter/widgets/bubble_message.dart';
import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class Messages extends StatelessWidget {
  const Messages(this.channel, {super.key});
  
  final WebSocketChannel channel;

  @override
  Widget build(BuildContext context) {
    final currentUser = AuthService().currentUser;

    return StreamBuilder<List<ChatMessage>>(
        stream: ChatServices().messagesStream(channel),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('not hasData'));
          } else {
            final msg = snapshot.data!;
            return ListView.builder(
              itemCount: msg.length,
              reverse: true,
              itemBuilder: (context, index) {
                return BubbleMessage(
                  key: ValueKey(msg[index].id),
                  message: msg[index],
                  isBelongsToCurrentUser: currentUser?.id == msg[index].userId,
                );
              },
            );
          }
        });
  }
}
