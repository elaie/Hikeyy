import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../home_page/widget/my_schedule_card.dart';

class GroupList extends StatelessWidget {
  const GroupList({
    super.key,
    required this.auth,
  });

  final FirebaseAuth auth;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 310,
      child: Scrollbar(
        radius: Radius.circular(20),
        thumbVisibility: true,
        child: StreamBuilder<QuerySnapshot>(
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

                return Container(
                  height: 200,
                  width: 350,
                  child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: snapshots.data!.docs.length,
                      itemBuilder: (context, index) {
                        var dataG = snapshots.data!.docs[index].data()
                            as Map<String, dynamic>;
                        // return Text(dataG['GroupName']);
                        return MyScheduleCard(
                          groupName: dataG['GroupName'],
                          destination: 'Nepal',
                          date: 'July',
                        );
                      }),
                );
              }
              return const Text('No Group');
            }),
      ),
    );
  }
}
