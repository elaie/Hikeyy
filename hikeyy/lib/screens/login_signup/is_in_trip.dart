import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hikeyy/screens/dashboard/dashboard.dart';
import 'package:hikeyy/screens/home_page/home_page.dart';
import 'package:hikeyy/screens/start_trail/start_trail.dart';

class IsBusy extends StatefulWidget {
  final int? index;
  const IsBusy({Key? key, this.index}) : super(key: key);

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
              var status = data!['Status'];
              var groupid = data['Trail'];
              //var bio = data['Bio'];
              if (status == 'Busy'){
                return widget.index!=null?Dashboard(page: StartTrail(id: groupid),index: widget.index):Dashboard(page: StartTrail(id: groupid));
              }
              else {
                return widget.index!=null?Dashboard(page: HomePage(),index: widget.index):Dashboard(page: HomePage());
              }
            }

            ),
      ),
    );
  }
}
