import 'package:chatroom/screens/Chat/components/messagesbubbles.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Messages extends StatefulWidget {
  const Messages({super.key});

  @override
  State<Messages> createState() => _MessagesState();
}

class _MessagesState extends State<Messages> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('chat')
            .orderBy('createdAt', descending: true)
            .snapshots(),
        builder: (ctx, Snapshot) {
          if (Snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          }
          final docs = (Snapshot.data! as QuerySnapshot).docs;
          final user =   FirebaseAuth.instance.currentUser;
          return ListView.builder(
              reverse: true,
              itemCount: docs.length,
              itemBuilder: (ctx, index) => MessageBubble(
                  docs[index]['text'],
                  docs[index]['username'],
                  docs[index]['userImage'],
                  docs[index]['userid'] == user!.uid,
                  key: ValueKey(docs[index])));
        },
      ),
    );
  }
}
