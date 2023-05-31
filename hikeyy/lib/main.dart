import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hikeyy/screens/login_signup/login.dart';
import 'package:hikeyy/screens/login_signup/signup.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp().then((value){
    print('********************');
  });
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(primarySwatch: Colors.blue, fontFamily: "Poppins"),
      home: const LoginPage(),
    );
  }
}
