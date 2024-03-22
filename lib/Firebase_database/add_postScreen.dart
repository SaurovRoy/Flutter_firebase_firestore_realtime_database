import 'dart:io';
import 'dart:math';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../Utils/util.dart';
import '../Widgets/round_button.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class AddPostScreen extends StatefulWidget {
  const AddPostScreen({Key? key}) : super(key: key);

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {

  TextEditingController postController =TextEditingController();
  bool loading = false ;
  final databaseRef = FirebaseDatabase.instance.ref('Saurav');
  File? _image;//It can be null so we set question mark
  final picker=ImagePicker();
  firebase_storage.FirebaseStorage storage=firebase_storage.FirebaseStorage.instance;
  Future getImage()async{
    final pickedFile=await picker.pickImage(source: ImageSource.gallery,imageQuality: 80);
    if(pickedFile!=null){
        setState(() {
          _image=File(pickedFile.path);
        });
    }else{
       print('No image picked');
    }
  }

  Future uploadImage()async {
    setState(() {
      loading=true;
    });
    firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance
        .ref('/AddFile' + '123');
    firebase_storage.UploadTask uploadTask = ref.putFile(_image!.absolute);
    var newUrl = await ref.getDownloadURL();
    String id = DateTime
        .now()
        .millisecond
        .toString();
    Future.value(uploadTask).then((value) {
      setState(() {
        loading = true;
      });
      databaseRef.child(id.toString()).set({
        'title': postController.text.toString(),
        'id': id.toString(),
        'img-path': newUrl.toString()
      }).then((value) {
        Utils().toastMessage('Post added');
        setState(() {
          loading = false;
        });
      }).onError((error, stackTrace) {
        Utils().toastMessage(error.toString());
        setState(() {
          loading = false;
        });
      });
    });
  }

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
            InkWell(
              onTap: (){
                getImage();
              },
              child: Container(
                height: 125,
                width: 130,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black
                  ),
                ),
                child:_image!=null?Image.file(_image!.absolute) : Center(
                  child: Icon(Icons.image),
                ),
              ),
            ),
            SizedBox(height: 10,),
            TextFormField(
              maxLines: 2,
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

                uploadImage();

                  }),

          ],
        ),
      ),
    );
  }
}
