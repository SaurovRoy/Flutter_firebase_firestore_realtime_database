import 'package:firebase_all_example/FireStore_Database/firestore_postScreen.dart';
import 'package:firebase_all_example/Ui/Auth/login_screens.dart';
import 'package:firebase_all_example/Utils/util.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';

import 'add_postScreen.dart';
class PostScreen extends StatefulWidget {
  const PostScreen({super.key});

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  void signOut(){
    final auth=FirebaseAuth.instance;
    auth.signOut().then((value) {
      Utils().toastMessage("Log Out Successful");
      Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
    }).onError((error, stackTrace) {
      Utils().toastMessage(error.toString());
    });
  }
  @override
  void dispose() {
    // TODO: implement dispose
    updateController.dispose();
    super.dispose();

  }
  TextEditingController updateController=TextEditingController();
  final ref=FirebaseDatabase.instance.ref('Saurav');
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: const Text('Realtime Database post'),
        actions: [
          IconButton(onPressed: (){
            signOut();
          }, icon: const Icon(Icons.logout_outlined)),
            IconButton(onPressed: (){
              Navigator.push(context,MaterialPageRoute(builder: (context)=>FireStorePost()));

          }, icon: const Icon(Icons.navigate_next)),

        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: FirebaseAnimatedList(
                query: ref,
                defaultChild: const Text('Loading'),
                itemBuilder: (context, snapshot, animation, index){
                  return   ListTile(
                    title: Text(snapshot.child('title').value.toString()),
                    subtitle: Text(snapshot.child('id').value.toString()),
                    leading: snapshot.child('img-path').value.toString()==null?
                    Text('Loading'): Image.network(snapshot.child('img-path').value.toString()),
                    trailing:  PopupMenuButton(
                        color: Colors.white,
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(2))),
                        icon: const Icon(Icons.more_vert,),
                        itemBuilder: (context) => [
                          PopupMenuItem(
                            value: 2,
                            child:  ListTile(
                              onTap: (){
                                // Navigator.pop(context);
                                showDialog(context: context, builder: (context){
                                  return AlertDialog(
                                    title: const Text('Edit your content'),
                                    actions: [
                                      TextButton(onPressed: (){
                                        Navigator.pop(context);
                                      },
                                          child:const Text('Cancel')
                                      ),
                                      TextButton(onPressed: (){
                                        Navigator.pop(context);
                                        ref.child(snapshot.child('id').value.toString()).update({
                                          'title':updateController.text.toString(),
                                          'id':snapshot.child('id').value.toString()
                                        }).then((value) => Navigator.pop(context)).onError((error, stackTrace){
                                          Utils().toastMessage(error.toString());
                                        });
                                        Utils().toastMessage('Edited Successful');
                                      },
                                          child: const Text('Save')
                                      ),
                                    ],
                                    content: TextField(
                                      keyboardType: TextInputType.text,
                                      controller: updateController,
                                      decoration: InputDecoration(
                                        hintText: "Type Here",
                                      ),
                                    ),
                                  );
                                }
                                );
                              },
                              leading: Icon(Icons.edit),
                              title: Text('Edit'),
                            ),
                          ),
                          PopupMenuItem(
                            value: 2,
                            child:  ListTile(
                              onTap: (){
                                Navigator.pop(context);


                                ref.child(snapshot.child('id').value.toString()).remove().then((value){

                                }).onError((error, stackTrace){
                                  Utils().toastMessage(error.toString());
                                });
                              },
                              leading: Icon(Icons.delete_outline),
                              title: Text('Delete'),
                            ),
                          ),
                        ]),
                  );
                }
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => AddPostScreen()));
        } ,
        child: Icon(Icons.add),
      ),
    );
  }
}
