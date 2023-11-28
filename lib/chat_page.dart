// ignore_for_file: unused_local_variable, use_key_in_widget_constructors, avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easylazy/components/chat_bouble.dart';
import 'package:easylazy/components/mytextfield.dart';
import 'package:easylazy/servies/chat/chat_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  final String receiverUserEmail;
  final String receiverUserID;
  const ChatPage({
    Key? key,
    required this.receiverUserEmail,
    required this.receiverUserID,
  });

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _messagecontroller = TextEditingController();
  final ChatService _chatService = ChatService();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  void sendmessage() async {
    if (_messagecontroller.text.isNotEmpty) {
      try {
        await _chatService.sendMessage(
          widget.receiverUserID,
          _messagecontroller.text,
        );
        _messagecontroller.clear();
      } catch (e) {
        print("Error sending message: $e");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 0, 0, 0),
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Padding(
          padding: const EdgeInsets.only(right: 80),
          child: Text(widget.receiverUserEmail),
        ),
        actions: [
          IconButton(onPressed: (){}, icon: const Icon(Icons.video_call)),
          IconButton(onPressed: (){}, icon: const Icon(Icons.call)),
          //IconButton(onPressed: (){}, icon: Icon(Icons.settings)),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: _buildMessageList(),
          ),
          _buildMessageInput(),
        ],
      ),
    );
  }

  Widget _buildMessageList() {
    return StreamBuilder(
      stream: _chatService.getMessages(
        widget.receiverUserID,
        _firebaseAuth.currentUser!.uid,
      ),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Error ${snapshot.error}');
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text('Loading..');
        }
        return ListView(
          children: snapshot.data!.docs
              .map((document) => _buildMessageItem(document))
              .toList(),
        );
      },
    );
  }

  Widget _buildMessageItem(DocumentSnapshot document) {
    Map<String, dynamic>? data = document.data() as Map<String, dynamic>?;
    if (data == null) {
      return const SizedBox(); // or some other default widget
    }

    String senderEmail = data['senderEmail'] ?? '';
    String message = data['message'] ?? '';

    var alignment = (data['senderId'] == _firebaseAuth.currentUser!.uid)
        ? Alignment.centerRight
        : Alignment.centerLeft;

    return Container(
      alignment: alignment,
      child: Padding(
        padding: const EdgeInsets.all(4),
        child: Column(
          children: [
            Text(senderEmail),
            ChatBubble(message: data['message'])
          ],
        ),
      ),
    );
  }

  Widget _buildMessageInput() {
    return Row(
      children: [
        Expanded(
          flex: 6,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 30),
            child: mytextfield(
              Controller: _messagecontroller,
              hinttext: 'Enter something',
              obscureText: false,
            ),
          ),
        ),
        Expanded(
          
          child: Padding(
            padding: const EdgeInsets.only(right: 12),
            child: Padding(
              padding: const EdgeInsets.only(bottom: 45),
              child: IconButton(
                onPressed: sendmessage,
                icon: const Icon(
                  Icons.send,
                  color: Color.fromARGB(255, 255, 255, 255),
                  size: 40,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
