import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easylazy/models/messager.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatService extends ChangeNotifier {
  //get instance of auth and firestore
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;
   //send message
  Future<void> sendMessage(String receiverId, String message) async {
    //get current user info
    final String currentUserId = _firebaseAuth.currentUser!.uid;
    final String currentUserEmail = _firebaseAuth.currentUser!.email.toString();
    final Timestamp timestamp = Timestamp.now();
//create a new message
    Message newMessage = Message(
      senderId: currentUserId,
      senderEmail: currentUserEmail,
      receiverId: receiverId,
      message: message,
      timestamp: timestamp,
    );
//constract chat room id from current user id and receiver id(sort to ensure uniqueness)
    List<String> ids = [currentUserId, receiverId];
    ids.sort();//sort the ids(thia ensures the chat room id is always the smae for any pair of people)
    String chatRoomId = ids.join("_");//combine the ids into a single string to use as chatroom
//add new message to database
    await _fireStore
        .collection('chat_rooms')
        .doc(chatRoomId)
        .collection('messages')
        .add(newMessage.toMap());
  }
 //get messages
  Stream<QuerySnapshot> getMessages(String userId, String otherUserId) {
    //constract chat room id from user ids (sorted to ensure it matches the id user when sending me)
    List<String> ids = [userId, otherUserId];
    ids.sort();
    String chatRoomId = ids.join("_");

    return _fireStore
        .collection('chat_rooms')
        .doc(chatRoomId)
        .collection('messages')
        .orderBy('timestamp', descending: false)
        .snapshots();
  }
}
