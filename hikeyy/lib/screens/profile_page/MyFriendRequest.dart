

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MyFriendRequest extends StatefulWidget {
  const MyFriendRequest({Key? key}) : super(key: key);

  @override
  State<MyFriendRequest> createState() => _MyFriendRequestState();
}

class _MyFriendRequestState extends State<MyFriendRequest> {
  Future<DocumentSnapshot?> getDocumentByUID(String uid) async {
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('Users')
          .doc(uid)
          .get();

      if (snapshot.exists) {
        // Document exists, return the snapshot
        return snapshot;
      } else {
        // Document does not exist
        return null;
      }
    } catch (e) {
      // Error occurred while fetching the document
      print('Error: $e');
      return null;
    }
  }
  FirebaseAuth auth =FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance.collection('Users').doc(auth.currentUser!.uid).collection('Requests').snapshots(),
            builder: (context, snapshots) {
              if (snapshots.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              if(snapshots.hasData){
              return ListView.builder(
                  itemCount: snapshots.data!.docs.length,
                  itemBuilder: (context, index) {
                    var data = snapshots.data!.docs[index].data()
                        as Map<String, dynamic>;
                    return FutureBuilder<DocumentSnapshot?>(
                      future: getDocumentByUID(data['Sender']),
                      builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot?> snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return CircularProgressIndicator();
                        } else if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}');
                        }  else {
                          // Document exists, access the data
                          Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
                          String name = data['UserName'];
                          //String email = data['email'];

                           return ListTile(
                            title: Text(name),
                            leading: CircleAvatar(
                              backgroundImage: data['pfpUrl'] != ' '
                                  ? NetworkImage(data['pfpUrl'])
                                  : AssetImage('assets/images/profile.png')
                              as ImageProvider,
                            ),
                          );
                        }
                      },
                    );

                  });}
              return Text("NODATA");
            }));
  }
}
