import 'dart:async';

import 'package:firebase_all_example/Firebase_database/post_screen.dart';
import 'package:firebase_all_example/Ui/Auth/login_screens.dart';
import 'package:firebase_all_example/Ui/Auth/signup_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SplashServices{
  void isLogin(BuildContext context){
    final _auth=FirebaseAuth.instance;
    final _user=_auth.currentUser;
    if(_user!=null){
      Timer(Duration(seconds: 3), () {
        Navigator.push(context, MaterialPageRoute(builder: (context)=>PostScreen()));
      });
    }else{
      Timer(Duration(seconds: 3), () {
        Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
      });
    }

  }

}