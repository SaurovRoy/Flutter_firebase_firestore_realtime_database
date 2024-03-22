import 'package:firebase_all_example/Firebase_database/post_screen.dart';
import 'package:firebase_all_example/Phone_Auth/home_number.dart';
import 'package:firebase_all_example/Ui/Auth/forgot_password.dart';
import 'package:firebase_all_example/Ui/Auth/signup_screen.dart';
import 'package:firebase_all_example/Widgets/round_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import '../../Utils/util.dart';
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final _formKey=GlobalKey<FormState>();
  final TextEditingController _emailController=TextEditingController();
  final TextEditingController _passwordController=TextEditingController();
 bool _obsecureText=true;
 bool loading=false;
  void logIn() async{
     setState(() {
       loading=true;
     });
     print('Wrong');
 FirebaseAuth.instance.signInWithEmailAndPassword(
       email: _emailController.text.toString(),
       password:_passwordController.text.toString()
   ).then((value) {
     Utils().toastMessage(value.user!.email.toString());
     Navigator.push(context, MaterialPageRoute(builder: (context)=>PostScreen()));
     setState(() {
       loading=false;
     });
   }).onError((error, stackTrace) {
      Utils().toastMessage(error.toString());
      setState(() {
        loading=false;
      });
   });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Log in '),
        centerTitle: true,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Form(
                child:Column(
                  children: [
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      controller: _emailController ,
                      decoration: const InputDecoration(
                        hintText: "Enter your Email",
                        prefixIcon: Icon(Icons.email),
                      ),
                      validator: (value){
                        if(value!.isEmpty){
                          return "Enter your email";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 10,),
                    TextFormField(
                      obscureText: _obsecureText,
                      keyboardType: TextInputType.emailAddress,
                      controller: _passwordController ,
                      decoration: InputDecoration(
                        hintText: "Enter your Email",
                        prefixIcon: const Icon(Icons.lock_open),
                        suffixIcon: _obsecureText==true?IconButton(
                            onPressed: (){
                              setState(() {
                                _obsecureText=false;
                              });
                            }, icon: const Icon(Icons.remove_red_eye)) :
                            IconButton(
                                onPressed: (){
                                  setState(() {
                                    _obsecureText=true;
                                  });
                                }, icon: const Icon(Icons.visibility_off)),
                      ),
                      validator: (value){
                        if(value!.isEmpty){
                          return "Enter your password";
                        }
                          return null;
                      },
                    ),
                    const SizedBox(height: 20,),
                    RoundButton(
                        title: 'Login',
                        loading: loading,
                        onTap: (){

                              logIn();

                        }
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Dont Have an Account?'),
                        TextButton(onPressed: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>const SignupScreen()));
                        }, child: const Text('SignUp')),
                        TextButton(onPressed: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>const ForgotPassword()));
                        }, child: const Text('Forgot password')),
                      ],
                    ),
                    const SizedBox(height: 15,),
                    InkWell(
                      onTap: (){
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => HomeNumber()));
                      },
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            border: Border.all(
                                color: Colors.black
                            )
                        ),
                        child: Center(
                          child: Text('Login with phone'),
                        ),
                      ),
                    )

                  ],
                )
            ),
          ],
        ),
      ),
    );
  }
}
