import 'package:flutter/material.dart';


class splash_screen extends StatelessWidget {
  const splash_screen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
     body: const Center(child: Text('Loading . . .',
     style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
     )),  
    );
  }
}