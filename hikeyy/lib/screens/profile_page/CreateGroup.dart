import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hikeyy/screens/dashboard/dashboard.dart';

import '../home_page/home_page.dart';

class CreateGroup extends StatefulWidget {
  const CreateGroup({super.key});

  @override
  State<CreateGroup> createState() => _CreateGroupState();
}

class _CreateGroupState extends State<CreateGroup> {
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
      print('Error: $e');
      return null;
    }
  }

  final _gName = GlobalKey<FormState>();
  FirebaseAuth auth = FirebaseAuth.instance;
  String _name = '';
  List _Selected = [];
  final TextEditingController _gNameController = TextEditingController();

  bool checklist(var data) {
    if (_Selected.contains(data)) {
      return true;
    } else {
      return false;
    }
  }

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

  createGroup(var gname, List selected) {
    const _chars =
        'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    String doc_id = String.fromCharCodes(Iterable.generate(
        7, (_) => _chars.codeUnitAt(Random().nextInt(_chars.length))));
    FirebaseFirestore.instance
        .collection('Groups')
        .doc(doc_id)
        .set({'Name': gname, 'Members': selected}).then((value) {
      selected.forEach((element) {
        FirebaseFirestore.instance
            .collection('Users')
            .doc(element)
            .collection('MyGroup')
            .doc(doc_id)
            .set({'GroupName': gname, 'GroupID': doc_id}).then((value) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Dashboard(page: HomePage())),
          );
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Create Group')),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Column(
            children: [
              SizedBox(
                height: 50,
                child: Form(
                  key: _gName,
                  child: TextFormField(
                    controller: _gNameController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'This field cant be empty';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      hintText: 'Group Name',
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: Color.fromARGB(255, 209, 207, 207)),
                      ),
                    ),
                  ),
                ),
              ),
              Text('Selected Friends:'),
              Divider(
                height: 30,
              ),
              _Selected.isNotEmpty
                  ? Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8.0, vertical: 5),
                      child: SizedBox(
                        height: 50,
                        child: ListView.builder(
                          itemCount: _Selected.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 5),
                              child: FutureBuilder<DocumentSnapshot?>(
                                  future: getDocumentByUID(_Selected[index]),
                                  builder: (BuildContext context,
                                      AsyncSnapshot<DocumentSnapshot?>
                                          snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return CircularProgressIndicator();
                                    } else if (snapshot.hasError) {
                                      return Text('Error: ${snapshot.error}');
                                    } else if (snapshot.hasData) {
                                      Map<String, dynamic> data2 =
                                          snapshot.data!.data()
                                              as Map<String, dynamic>;
                                      return Container(
                                        width: 150,
                                        decoration: BoxDecoration(
                                            color: Colors.lightBlueAccent,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(30))),
                                        child: Center(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              CircleAvatar(
                                                backgroundImage: data2[
                                                            'pfpUrl'] !=
                                                        ' '
                                                    ? NetworkImage(
                                                        data2['pfpUrl'])
                                                    : const AssetImage(
                                                            'assets/images/profile.png')
                                                        as ImageProvider,
                                              ),
                                              Text(data2['UserName']),
                                              IconButton(
                                                  onPressed: () {
                                                    setState(() {
                                                      _Selected.removeAt(index);
                                                    });
                                                  },
                                                  icon: Icon(Icons.remove))
                                            ],
                                          ),
                                        ),
                                      );
                                    }
                                    return Container();
                                  }),
                            );
                          },
                        ),
                      ),
                    )
                  : Center(
                      child: Text('No Friends Added'),
                    ),
              TextField(
                decoration: const InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                      borderSide:
                          BorderSide(color: Color.fromARGB(255, 209, 207, 207)),
                    ),
                    prefixIcon: Icon(Icons.search),
                    hintText: 'Search your friends to add in this group'),
                onChanged: (val) {
                  setState(() {
                    _name = val;
                  });
                },
              ),
              StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('Users')
                    .doc(auth.currentUser!.uid)
                    .collection('Friends')
                    .snapshots(),
                builder: (context, snapshots) {
                  if (snapshots.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return SizedBox(
                    height: 200,
                    child: ListView.builder(
                        itemCount: snapshots.data!.docs.length,
                        itemBuilder: (context, index) {
                          var data = snapshots.data!.docs[index].data()
                              as Map<String, dynamic>;
                          var id = snapshots.data!.docs[index].id;
                          if (_name == '') {
                            return Container();
                          } else {
                            return FutureBuilder<DocumentSnapshot?>(
                              future: getDocumentByUID(id),
                              builder: (BuildContext context,
                                  AsyncSnapshot<DocumentSnapshot?> snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return Container();
                                } else if (snapshot.hasError) {
                                  return Text('Error: ${snapshot.error}');
                                } else if (snapshot.hasData) {
                                  // Document exists, access the data
                                  Map<String, dynamic> data = snapshot.data!
                                      .data() as Map<String, dynamic>;
                                  String name = data['UserName'];
                                  //String email = data['email'];
                                  if (data['UserName']
                                      .toString()
                                      .toLowerCase()
                                      .startsWith(
                                          _name.toString().toLowerCase())) {
                                    return ListTile(
                                        title: Text(name),
                                        leading: CircleAvatar(
                                          backgroundImage: data['pfpUrl'] != ' '
                                              ? NetworkImage(data['pfpUrl'])
                                              : const AssetImage(
                                                      'assets/images/profile.png')
                                                  as ImageProvider,
                                        ),
                                        trailing: Checkbox(
                                          value: checklist(id),
                                          onChanged: (bool? value) {
                                            value == true
                                                ? setState(() {
                                                    _Selected.add(id);
                                                  })
                                                : setState(() {
                                                    _Selected.remove(id);
                                                  });
                                            //print(_Selected);
                                            //print("***********************");
                                          },
                                        ));
                                  }
                                }
                                return Container();
                              },
                            );
                          }
                          return Container();
                        }),
                  );
                },
              ),
              Padding(
                padding: const EdgeInsets.only(top: 45.0),
                child: Center(
                  child: SizedBox(
                    width: 400,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        if (_gName.currentState!.validate()) {
                          _gName.currentState!.save();
                          _Selected.add(auth.currentUser!.uid);
                          createGroup(_gNameController.text.trim(), _Selected);
                        }
                      },
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.black),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                      ),
                      child: Text(
                        'Create',
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
