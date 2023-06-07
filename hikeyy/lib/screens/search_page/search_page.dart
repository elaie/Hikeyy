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
  Future<String?> reqsent(String uid) async {
    final friend = await FirebaseFirestore.instance
        .collection('Users')
        .doc(auth.currentUser!.uid)
        .collection('Friends')
        .doc(uid)
        .get();
    if(friend.exists){
      return 'Friends';
    }
    else {
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
                  return FutureBuilder<String?>(
                    future: reqsent(id),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Container();
                      }
                       if (snapshot.connectionState== ConnectionState.done) {
                      //   final datas = FirebaseFirestore.instance
                      //       .collection('Users')
                      //       .doc(auth.currentUser!.uid)
                      //       .collection('Requests')
                      //       .doc(uid)
                      //       .get();
                      //  String about=FirebaseFirestore.instance.collection('Users').doc(auth.currentUser!.uid).collection('Requests').doc(snapshots.data!.docs[index].id).snapshots().toString();
                       // print(about);
                        //print("1111111111111111111111111");
                        return ListTile(
                          title: Text(data['UserName']),
                          leading: CircleAvatar(
                            backgroundImage: data['pfpUrl'] != ' '
                                ? NetworkImage(data['pfpUrl'])
                                : AssetImage('assets/images/profile.png')
                            as ImageProvider,
                          ),
                          trailing: snapshot.data==null
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
                                'Status': 'Pending',
                                'About' : 'Received'
                              }).then((value) {
                                FirebaseFirestore.instance
                                    .collection('Users')
                                    .doc(auth.currentUser!.uid)
                                    .collection('Requests')
                                    .doc(snapshots.data!.docs[index].id)
                                    .set({
                                  'Receiver':
                                  snapshots.data!.docs[index].id,
                                  'Status': 'Pending',
                                  'About':'Sent'
                                }).then((value) {
                                  setState(() {});
                                });
                              });
                            },
                          )
                              :snapshot.data=='Received'?Text('Request Received'):snapshot.data=='Friends'?Text('Friends'):Text("Request Sent"),
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
                  return FutureBuilder<String?>(
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
                          trailing: snapshot.data==null
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
                                'Status': 'Pending',
                                'About' :'Received'
                              }).then((value) {
                                FirebaseFirestore.instance
                                    .collection('Users')
                                    .doc(auth.currentUser!.uid)
                                    .collection('Requests')
                                    .doc(snapshots.data!.docs[index].id)
                                    .set({
                                  'Receiver':
                                  snapshots.data!.docs[index].id,
                                  'Status': 'Pending',
                                  'About' :'Sent'
                                }).then((value) {
                                  setState(() {});
                                });
                              });
                            },
                          )
                              : snapshot.data=='Received'?Text('Request Received'):Text("Request Sent"),
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
