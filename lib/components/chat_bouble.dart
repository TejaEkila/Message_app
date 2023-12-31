// ignore_for_file: unused_import

import 'package:easylazy/models/messager.dart';
import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {
  final String message;
  const ChatBubble({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.deepPurpleAccent
        ),
        child: Text(
          message,
          style: const TextStyle(fontSize: 14,color: Colors.white),
        ),
    );
  }
}