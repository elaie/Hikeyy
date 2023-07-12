import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../login_signup/login.dart';

class LogoutButton extends StatelessWidget {
  const LogoutButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 45,
      width: 220,
      child: ElevatedButton(
        onPressed: () {
          FirebaseFirestore.instance.collection('Users').doc(FirebaseAuth.instance.currentUser!.uid).update({
            'TokenId' : ''
          }).then((value){
            FirebaseAuth.instance.signOut().then((value) {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const LoginPage()));
            });
          });

        },
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(
            (Colors.green),
          ),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25.0),
            ),
          ),
        ),
        child: const Text('LogOut'),
      ),
    );
  }
}
