import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../Utils/util.dart';
import '../Widgets/round_button.dart';
class AddPScreen extends StatefulWidget {
  const AddPScreen({super.key});

  @override
  State<AddPScreen> createState() => _AddPScreenState();
}

class _AddPScreenState extends State<AddPScreen> {
  bool loading=false;
  TextEditingController postController=TextEditingController();
  final databaseRef=FirebaseFirestore.instance.collection('users');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Post'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            SizedBox(
              height: 30,
            ),

            TextFormField(
              maxLines: 4,
              controller: postController,
              decoration: InputDecoration(
                  hintText: 'What is in your mind?' ,
                  border: OutlineInputBorder()
              ),
            ),
            SizedBox(
              height: 30,
            ),
            RoundButton(
                title: 'Add',
                loading: loading,
                onTap: (){
                  setState(() {
                    loading = true ;
                  });


                  String id  = DateTime.now().millisecond.toString() ;

                  databaseRef.doc(id.toString()).set({
                    'title' : postController.text,
                    'id' : id.toString()
                  }).then((value){
                    Utils().toastMessage('Post added');
                    setState(() {
                      loading = false ;
                    });
                  }).onError((error, stackTrace){
                    Utils().toastMessage(error.toString());
                    setState(() {
                      loading = false ;
                    });
                  });
                })
          ],
        ),
      ),
    );
  }
}
