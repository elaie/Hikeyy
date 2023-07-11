import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hikeyy/screens/login_signup/login.dart';
import 'package:hikeyy/screens/login_signup/verify_mail.dart';

class IsLogged extends StatelessWidget {
  const IsLogged({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: SafeArea(
        child: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context,snapshot){
            if(snapshot.hasData){
              return const VerifyMailPage();
            }
            else{
              return const LoginPage();
            }
          },
        ),
      ),
    );
  }
}
