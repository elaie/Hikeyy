import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hikeyy/screens/group_details/group_details.dart';

import '../../home_page/widget/my_schedule_card.dart';

class GroupList extends StatelessWidget {
  const GroupList({
    super.key,
    required this.auth,
  });

  final FirebaseAuth auth;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('Users')
            .doc(auth.currentUser!.uid)
            .collection('MyGroup')
            .snapshots(),
        builder: (context, snapshots) {
          if (snapshots.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshots.hasError) {
            return Text('Error: ${snapshots.error}');
          } else if (snapshots.hasData) {
            // Document exists, access the data

            return ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: snapshots.data!.docs.length,
                itemBuilder: (context, index) {
                  var dataG = snapshots.data!.docs[index].data()
                      as Map<String, dynamic>;
                  var id = snapshots.data!.docs[index].id;
                  // return Text(dataG['GroupName']);
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => GroupDetails(id: id)));
                    },
                    child: MyScheduleCard(
                      groupName: dataG['GroupName'],
                      destination: 'Nepal',
                      date: dataG['Time'],
                    ),
                  );
                });
          }
          return const Text('No Group');
        });
  }
}
