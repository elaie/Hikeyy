import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
  Future<String?> reqsent(String uid) async {
    final friend = await FirebaseFirestore.instance
        .collection('Users')
        .doc(auth.currentUser!.uid)
        .collection('Friends')
        .doc(uid)
        .get();
    if (friend.exists) {
      return 'Friends';
    } else {
      final datas = await FirebaseFirestore.instance
          .collection('Users')
          .doc(auth.currentUser!.uid)
          .collection('Requests')
          .doc(uid)
          .get();
      if (datas.exists) {
        return datas.data()?['About'];
      } else {
        return null;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        alignment: Alignment.topCenter,
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/green_background.png'),
              fit: BoxFit.cover),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20, left: 10, right: 10),
              child: TextField(
                decoration: const InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(30))),
                    prefixIcon: Icon(Icons.search),
                    hintText: 'Search'),
                onChanged: (val) {
                  setState(() {
                    name = val;
                  });
                },
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Container(
                  //height: MediaQuery.of(context).size.height*0.82,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30)),
                      color: Colors.grey.shade200.withOpacity(0.7)),
                  child: StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('Users')
                        .snapshots(),
                    builder: (context, snapshots) {
                      if (snapshots.connectionState ==
                          ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      return ListView.builder(
                          itemCount: snapshots.data!.docs.length,
                          itemBuilder: (context, index) {
                            var data = snapshots.data!.docs[index].data()
                                as Map<String, dynamic>;
                            var id = snapshots.data!.docs[index].id;

                            if (data['Email'] == auth.currentUser!.email) {
                              return Container();
                            }
                            if (name == '') {
                              return FutureBuilder<String?>(
                                future: reqsent(id),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return Container();
                                  }
                                  if (snapshot.connectionState ==
                                      ConnectionState.done) {
                                    return ListTile(
                                      title: Text(data['UserName']),
                                      leading: CircleAvatar(
                                        backgroundImage: data['pfpUrl'] != ''
                                            ? NetworkImage(data['pfpUrl'])
                                            : const AssetImage(
                                                    'assets/images/profile.png')
                                                as ImageProvider,
                                      ),
                                      trailing: snapshot.data == null
                                          ? GestureDetector(
                                              child: const Icon(Icons.add),
                                              onTap: () {
                                                FirebaseFirestore.instance
                                                    .collection('Users')
                                                    .doc(snapshots
                                                        .data!.docs[index].id)
                                                    .collection('Requests')
                                                    .doc(auth.currentUser!.uid)
                                                    .set({
                                                  'Sender':
                                                      auth.currentUser!.uid,
                                                  'Status': 'Pending',
                                                  'About': 'Received'
                                                }).then((value) {
                                                  FirebaseFirestore.instance
                                                      .collection('Users')
                                                      .doc(
                                                          auth.currentUser!.uid)
                                                      .collection('Requests')
                                                      .doc(snapshots
                                                          .data!.docs[index].id)
                                                      .set({
                                                    'Receiver': snapshots
                                                        .data!.docs[index].id,
                                                    'Status': 'Pending',
                                                    'About': 'Sent'
                                                  }).then((value) {
                                                    setState(() {});
                                                  });
                                                });
                                              },
                                            )
                                          : snapshot.data == 'Received'
                                              ? const Text('Request Received')
                                              : snapshot.data == 'Friends'
                                                  ? const Text('Friends')
                                                  : const Text("Request Sent"),
                                    );
                                  }
                                  return const Text("Error");
                                },
                              );
                            }

                            if (data['UserName']
                                .toString()
                                .toLowerCase()
                                .startsWith(name.toString().toLowerCase())) {
                              return FutureBuilder<String?>(
                                future: reqsent(id),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return const Center();
                                  }
                                  if (snapshot.connectionState ==
                                      ConnectionState.done) {
                                    return ListTile(
                                      title: Text(data['UserName']),
                                      leading: CircleAvatar(
                                        backgroundImage: data['pfpUrl'] != ''
                                            ? NetworkImage(data['pfpUrl'])
                                            : const AssetImage(
                                                    'assets/images/profile.png')
                                                as ImageProvider,
                                      ),
                                      trailing: snapshot.data == null
                                          ? GestureDetector(
                                              child: const Icon(Icons.add),
                                              onTap: () {
                                                FirebaseFirestore.instance
                                                    .collection('Users')
                                                    .doc(snapshots
                                                        .data!.docs[index].id)
                                                    .collection('Requests')
                                                    .doc(auth.currentUser!.uid)
                                                    .set({
                                                  'Sender':
                                                      auth.currentUser!.uid,
                                                  'Status': 'Pending',
                                                  'About': 'Received'
                                                }).then((value) {
                                                  FirebaseFirestore.instance
                                                      .collection('Users')
                                                      .doc(
                                                          auth.currentUser!.uid)
                                                      .collection('Requests')
                                                      .doc(snapshots
                                                          .data!.docs[index].id)
                                                      .set({
                                                    'Receiver': snapshots
                                                        .data!.docs[index].id,
                                                    'Status': 'Pending',
                                                    'About': 'Sent'
                                                  }).then((value) {
                                                    setState(() {});
                                                  });
                                                });
                                              },
                                            )
                                          : snapshot.data == 'Received'
                                              ? const Text('Request Received')
                                              : const Text("Request Sent"),
                                    );
                                  }
                                  return const Text("Error");
                                },
                              );
                            }
                            return Container();
                          });
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
