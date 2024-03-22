import 'package:firebase_all_example/Ui/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(
        // apiKey: 'AIzaSyDyVkynhj8Rqexp4vnOoW5WXmM5msZA76s',
        // appId: 'AIzaSyDyVkynhj8Rqexp4vnOoW5WXmM5msZA76s',
        // messagingSenderId: '329293963126' ,
        // projectId: 'fir-all-example'

          apiKey: "AIzaSyCFfTBncvqL-WW_MrsaOKCNDx3D9hLzARI",
          authDomain: "fir-all-example.firebaseapp.com",
          databaseURL: "https://fir-all-example-default-rtdb.firebaseio.com",
          projectId: "fir-all-example",
          storageBucket: "fir-all-example.appspot.com",
          messagingSenderId: "329293963126",
          appId: "1:329293963126:web:aee14a71e371a8d7b5a457",
          measurementId: "G-D8VDHRPK0P"


    )
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
    );
  }
}

