import 'package:firebase_all_example/Phone_Auth/vaerify_otp.dart';
import 'package:firebase_all_example/Utils/util.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../Widgets/round_button.dart';
class HomeNumber extends StatefulWidget {
  const HomeNumber({super.key});

  @override
  State<HomeNumber> createState() => _HomeNumberState();
}

class _HomeNumberState extends State<HomeNumber> {
   TextEditingController phoneNumberController=TextEditingController();
  bool loading=false;
  void verifyNumber(){
    final auth=FirebaseAuth.instance;
    auth.verifyPhoneNumber(
      phoneNumber: phoneNumberController.text.toString(),
        verificationCompleted: (_){
          setState(() {
            loading=false;
          });
        },
        verificationFailed: (e){
          Utils().toastMessage(e.toString());
          setState(() {
            loading=false;
          });
        },
        codeSent: (String verificationId, int? token){
          Navigator.push(context, MaterialPageRoute(builder: (Context)=>
            VerifiyOtp(verificationId: verificationId)));
          setState(() {
            loading=false;
          });
        },
        codeAutoRetrievalTimeout: (e){
          Utils().toastMessage(e.toString());
          setState(() {
            loading=false;
          });
        });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Authentication by phone number'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const SizedBox(height: 80,),

            TextFormField(
              controller: phoneNumberController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  hintText: '+880 179.......'
              ),
            ),
            const SizedBox(height: 80,),
            RoundButton(
                title: 'Send OTP',
                loading: loading,
                onTap: (){
                  verifyNumber();
                }
            ),

          ],
        ),
      ),
    );
  }
}
