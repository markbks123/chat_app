import 'dart:ffi';

import 'package:chat_app/theme/my_colors.dart';
import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {
  final String message;
  final bool setId;
  const ChatBubble({super.key, required this.message, required this.setId});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: setId ? MyColors.green : MyColors.primary,
      ),
      child: Text(
        message,
        style: const TextStyle(fontSize: 16, color: MyColors.white),
      ),
    );
  }
}
