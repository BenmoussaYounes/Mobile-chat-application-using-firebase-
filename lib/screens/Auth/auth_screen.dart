import 'package:chatroom/screens/Auth/components/auth_form.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Authscreen extends StatefulWidget {
  const Authscreen({super.key});

  @override
  State<Authscreen> createState() => _AuthscreenState();
}

class _AuthscreenState extends State<Authscreen> {
        final FirebaseAuth auth = FirebaseAuth.instance;
         bool isloading = false;
  _submit_authForm(
      String email, String password, String username, bool islogin ,BuildContext ctx) async {
   
    try {
      UserCredential userResult;
      
      if (islogin) {
        userResult = await FirebaseAuth.instance  .signInWithEmailAndPassword(
          email: email,
          password: password);
      } else {
        setState(() {
        isloading = true;
      });
        userResult = await auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
                await  FirebaseFirestore.instance
              .collection('users').doc(userResult.user!.uid).set({
                'userName':username,
                'password':password
              }
              );
      }


    } on FirebaseAuthException catch (e) {
       setState(() {
        isloading = false;
      });
      isloading = false;
      String error = 'Smth went Wrong ';
      if (e.code == 'weak-password') {
        error = 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        error = 'The account already exists for that email.';
      }
      if (e.code == 'user-not-found') {
        error = 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        error = 'Wrong password provided for that user.';
      }
      ScaffoldMessenger.of(ctx).showSnackBar(SnackBar(content: Text(error),
      backgroundColor: Colors.redAccent,
      ));
      
    }catch(e){
       setState(() {
        isloading = false;
      });
      print(e);
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: authform(_submit_authForm, isloading),
    );
  }
}
