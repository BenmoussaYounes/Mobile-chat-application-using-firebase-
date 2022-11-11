import 'dart:convert';


import 'package:chatroom/homeScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart'   as http;
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  final String url='https://chatbox-41f85-default-rtdb.firebaseio.com/Store.json';
  
  http.post(Uri.parse(url),body: json.encode({
    'title':'Math',
    'body':02,
    'author':'younes'
  }
  ));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ChatBox',
      theme: ThemeData(
        primarySwatch: Colors.amber,
        scaffoldBackgroundColor: Colors.orange[300],
      ),
      home:  homeScreen(),
    );
  }
}
