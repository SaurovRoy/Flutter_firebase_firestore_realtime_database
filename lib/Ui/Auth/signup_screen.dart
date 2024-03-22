import 'package:firebase_all_example/Ui/Auth/login_screens.dart';
import 'package:firebase_all_example/Utils/util.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../Widgets/round_button.dart';
class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  bool loading =false;

  final _formKey=GlobalKey<FormState>();
  TextEditingController _emailController=TextEditingController();
  TextEditingController _passwordController=TextEditingController();
   bool _obsecureTxt=true;

  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();

  }

  void signUp() async{

      setState(() {
        loading=true;
      });
      try {
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
            email: _emailController.text.toString(),
            password: _passwordController.text.toString(),
        );
        var authCredential = userCredential.user;
        if (authCredential!.uid.isNotEmpty) {
          Utils().toastMessage('Sign Successful');
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => LoginScreen()));
          setState(() {
            loading=false;
          });
        }
        else{
          setState(() {
            loading=false;
          });
          print("Something went wrong");
        }
      }on FirebaseAuthException catch(e){
        setState(() {
          loading=false;
        });
        Utils().toastMessage(e.toString());
      }catch(e){
        print(e);
      }

   }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign Up'),
        centerTitle: true,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      controller:_emailController,
                      decoration: const  InputDecoration(
                          hintText: 'Email',
                          prefixIcon: Icon(Icons.alternate_email)
                      ),
                      validator: (value){
                        if(value!.isEmpty){
                          return 'Enter email';
                        }
                        return null ;
                      },
                    ),
                    const SizedBox(height: 10,),
                    TextFormField(
                      keyboardType: TextInputType.text,
                      controller: _passwordController,
                      obscureText:_obsecureTxt ,
                      decoration: InputDecoration(
                        hintText: "Enter Your password",
                        suffixIcon: _obsecureTxt==true?IconButton(
                            onPressed: (){
                              _obsecureTxt=false;
                            }, icon: Icon(Icons.remove_red_eye)
                        ):IconButton(onPressed: (){
                              _obsecureTxt=true;
                        }, icon: Icon(Icons.visibility_off)
                        ),
                      ),
                      validator: (value){
                        if(value!.isEmpty){
                          return 'Enter password';
                        }
                        return null ;
                      },
                    ),

                  ],
                )
            ),
            const SizedBox(height: 50,),
            RoundButton(
              title: 'Sign up',
              loading: loading ,
              onTap: (){
                if(_formKey.currentState!.validate()){
                    signUp();
                }
              },
            ),
            const SizedBox(height: 30,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Already have an account?"),
                TextButton(onPressed: (){
                  Navigator.push(context,
                      MaterialPageRoute(
                          builder:(context) => LoginScreen())
                  );
                },
                    child: Text('Login'))
              ],
            )

          ],
        ),
      ),

    );
  }
}
