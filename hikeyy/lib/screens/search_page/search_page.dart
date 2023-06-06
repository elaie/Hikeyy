import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  FirebaseAuth auth = FirebaseAuth.instance;
  String name = '';

  //
  Future<bool> reqsent(String uid) async {
    final datas = await FirebaseFirestore.instance
        .collection('Users')
        .doc(auth.currentUser!.uid)
        .collection('RequestSent')
        .doc(uid)
        .get();
    if (datas.exists) {
      return false;
    } else {
      return true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Card(
          child: TextField(
            decoration: InputDecoration(
                prefixIcon: Icon(Icons.search), hintText: 'Search'),
            onChanged: (val) {
              setState(() {
                name = val;
              });
            },
          ),
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('Users').snapshots(),
        builder: (context, snapshots) {
          if (snapshots.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView.builder(
              itemCount: snapshots.data!.docs.length,
              itemBuilder: (context, index) {
                var data =
                snapshots.data!.docs[index].data() as Map<String, dynamic>;
                var id = snapshots.data!.docs[index].id;

                if (data['Email'] == auth.currentUser!.email) {
                  return Container();
                }
                if (name == '') {
                  return FutureBuilder<bool>(
                    future: reqsent(id),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: const CircularProgressIndicator());
                      }
                      if (snapshot.hasData) {
                        return ListTile(
                          title: Text(data['UserName']),
                          leading: CircleAvatar(
                            backgroundImage: data['pfpUrl'] != ' '
                                ? NetworkImage(data['pfpUrl'])
                                : AssetImage('assets/images/profile.png')
                            as ImageProvider,
                          ),
                          trailing: snapshot.data!
                              ? GestureDetector(
                            child: Icon(Icons.add),
                            onTap: () {
                              FirebaseFirestore.instance
                                  .collection('Users')
                                  .doc(snapshots.data!.docs[index].id)
                                  .collection('Requests')
                                  .doc(auth.currentUser!.uid)
                                  .set({
                                'Sender': auth.currentUser!.uid,
                                'Status': 'Pending'
                              }).then((value) {
                                FirebaseFirestore.instance
                                    .collection('Users')
                                    .doc(auth.currentUser!.uid)
                                    .collection('RequestSent')
                                    .doc(snapshots.data!.docs[index].id)
                                    .set({
                                  'Receiver':
                                  snapshots.data!.docs[index].id,
                                  'Status': 'Pending'
                                }).then((value) {
                                  setState(() {});
                                });
                              });
                            },
                          )
                              : Text("Request Sent"),
                        );
                      }
                      return Text("Error");
                    },
                  );
                }

                if (data['UserName']
                    .toString()
                    .toLowerCase()
                    .startsWith(name.toString().toLowerCase())) {
                  return FutureBuilder<bool>(
                    future: reqsent(id),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: const CircularProgressIndicator());
                      }
                      if (snapshot.hasData) {
                        return ListTile(
                          title: Text(data['UserName']),
                          leading: CircleAvatar(
                            backgroundImage: data['pfpUrl'] != ' '
                                ? NetworkImage(data['pfpUrl'])
                                : AssetImage('assets/images/profile.png')
                            as ImageProvider,
                          ),
                          trailing: snapshot.data!
                              ? GestureDetector(
                            child: Icon(Icons.add),
                            onTap: () {
                              FirebaseFirestore.instance
                                  .collection('Users')
                                  .doc(snapshots.data!.docs[index].id)
                                  .collection('Requests')
                                  .doc(auth.currentUser!.uid)
                                  .set({
                                'Sender': auth.currentUser!.uid,
                                'Status': 'Pending'
                              }).then((value) {
                                FirebaseFirestore.instance
                                    .collection('Users')
                                    .doc(auth.currentUser!.uid)
                                    .collection('RequestSent')
                                    .doc(snapshots.data!.docs[index].id)
                                    .set({
                                  'Receiver':
                                  snapshots.data!.docs[index].id,
                                  'Status': 'Pending'
                                }).then((value) {
                                  setState(() {});
                                });
                              });
                            },
                          )
                              : Text("Request Sent"),
                        );
                      }
                      return Text("Error");
                    },
                  );
                }
                return Container();
              });
        },
      ),
    );
  }
}
