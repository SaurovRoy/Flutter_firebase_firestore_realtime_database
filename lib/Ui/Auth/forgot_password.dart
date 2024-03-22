import 'package:firebase_all_example/Utils/util.dart';
import 'package:firebase_all_example/Widgets/round_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  TextEditingController _emaiController=TextEditingController();
  final _auth=FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Forgot password'),
        centerTitle: true,
        elevation: 0,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TextField(
            keyboardType: TextInputType.emailAddress,
            controller:_emaiController ,
            decoration: InputDecoration(
              hintText: 'Write your Email',
            ),
          ),
          RoundButton(title: 'Verify',
              onTap:(){
               _auth.sendPasswordResetEmail(email: _emaiController.text).then((value){
                 Utils().toastMessage('We have sent you an email to change password');
               });
              }),
        ],
      ),
    );
  }
}
