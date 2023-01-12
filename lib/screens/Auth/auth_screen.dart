
import 'package:chatroom/screens/Auth/components/auth_form.dart';
import 'package:flutter/material.dart';


class Authscreen extends StatelessWidget{
  const Authscreen({super.key});

@override
Widget build(BuildContext context){

return Scaffold(
  backgroundColor: Theme.of(context).primaryColor,
  body: authform(),
);
}


}