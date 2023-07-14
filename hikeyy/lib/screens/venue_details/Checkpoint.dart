import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../widgets/app_colors.dart';

class Checkpoint extends StatefulWidget {
  final String id;
  const Checkpoint({Key? key, required this.id}) : super(key: key);

  @override
  State<Checkpoint> createState() => _CheckpointState();
}

class _CheckpointState extends State<Checkpoint> {
  bool checkpointsExpanded = false;
  @override
  Widget build(BuildContext context) {

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(
              bottom: 10.0, top: 20),
          child: Container(
            decoration: BoxDecoration(
              color: AppColor.primaryLightColor,
              borderRadius: BorderRadius.circular(30),
            ),
            child: ListTile(
              trailing: const Icon(Icons
                  .arrow_drop_down_circle_outlined),
              title: const Text('Checkpoints'),
              onTap: () {
                setState(() {
                  checkpointsExpanded =
                  !checkpointsExpanded;
                });
                print(checkpointsExpanded);
              },
            ),
          ),
        ),
        if (checkpointsExpanded)
          StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('Trails')
                  .doc(widget.id)
                  .collection('Cordinates')
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<
                      QuerySnapshot> snapshots) {
                if (snapshots.hasError) {}
                if (snapshots.connectionState ==
                    ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                List<String> points = List.generate(
                    snapshots.data!.docs.length, (
                    index) => "");
                for (var element in snapshots.data!
                    .docs) {
                  points[element['pos']] =
                  element['Name'];
                }
                return Container(
                    height: 200,
                    width: MediaQuery.of(context).size.width*0.9,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius
                          .circular(30),
                    ),
                    margin: const EdgeInsets
                        .symmetric(
                        horizontal: 10),
                    padding: const EdgeInsets.all(
                        16),
                    child: ListView.builder(
                      itemBuilder: (context,
                          index) {
                        return Padding(
                          padding: const EdgeInsets
                              .symmetric(
                              vertical: 5.0),
                          child: Container(
                              height: 30,
                              decoration: BoxDecoration(
                                color: AppColor
                                    .primaryColor,
                                borderRadius:
                                BorderRadius
                                    .circular(
                                    10),
                              ),
                              child: Center(
                                  child: Text(
                                      "${index +
                                          1} . ${points[index]}"))),
                        );
                      },
                      itemCount: snapshots.data!
                          .docs.length,
                    ));
                // return
              }),
      ],
    );
  }
}

