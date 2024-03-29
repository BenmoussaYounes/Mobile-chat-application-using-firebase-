
import 'package:chatroom/screens/Auth/auth_screen.dart';
import 'package:chatroom/screens/Chat/chatScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

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
        primaryColor: Colors.pinkAccent,
        primarySwatch: Colors.pink,
        backgroundColor: Colors.pink,
        accentColor: Colors.deepPurple,
        accentColorBrightness:  Brightness.dark,
  
      ),
      home:  StreamBuilder(stream: FirebaseAuth.instance.authStateChanges(),builder: (ctx, snapshot){
        if (snapshot.hasData){
          return chat_screen();
        }else{
          return Authscreen();
        }
      }),
    );
}
}
