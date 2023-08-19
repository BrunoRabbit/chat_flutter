// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:flutter/material.dart';

import 'package:chat_flutter/core/models/chat_message.dart';

class BubbleMessage extends StatelessWidget {
  const BubbleMessage({
    Key? key,
    required this.message,
    required this.isBelongsToCurrentUser,
  }) : super(key: key);

  final ChatMessage message;
  final bool isBelongsToCurrentUser;

  static const String _defaultImage = 'assets/images/avatar.png';

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Row(
          mainAxisAlignment: isBelongsToCurrentUser
              ? MainAxisAlignment.end
              : MainAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                color: isBelongsToCurrentUser
                    ? Colors.grey.shade300
                    : Theme.of(context).colorScheme.secondary,
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(12),
                  topRight: const Radius.circular(12),
                  bottomLeft: isBelongsToCurrentUser
                      ? const Radius.circular(12)
                      : Radius.zero,
                  bottomRight: isBelongsToCurrentUser
                      ? Radius.zero
                      : const Radius.circular(12),
                ),
              ),
              width: 180,
              margin: const EdgeInsets.symmetric(
                vertical: 15,
                horizontal: 8,
              ),
              padding: const EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 16,
              ),
              child: Column(
                crossAxisAlignment: isBelongsToCurrentUser
                    ? CrossAxisAlignment.end
                    : CrossAxisAlignment.start,
                children: [
                  Text(
                    message.userName,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color:
                          isBelongsToCurrentUser ? Colors.black : Colors.white,
                    ),
                  ),
                  Text(
                    message.text,
                    textAlign: isBelongsToCurrentUser
                        ? TextAlign.right
                        : TextAlign.left,
                    style: TextStyle(
                      color:
                          isBelongsToCurrentUser ? Colors.black : Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        Positioned(
          top: 0,
          left: isBelongsToCurrentUser ? null : 165,
          right: isBelongsToCurrentUser ? 165 : null,
          child: Builder(
            builder: (context) {
              ImageProvider? provider;
              final uri = Uri.parse(message.imageUrl);

              provider = FileImage(File(uri.toString()));

              if (uri.scheme.contains('http')) {
                provider = NetworkImage(uri.toString());
              }

              if (uri.path.contains(_defaultImage)) {
                provider = const AssetImage(_defaultImage);
              }

              return CircleAvatar(
                backgroundImage: provider,
              );
            },
          ),
        ),
      ],
    );
  }
}
