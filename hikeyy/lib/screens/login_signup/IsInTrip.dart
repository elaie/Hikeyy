import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hikeyy/screens/dashboard/dashboard.dart';
import 'package:hikeyy/screens/home_page/home_page.dart';
import 'package:hikeyy/screens/start_trail/start_trail.dart';

class IsBusy extends StatefulWidget {
  const IsBusy({Key? key}) : super(key: key);

  @override
  State<IsBusy> createState() => _IsBusyState();
}

class _IsBusyState extends State<IsBusy> {
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
            future: FirebaseFirestore.instance
                .collection('Users')
                .doc(auth.currentUser!.uid)
                .get(),
            builder: (_, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              var data = snapshot.data!.data();
              var Status = data!['Status'];
              var groupid = data['Trail'];
              //var bio = data['Bio'];
              if (Status == 'Busy'){
                return Dashboard(page: StartTrail(id: groupid));
              }
              else {
                return Dashboard(page: HomePage());
              }
            }

            ),
      ),
    );
  }
}
