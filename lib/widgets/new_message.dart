import 'package:chat_flutter/core/services/auth/auth_service.dart';
import 'package:chat_flutter/core/services/chat/chat_services.dart';
import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class NewMessage extends StatefulWidget {
  const NewMessage(this.channel, {super.key});
  final WebSocketChannel channel;

  @override
  State<NewMessage> createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: controller,
            onSubmitted: (_) {
              if (_message.trim().isNotEmpty) {
                _sendMessage();
              }
            },
            onChanged: (text) => setState(() => _message = text),
            decoration: const InputDecoration(labelText: 'Enviar mensagem...'),
          ),
        ),
        IconButton(
          icon: const Icon(Icons.send),
          onPressed: () => _message.trim().isEmpty ? null : _sendMessage(),
        ),
      ],
    );
  }

  String _message = "";
  final controller = TextEditingController();

  Future<void> _sendMessage() async {
    final user = AuthService().currentUser;

    if (user == null) return;

    await ChatServices().save(_message, user, widget.channel);
    controller.clear();
  }
}
