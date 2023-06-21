import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hikeyy/screens/home_page/widget/my_schedule_card.dart';

class GroupListPage extends StatefulWidget {
  const GroupListPage({super.key});

  @override
  State<GroupListPage> createState() => _GroupListPageState();
}

class _GroupListPageState extends State<GroupListPage> {
  FirebaseAuth auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          StreamBuilder<QuerySnapshot>(
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

                  return SizedBox(
                    height: 200,
                    width: double.infinity,
                    child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
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
        ],
      ),
    );
  }
}
