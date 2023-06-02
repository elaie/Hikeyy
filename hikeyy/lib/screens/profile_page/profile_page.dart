import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../login_signup/login.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ElevatedButton(
        onPressed: () {
          FirebaseAuth.instance.signOut().then((value) {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => LoginPage()));
          });
        },
        child: Text('LogOut'),
      ),
    );
  }
}
