import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {
  final String message;
  final bool isSentByMe;

  const ChatBubble({
    required this.message,
    required this.isSentByMe,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment:
            isSentByMe ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          Container(
            constraints: const BoxConstraints(maxWidth: 200),
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: isSentByMe ? Colors.blue : Colors.grey[300],
              borderRadius: BorderRadius.only(
                topLeft: const Radius.circular(20),
                topRight: const Radius.circular(20),
                bottomLeft:
                    isSentByMe ? const Radius.circular(20) : const Radius.circular(0),
                bottomRight:
                    isSentByMe ? const Radius.circular(0) : const Radius.circular(20),
              ),
            ),
            child: Text(
              message,
              style: TextStyle(color: isSentByMe ? Colors.white : Colors.black),
            ),
          ),
        ],
      ),
    );
  }
}
