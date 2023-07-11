import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FriendsList extends StatefulWidget {
  const FriendsList({super.key});

  @override
  State<FriendsList> createState() => _FriendsListState();
}

class _FriendsListState extends State<FriendsList> {
  @override
  Widget build(BuildContext context) {
    Future<DocumentSnapshot?> getDocumentByUID(String uid) async {
      try {
        final snapshot =
            await FirebaseFirestore.instance.collection('Users').doc(uid).get();

        if (snapshot.exists) {
          // Document exists, return the snapshot
          return snapshot;
        } else {
          // Document does not exist
          return null;
        }
      } catch (e) {
        // Error occurred while fetching the document
        //print('Error: $e');
        return null;
      }
    }

    FirebaseAuth auth = FirebaseAuth.instance;
    return Scaffold(
      body: //friends list
          StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('Users')
                  .doc(auth.currentUser!.uid)
                  .collection('Friends')
                  .snapshots(),
              builder: (context, snapshots) {
                if (snapshots.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: snapshots.data!.docs.length,
                    itemBuilder: (context, index) {
                      var data = snapshots.data!.docs[index].id;
                      return FutureBuilder<DocumentSnapshot?>(
                        future: getDocumentByUID(data),
                        builder: (BuildContext context,
                            AsyncSnapshot<DocumentSnapshot?> snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Container();
                          } else if (snapshot.hasError) {
                            return Text('Error: ${snapshot.error}');
                          } else if (snapshot.hasData) {
                            // Document exists, access the data
                            Map<String, dynamic> data =
                                snapshot.data!.data() as Map<String, dynamic>;
                            String name = data['UserName'];
                            //String email = data['email'];

                            return ListTile(
                              title: Text(name),
                              leading: CircleAvatar(
                                backgroundImage: data['pfpUrl'] != ' '
                                    ? NetworkImage(data['pfpUrl'])
                                    : const AssetImage(
                                            'assets/images/profile.png')
                                        as ImageProvider,
                              ),
                            );
                          }
                          return const Text('NO Friends');
                        },
                      );
                    });
              }),
    );
  }
}
