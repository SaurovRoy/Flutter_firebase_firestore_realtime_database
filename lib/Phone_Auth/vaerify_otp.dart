import 'package:firebase_all_example/Firebase_database/post_screen.dart';
import 'package:firebase_all_example/Utils/util.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../Widgets/round_button.dart';
class VerifiyOtp extends StatefulWidget {
  String verificationId;
   VerifiyOtp({super.key,required this.verificationId});

  @override
  State<VerifiyOtp> createState() => _VerifiyOtpState();
}

class _VerifiyOtpState extends State<VerifiyOtp> {
  final _otpController=TextEditingController();
  bool _loading =false;
  void verifyOtp() async{
    final auth = FirebaseAuth.instance;
    final credential=PhoneAuthProvider.credential(
        verificationId: widget.verificationId,
        smsCode: _otpController.text.toString(),
    );
    setState(() {
      _loading=true;
    });
    try{
      await auth.signInWithCredential(credential);
      Navigator.push(context, MaterialPageRoute(builder: (context)=>PostScreen()));
      Utils().toastMessage("OTP Verification Successful");
      setState(() {
        _loading=false;
      });
    }catch(e){
      Utils().toastMessage(e.toString());
      setState(() {
        _loading=false;
      });
    }

  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: const Text('OTP Verification'),
      ),
      body:Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const SizedBox(height: 80,),

            TextFormField(
              controller: _otpController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  hintText: 'Enter your otp'
              ),
            ),
            const SizedBox(height: 80,),
            RoundButton(
                title: 'Confirm OTP',
                loading: _loading,
                onTap: (){
                  verifyOtp();
                }
            ),

          ],
        ),
      ),
    );
  }
}
