import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class chat_screen extends StatefulWidget {
  const chat_screen({super.key});

  @override
  State<chat_screen> createState() => _chat_screenState();
}

class _chat_screenState extends State<chat_screen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('chats/9TDJslWxm7SviEy4RYz2/messages')
            .snapshots(),
        builder: (ctx, Snapshot) {
          if (Snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          }
          final docs = (Snapshot.data! as QuerySnapshot).docs;
          return ListView.builder(
              itemCount: docs.length,
              itemBuilder: (ctx, index) => Container(
                    padding: EdgeInsets.all(8),
                    child: Text("${docs[index]['text']} "),
                  ));
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          FirebaseFirestore.instance
              .collection('chats/9TDJslWxm7SviEy4RYz2/messages')
              .add({'text': ''});
        },
      ),
    );
  }
}
