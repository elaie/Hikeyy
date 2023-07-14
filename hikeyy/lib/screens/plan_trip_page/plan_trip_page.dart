import 'dart:convert';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hikeyy/widgets/app_texts.dart';

import '../../widgets/app_colors.dart';
import '../dashboard/dashboard.dart';
import 'package:http/http.dart' as http;

import '../home_page/home_page.dart';

class PlanTripPage extends StatefulWidget {
  final String id;

  const PlanTripPage({super.key, required this.id});

  @override
  State<PlanTripPage> createState() => _PlanTripPageState();
}

class _PlanTripPageState extends State<PlanTripPage> {
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

  final _gName = GlobalKey<FormState>();
  FirebaseAuth auth = FirebaseAuth.instance;
  String _name = '';
  final List _selected = [];
  final TextEditingController _gNameController = TextEditingController();

  bool checklist(var data) {
    if (_selected.contains(data)) {
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
    const chars =
        'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    String docId = String.fromCharCodes(Iterable.generate(
        7, (_) => chars.codeUnitAt(Random().nextInt(chars.length))));
    FirebaseFirestore.instance.collection('Groups').doc(docId).set({
      'Name': gname,
      'Members': selected,
      'Trail': widget.id,
      'Time': selectedDate
    }).then((value) async {
      for (var element in selected) {
        DocumentSnapshot data = await FirebaseFirestore.instance
            .collection('Users')
            .doc(element)
            .get();
        FirebaseFirestore.instance
            .collection('Users')
            .doc(element)
            .collection('MyGroup')
            .doc(docId)
            .set({
          'GroupName': gname,
          'GroupID': docId,
          'Trail': widget.id,
          'Time': selectedDate
        }).then((value) {
          try {
            http.post(Uri.parse('https://fcm.googleapis.com/fcm/send'),
                headers: <String, String>{
                  'Content-Type': 'application/json',
                  'Authorization':
                      'key=AAAAmBUmFv8:APA91bHyUqeVPNp2YUQx4J3S4nJMupqms0CprTzq1RD-aQqJaJcZwb7QhvK-GWuj-qPzc1vKXVvJKFyUT4bFYlRGxLREnbD-amKaWWeVuaxUvMsOdYNK4aEcJnUjIWRJRQm-bbv-3kTA'
                },
                body: jsonEncode(<String, dynamic>{
                  'priority': 'high',
                  'data': <String, dynamic>{
                    'click_action': 'FLUTTER_NOTIFICATION_CLICK',
                    'status': 'done',
                    'body':
                        'Group Created for the hike of $gname at ${selectedDate.year}-${selectedDate.month}-${selectedDate.day}. Best Wishes for the Hike',
                    'title': 'Time for Hike'
                  },
                  "notification": <String, dynamic>{
                    "title": "Time For Hike",
                    "body":
                        "Group Created for the hike of $gname at $selectedDate. Best Wishes for the Hike",
                    "android_channel_id": 'db'
                  },
                  "to": data['TokenId']
                }));
          } catch (e) {
            //print(e);
          }
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const Dashboard(page: HomePage())),
          ).then((value) {});
        });
      }
    });
  }

  DateTime selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null &&
        picked != selectedDate &&
        picked.isAfter(DateTime.now())) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 100.0, left: 15),
          child: SingleChildScrollView(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const AppTextHeading(
                textHeading: 'Lets Plan your Trip!',
                fontSize: 20,
              ),
              const Padding(
                padding: EdgeInsets.only(top: 50.0, bottom: 10),
                child: AppTextHeading(
                  textHeading: 'Destination:',
                  fontSize: 20,
                ),
              ),
              Padding(
                  padding: const EdgeInsets.only(right: 15.0),
                  child: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                      future: FirebaseFirestore.instance
                          .collection('Trails')
                          .doc(widget.id)
                          .get(),
                      builder: (_, snapshot) {
                        if (!snapshot.hasData) {
                          return const Text('....................');
                        } else {
                          return Text(snapshot.data!.data()!['Name']);
                        }
                      })),
              const Padding(
                padding: EdgeInsets.only(top: 30.0, bottom: 10),
                child: AppTextHeading(
                  textHeading: 'Date:',
                  fontSize: 20,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 40.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: Text(
                        "${selectedDate.toLocal()}".split(' ')[0],
                        style: const TextStyle(fontSize: 17),
                      ),
                    ),
                    SizedBox(
                      height: 40,
                      width: 150,
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(AppColor.primaryColor),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                        ),
                        onPressed: () => _selectDate(context),
                        child: const AppText(
                          text: 'Select Date',
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 30.0, bottom: 10),
                child: AppTextHeading(
                  textHeading: 'Create a group:',
                  fontSize: 20,
                ),
              ),
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
                    decoration: const InputDecoration(
                      hintText: 'Group Name',
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: Color.fromARGB(255, 209, 207, 207)),
                      ),
                    ),
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 10.0, bottom: 10, left: 15),
                child: AppTextHeading(
                  textHeading: 'Select Friends:',
                  fontSize: 17,
                ),
              ),
              _selected.isNotEmpty
                  ? Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8.0, vertical: 5),
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: _selected.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 5),
                            child: FutureBuilder<DocumentSnapshot?>(
                                future: getDocumentByUID(_selected[index]),
                                builder: (BuildContext context,
                                    AsyncSnapshot<DocumentSnapshot?>
                                        snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return const CircularProgressIndicator();
                                  } else if (snapshot.hasError) {
                                    return Text('Error: ${snapshot.error}');
                                  } else if (snapshot.hasData) {
                                    Map<String, dynamic> data2 =
                                        snapshot.data!.data()
                                            as Map<String, dynamic>;
                                    return Container(
                                      width: 200,
                                      decoration: const BoxDecoration(
                                          color: AppColor.primaryColor,
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
                                                    _selected.removeAt(index);
                                                  });
                                                },
                                                icon:
                                                    const Icon(Icons.remove))
                                          ],
                                        ),
                                      ),
                                    );
                                  }
                                  return const SizedBox(
                                    height: 50,
                                  );
                                }),
                          );
                        },
                      ),
                    )
                  : const Center(
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
              Column(
                children: [
                  StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('Users')
                        .doc(auth.currentUser!.uid)
                        .collection('Friends')
                        .snapshots(),
                    builder: (context, snapshots) {
                      if (snapshots.connectionState ==
                          ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      return Container(
                        decoration: const BoxDecoration(),
                        height: 200,
                        child: ListView.builder(
                            itemCount: snapshots.data!.docs.length,
                            itemBuilder: (context, index) {
                              var id = snapshots.data!.docs[index].id;
                              if (_name == '') {
                                return Container();
                              } else {
                                return FutureBuilder<DocumentSnapshot?>(
                                  future: getDocumentByUID(id),
                                  builder: (BuildContext context,
                                      AsyncSnapshot<DocumentSnapshot?>
                                          snapshot) {
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
                                              backgroundImage: data['pfpUrl'] !=
                                                      ' '
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
                                                        _selected.add(id);
                                                      })
                                                    : setState(() {
                                                        _selected.remove(id);
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
                            }),
                      );
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 50, bottom: 50),
                    child: Center(
                      child: SizedBox(
                        width: 400,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: () {
                            
                            if (_gName.currentState!.validate()) {
                              _gName.currentState!.save();
                              _selected.add(auth.currentUser!.uid);
                              createGroup(
                                  _gNameController.text.trim(), _selected);
                            }
                          },
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                AppColor.primaryColor),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                          ),
                          child: const Text(
                            'Create',
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
