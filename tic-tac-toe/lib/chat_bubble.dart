import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {
  final String message;
  final bool isSentByMe;

  const ChatBubble({
    required this.message,
    required this.isSentByMe,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment:
            isSentByMe ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          Container(
            constraints: BoxConstraints(maxWidth: 200),
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: isSentByMe ? Colors.blue : Colors.grey[300],
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
                bottomLeft:
                    isSentByMe ? Radius.circular(20) : Radius.circular(0),
                bottomRight:
                    isSentByMe ? Radius.circular(0) : Radius.circular(20),
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
