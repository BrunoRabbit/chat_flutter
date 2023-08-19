import 'package:chat_flutter/core/services/auth/auth_service.dart';
import 'package:chat_flutter/widgets/messages.dart';
import 'package:chat_flutter/widgets/new_message.dart';
import 'package:flutter/material.dart';

import 'package:web_socket_channel/status.dart' as status;
import 'package:web_socket_channel/web_socket_channel.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  late WebSocketChannel channel;

  @override
  void initState() {
    super.initState();
    _initWebSocket();
  }

  @override
  void dispose() {
    channel.sink.close(status.goingAway);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat_Flutter'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: DropdownButtonHideUnderline(
              child: DropdownButton(
                icon: Icon(
                  Icons.more_vert,
                  color: Theme.of(context).primaryIconTheme.color,
                ),
                items: [
                  DropdownMenuItem(
                    value: 'logout',
                    child: Row(
                      children: const [
                        Icon(
                          Icons.exit_to_app,
                          color: Colors.black87,
                        ),
                        SizedBox(width: 10),
                        Text('Sair'),
                      ],
                    ),
                  ),
                ],
                onChanged: (item) {
                  if (item == 'logout') {
                    AuthService().logout();
                  }
                },
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Messages(channel),
            ),
            NewMessage(channel)
          ],
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   child: const Icon(Icons.add),
      //   onPressed: () {
      //     service.add(
      //       ChatNotification(
      //         title: 'title',
      //         body: Random().nextDouble().toString(),
      //       ),
      //     );
      //   },
      // ),
    );
  }

  Future<void> _initWebSocket() async {
    const String url = "ws://192.168.15.9:3000";
    final wsChannel = Uri.parse(url);
    try {
      channel = WebSocketChannel.connect(wsChannel);
    } catch (e) {
      throw Exception('Server not initialized');
    }
  }
}
