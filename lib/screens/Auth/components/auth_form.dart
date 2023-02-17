import 'dart:io';
import 'dart:ui';

import 'package:chatroom/screens/Chat/chatScreen.dart';
import 'package:chatroom/screens/pickers/UserImagePicker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class authform extends StatefulWidget {
   final void Function(String email, String password, String username, bool islogin, XFile? image, BuildContext ctx) submit_fc;
  bool isloading;
  authform(this.submit_fc, this.isloading);

  @override
  State<authform> createState() => _authform_State();
}

class _authform_State extends State<authform> {
  bool _isLogin = false;
  final _formKey = GlobalKey<FormState>();
  String _email = '';
  String _user_name = '';
  String _password = '';
  XFile? _userImageFile ;
  void _pickImage(XFile pickedImage){
   _userImageFile = pickedImage;
  }

  _submit(){ 
    FocusScope.of(context).unfocus();
    final _isvalid = _formKey.currentState!.validate();

    print('isvalid ${_isvalid}');
    if(_isLogin == false){
       ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please pick an image :D'),
      backgroundColor: Colors.redAccent,
      ));
      return;
    }
    if(_isvalid){
     _formKey.currentState!.save();
     print('here ERROR ->');
     widget.submit_fc(_email.trim(),_password.trim(),_user_name.trim(),_isLogin, _userImageFile, context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Container(
              margin: EdgeInsets.all(17),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  if(!_isLogin)  UserImagePicker(_pickImage),
                  emailForm(),
                  if(!_isLogin) usenameForm(),
                  passwordForm(),
                  if(widget.isloading == true) const CircularProgressIndicator(),
                  if (widget.isloading == false)
                  loginButton(),
                  if(widget.isloading == false)newaccButton()
                  
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }


  Padding passwordForm() {
    return Padding(
      padding: const EdgeInsets.only(top: 8, left: 5, right: 5),
      child: TextFormField(
        key: ValueKey('password'),
        decoration: const InputDecoration(
            hintText: 'Enter your password here ', icon: Icon(Icons.lock)),
        keyboardType: TextInputType.visiblePassword,
        obscureText: true,
        validator: (_val){
          if(_val!.isEmpty|| _val.length < 7){
            return 'Please enter at least 7 characters';
          }
          return null;
        },
        onSaved: (val) => _password = val! ,
      ),
    );
  }
 Padding emailForm() {
    return Padding(
      padding: const EdgeInsets.only(top: 8, left: 5, right: 5),
      child: TextFormField(
        key: ValueKey('email'),
        decoration: const InputDecoration(
          hintText: 'Enter your email',
          icon: Icon(Icons.email_outlined),
        ),

        keyboardType: TextInputType.emailAddress,
        validator: (val) {
          if (val == null || val.isEmpty) {
            return 'Please Enter your email ! ';
          }
          return null;
        },
        onSaved: (val){_email = val!;},
      ),
    );
  }
  Padding usenameForm() {
    return Padding(
      padding: const EdgeInsets.only(top: 8, left: 5, right: 5),
      child: TextFormField(
        key: ValueKey('name'),
        decoration: const InputDecoration(
          hintText: 'Enter your User Name here ',
          icon: Icon(Icons.person_outline_rounded),
        ),
        keyboardType: TextInputType.emailAddress,
        validator: (val) {
          if (val == null || val.isEmpty) {
            print('prblm USER NAME');
            return 'Please Enter your user name here ! ';
          }
          return null;
        },
        onSaved: (val) => _user_name = val!,
      ),
    );
  }

  Padding loginButton() {
    return Padding(
      padding: const EdgeInsets.only(top: 15, left: 5, right: 5),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
              //backgroundColor: Colors.pink,
              fixedSize: const Size(120, 40),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50))),
        onPressed: () {
            _submit();
            //ScaffoldMessenger.of(context)
               // .showSnackBar(const SnackBar(content: Text('Processing Data')));
               // Navigator.push(   context,MaterialPageRoute(builder: (context) => const chat_screen()),);
        },
        child: Text(_isLogin?'Login':'Sign Up'),
      ),
    );
  }


  TextButton newaccButton() {
    return TextButton(
        onPressed: () {
          setState(() {
            _isLogin = !_isLogin;
          });
        },
         child: Text(_isLogin?'Create a new Account':'Already have an acount'));
  }

}
