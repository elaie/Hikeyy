import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hikeyy/screens/login_signup/login.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ElevatedButton(
        onPressed: (){
          FirebaseAuth.instance.signOut().then((value) {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => LoginPage()));
          });
        },
        child: Text('LogOut'),
      ),
    );
  }
}
