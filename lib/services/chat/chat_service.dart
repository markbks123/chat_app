import 'package:chat_app/model/message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatService extends ChangeNotifier {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // send Message

  Future<void> sendMessage(String receiverId, String message) async {
    final String currentUserId = _firebaseAuth.currentUser!.uid;
    final String currentUserEmail = _firebaseAuth.currentUser!.email.toString();
    final Timestamp timestamp = Timestamp.now();

    Message newMessage = Message(
        senderId: currentUserId,
        senderEmail: currentUserEmail,
        receiverId: receiverId,
        message: message,
        timestamp: timestamp);
    // chat romm id
    List<String> ids = [currentUserId, receiverId];
    ids.sort();
    String chatRommId = ids.join("_");

    //add new message to database
    await _firestore
        .collection('chat_rooms')
        .doc(chatRommId)
        .collection("messages")
        .add(newMessage.toMap());
  }

  //Get messages
  Stream<QuerySnapshot> getMessages(String userId, String otherUserId) {
    List<String> ids = [userId, otherUserId];
    ids.sort();
    String chatRommId = ids.join("_");

    return _firestore
        .collection("chat_rooms")
        .doc(chatRommId)
        .collection("messages")
        .orderBy("timestamp", descending: false)
        .snapshots();
  }
}
