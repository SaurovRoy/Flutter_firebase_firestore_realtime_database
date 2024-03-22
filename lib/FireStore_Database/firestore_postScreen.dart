import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_all_example/FireStore_Database/add_pScreen.dart';
import 'package:firebase_all_example/Utils/util.dart';
import 'package:flutter/material.dart';
class FireStorePost extends StatefulWidget {
  const FireStorePost({super.key});

  @override
  State<FireStorePost> createState() => _FireStorePostState();
}

class _FireStorePostState extends State<FireStorePost> {
  var _fireStore=FirebaseFirestore.instance;
  TextEditingController editController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('FireStore'),
      ),
      body: Column(
        children: [
          Expanded(
              child:StreamBuilder(
                stream:_fireStore.collection('users').snapshots() ,
                builder: (context,snapshot){
                  if(snapshot.connectionState==ConnectionState.waiting){
                    return const Center(
                      child: const CircleAvatar(),
                    );
                  }
                  return ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context,index){
                      return ListTile(
                        title:Text(snapshot.data!.docs[index]['title'].toString()),
                        subtitle: Text(snapshot.data!.docs[index]['id'].toString()),

                        trailing: PopupMenuButton(
                          icon: Icon(Icons.more_vert),
                          itemBuilder: (context)=>

                            [
                              PopupMenuItem(
                                value: 1,
                                  child:ListTile(
                                    onTap: (){
                                      showDialog(context: context, builder: (context){
                                        return AlertDialog(
                                          content: TextField(
                                            keyboardType: TextInputType.text,
                                            controller:editController ,
                                            decoration: InputDecoration(
                                                hintText: 'Type Here'
                                            ),
                                          ),
                                          actions: [
                                            TextButton(onPressed: (){
                                              Navigator.pop(context);
                                            }, child: const Text('Cancel'),
                                            ),
                                            TextButton(onPressed: (){
                                              _fireStore.collection('users').doc(snapshot.data!.docs[index]['id']).update(
                                                  {
                                                    'title':editController.text
                                                  }
                                              ).then((value) {
                                                Utils().toastMessage('Edit Successful');
                                              });
                                            }, child: const Text('Save'),
                                            ),
                                          ],
                                        );
                                      });



                                    },
                                    leading: const Icon(Icons.edit),
                                    title: const Text('Edit'),
                                  )
                              ),
                              PopupMenuItem(
                                value: 2,
                                  child:ListTile(
                                    onTap: (){
                                      Navigator.pop(context);
                                      editController.dispose();
                                      _fireStore.collection('users').doc(snapshot.data!.docs[index]['id']).delete().then((value){
                                        Utils().toastMessage('Delete Successful');
                                      });

                                    },
                                    leading:const Icon(Icons.delete),
                                    title: const Text('Delete'),
                                  ))
                            ]

                        ),
                      );
                      });
                },
              )
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context)=>AddPScreen()));
        },
        child:  const Icon(Icons.add),
        ),


    );
  }
}
