import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class NewMessages extends StatefulWidget {
  const NewMessages({super.key});

  @override
  State<NewMessages> createState() => _NewMessagesState();
}

class _NewMessagesState extends State<NewMessages> {
  final _controller = TextEditingController();
  String _entredmessage = '';
 
  _sendmessages()async{
    FocusScope.of(context).unfocus();
    // send message
     final user =   await FirebaseAuth.instance.currentUser;
     final  userInfo =  await FirebaseFirestore.instance.collection('users').doc(user!.uid).get();
     FirebaseFirestore.instance .collection('chat').add({
      'text': _entredmessage,
      'createdAt':Timestamp.now(),
     'username':userInfo['userName'],
     'userid':user.uid,
     'userImage':userInfo['image_url']
     });
    _controller.clear();
     }
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 8),
      padding: const EdgeInsets.all(8),
      child: Row(children: [
        Expanded(child: TextField(
          controller: _controller,
          decoration: const InputDecoration(
            labelText: 'Send a message . . .'
          ),
          onChanged: (val){
            setState(() {
              _entredmessage = val;
            });
          },
        )),
        IconButton(onPressed: _entredmessage.trim().isEmpty? null: _sendmessages, icon:Icon(Icons.send,color: Theme.of(context).primaryColor))
      ],),
    );
  }
}