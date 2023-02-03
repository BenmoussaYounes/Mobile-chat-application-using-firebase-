import 'dart:ui';

import 'package:chatroom/screens/Chat/chatScreen.dart';
import 'package:flutter/material.dart';

class authform extends StatefulWidget {
   final void Function(String email, String password, String username, bool islogin, BuildContext ctx) submit_fc;
  bool isloading;
  authform(this.submit_fc, this.isloading);

  @override
  State<authform> createState() => _authform_State();
}

class _authform_State extends State<authform> {
  bool _isLogin = false ;
  final _formKey = GlobalKey<FormState>();
  String _email = '';
  String _user_name = '';
  String _password = '';
  _submit(){
   
    final _isvalid = _formKey.currentState!.validate();
    print('isvalid ${_isvalid}');
    FocusScope.of(context).unfocus();
    if(_isvalid){
     _formKey.currentState!.save();
     widget.submit_fc(_email.trim(),_password.trim(),_user_name.trim(),_isLogin, context);
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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                emailForm(),
                if(!_isLogin) usenameForm(),
                passwordForm(),
                if(widget.isloading == true) CircularProgressIndicator(),
                if (widget.isloading == false)
                loginButton(),
                if(widget.isloading == false)newaccButton()
                
              ],
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
      padding: const EdgeInsets.only(top: 8, left: 5, right: 5),
      child: ElevatedButton(
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
