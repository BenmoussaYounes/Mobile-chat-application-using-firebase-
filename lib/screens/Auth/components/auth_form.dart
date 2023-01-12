import 'dart:ui';

import 'package:chatroom/screens/chatScreen.dart';
import 'package:flutter/material.dart';

class authform extends StatefulWidget {
  @override
  State<authform> createState() => _authform_State();
}

class _authform_State extends State<authform> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                nameForm(),
                passwordForm(),
                loginButton(),
                newaccButton()
              ],
            ),
          ),
        ),
      ),
    );
  }

  TextButton newaccButton() {
    return TextButton(
        onPressed: () {}, child: const Text('Create a new Account'));
  }

  Padding passwordForm() {
    return Padding(
      padding: const EdgeInsets.only(top: 8, left: 5, right: 5),
      child: TextFormField(
        decoration: const InputDecoration(
            hintText: 'Enter your password here ', icon: Icon(Icons.lock)),
        keyboardType: TextInputType.visiblePassword,
        obscureText: true,
      ),
    );
  }

  Padding nameForm() {
    return Padding(
      padding: const EdgeInsets.only(top: 8, left: 5, right: 5),
      child: TextFormField(
        decoration: const InputDecoration(
          hintText: 'Enter your email',
          icon: Icon(Icons.person_outline_rounded),
        ),
        keyboardType: TextInputType.emailAddress,
        validator: (val) {
          if (val == null || val.isEmpty) {
            print('prblm here');
            return 'Please Enter your email ! ';
          }
          return null;
        },
      ),
    );
  }

  Padding loginButton() {
    return Padding(
      padding: const EdgeInsets.only(top: 8, left: 5, right: 5),
      child: ElevatedButton(
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            ScaffoldMessenger.of(context)
                .showSnackBar(const SnackBar(content: Text('Processing Data')));
          }
        },
        child: Text('Click me'),
      ),
    );
  }
}
