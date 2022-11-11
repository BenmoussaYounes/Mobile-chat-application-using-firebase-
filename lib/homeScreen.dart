import 'dart:ffi';

import 'package:flutter/material.dart';

class homeScreen extends StatefulWidget {
 

  @override
  State<homeScreen> createState() => _homeScreenState();
}

class _homeScreenState extends State<homeScreen> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: const Text('Home',style: TextStyle(
          fontSize: 18,
          color: Colors.black
        ),),
      ),
      
      floatingActionButton: FloatingActionButton(
        onPressed: (){},
        child: const Icon(Icons.add),
      ),
    );
  }
}