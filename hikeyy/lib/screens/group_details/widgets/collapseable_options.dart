import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hikeyy/widgets/app_colors.dart';

class CollapsibleOptions extends StatefulWidget {
  final String id;

  const CollapsibleOptions({super.key, required this.id});

  @override
  State<CollapsibleOptions> createState() => _CollapsibleOptionsState();
}

class _CollapsibleOptionsState extends State<CollapsibleOptions> {
  bool _checkpointsExpanded = false;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 10.0, top: 20),
            child: Container(
              decoration: BoxDecoration(
                color: AppColor.primaryLightColor,
                borderRadius: BorderRadius.circular(30),
              ),
              child: ListTile(
                trailing: const Icon(Icons.arrow_drop_down_circle_outlined),
                title: const Text('Checkpoints'),
                onTap: () {
                  setState(() {
                    _checkpointsExpanded = !_checkpointsExpanded;
                  });
                },
              ),
            ),
          ),
          if (_checkpointsExpanded)
            FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                future: FirebaseFirestore.instance
                    .collection('Groups')
                    .doc(widget.id)
                    .get(),
                builder: (_, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  var trailid = snapshot.data!.data()!['Trail'];
                  // print(trailid);
                  //  print('@@@@@@@@@@@@@@@@@@@@@');
                  return StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection('Trails')
                          .doc(trailid)
                          .collection('Cordinates')
                          .snapshots(),
                      builder: (BuildContext context,
                          AsyncSnapshot<QuerySnapshot> snapshots) {
                        if (snapshots.hasError) {}
                        if (snapshots.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        // print(snapshots.data!.docs.length);
                        //  print(widget.id);
                        List<String> points = List.generate(
                            snapshots.data!.docs.length, (index) => "");
                        for (var element in snapshots.data!.docs) {
                          points[element['pos']] = element['Name'];
                        }
                        // print(points);
                        // print('@@@@@@@@@@@@@@@@@@@@@@@');

                        return FutureBuilder<
                                DocumentSnapshot<Map<String, dynamic>>>(
                            future: FirebaseFirestore.instance
                                .collection('Groups')
                                .doc(widget.id)
                                .collection('Locations')
                                .doc(FirebaseAuth.instance.currentUser!.uid)
                                .get(),
                            builder: (_, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              }
                              String status = snapshot.data!.data()!['Status'];
                              return Container(
                                  height: 200,
                                  decoration: BoxDecoration(
                                    color: Colors.grey[200],
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 16),
                                  padding: const EdgeInsets.all(16),
                                  child: ListView.builder(
                                    itemBuilder: (context, index) {
                                      if (status == 'Going') {
                                        return Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 5.0),
                                          child: Container(
                                              height: 30,
                                              decoration: BoxDecoration(
                                                color: snapshot.data!
                                                            .data()!['pos'] !=
                                                        null
                                                    ? index <=
                                                            snapshot.data!
                                                                .data()!['pos']
                                                        ? AppColor
                                                            .primaryLightColor
                                                        : const Color.fromARGB(
                                                            255, 204, 202, 202)
                                                    : Colors.grey,
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              child: Center(
                                                  child: Text(
                                                      "${index + 1} . ${points[index]}"))),
                                        );
                                      } else if (status == 'Returning') {
                                        return Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 5.0),
                                          child: Container(
                                              height: 30,
                                              decoration: BoxDecoration(
                                                color: index >=
                                                        snapshot.data!
                                                            .data()!['pos']
                                                    ? AppColor.primaryColor
                                                    : AppColor
                                                        .primaryLightColor,
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              child: Center(
                                                  child: Text(
                                                      "${index + 1} . ${points[snapshots.data!.docs.length - index - 1]}"))),
                                        );
                                      } else {
                                        return Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 5.0),
                                          child: Container(
                                              height: 30,
                                              decoration: BoxDecoration(
                                                color: AppColor.primaryColor,
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              child: Center(
                                                  child: Text(
                                                      "${index + 1} . ${points[index]}"))),
                                        );
                                      }
                                    },
                                    itemCount: snapshots.data!.docs.length,
                                  ));
                            });
                        // return
                      });
                })
        ],
      ),
    );
  }
}
