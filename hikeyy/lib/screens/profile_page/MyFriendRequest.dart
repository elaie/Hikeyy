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
    if (uid==null)
      {
        return null;
      }
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
      print('Error: $e');
      return null;
    }
  }

  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('Users')
                .doc(auth.currentUser!.uid)
                .collection('Requests').where('About', isEqualTo: 'Received')
                .snapshots(),
            builder: (context, snapshots) {
              if (snapshots.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (snapshots.hasData) {
                return Scaffold(
                  body: SafeArea(
                    child: Column(
                      children: [
                        const Text(
                          'Friend Requests',
                          style: TextStyle(fontSize: 20),
                        ),
                        const Divider(
                          height: 20,
                          color: Colors.black,
                        ),
                        ListView.builder(
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemCount: snapshots.data!.docs.length,
                            itemBuilder: (context, index) {
                              var data = snapshots.data!.docs[index].data()
                              as Map<String, dynamic>;
                              //print(data['Sender']);
                              //print('******************');
                              return data['Sender']==null?const Text('No Requests'):FutureBuilder<DocumentSnapshot?>(
                                future: getDocumentByUID(data['Sender']),
                                builder: (BuildContext context,
                                    AsyncSnapshot<DocumentSnapshot?> snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return Container();
                                  } else if (snapshot.hasError) {
                                    return Text('Error: ${snapshot.error}');
                                  } else {
                                    // Document exists, access the data
                                    Map<String, dynamic> data = snapshot.data!
                                        .data() as Map<String, dynamic>;
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
                                      trailing: SizedBox(
                                        width: 100,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            GestureDetector(
                                              child: const Icon(Icons.add),
                                              onTap: () {
                                                FirebaseFirestore.instance
                                                    .collection('Users')
                                                    .doc(auth.currentUser!.uid)
                                                    .collection('Friends')
                                                    .doc(snapshot.data!.id)
                                                    .set({
                                                  'time':
                                                      DateTime.now().toString()
                                                }).then((value) {
                                                  FirebaseFirestore.instance
                                                      .collection('Users')
                                                      .doc(snapshot.data!.id)
                                                      .collection('Friends')
                                                      .doc(
                                                          auth.currentUser!.uid)
                                                      .set({
                                                    'time': DateTime.now()
                                                        .toString()
                                                  });
                                                }).then((value) {
                                                  FirebaseFirestore.instance
                                                      .collection('Users')
                                                      .doc(
                                                          auth.currentUser!.uid)
                                                      .collection('Requests')
                                                      .doc(snapshot.data!.id)
                                                      .delete();
                                                }).then((value) {
                                                  FirebaseFirestore.instance
                                                      .collection('Users')
                                                      .doc(snapshot.data!.id)
                                                      .collection('Requests')
                                                      .doc(
                                                          auth.currentUser!.uid)
                                                      .delete();
                                                }).then((value) {
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(const SnackBar(
                                                          content: Text(
                                                              'Request Accepted')));
                                                });
                                              },
                                            ),
                                            GestureDetector(
                                              child: const Icon(Icons.not_interested),
                                              onTap: () {
                                                FirebaseFirestore.instance
                                                    .collection('Users')
                                                    .doc(auth.currentUser!.uid)
                                                    .collection('Requests')
                                                    .doc(snapshot.data!.id)
                                                    .delete()
                                                    .then((value) {
                                                  FirebaseFirestore.instance
                                                      .collection('Users')
                                                      .doc(snapshot.data!.id)
                                                      .collection('Requests')
                                                      .doc(
                                                          auth.currentUser!.uid)
                                                      .delete();
                                                }).then((value) {
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(const SnackBar(
                                                          content: Text(
                                                              'Request Rejected')));
                                                });
                                              },
                                            )
                                          ],
                                        ),
                                      ),
                                    );
                                  }
                                },
                              );
                            }),
                      ],
                    ),
                  ),
                );
              }
              return const Text("NO DATA");
            }));
  }
}
