import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:timeline_tile/timeline_tile.dart';

import '../../../widgets/app_colors.dart';

class TimelineCollapsable extends StatefulWidget {
  final String id;
  final List checkpoints;
  const TimelineCollapsable({
    super.key,
    required this.id,
    required this.checkpoints,
  });

  @override
  State<TimelineCollapsable> createState() => _TimelineCollapsableState();
}

class _TimelineCollapsableState extends State<TimelineCollapsable> {
  bool _timelineExpanded = false;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 10.0, top: 20),
          child: Container(
            decoration: BoxDecoration(
              color: AppColor.primaryLightColor,
              borderRadius: BorderRadius.circular(30),
            ),
            child: ListTile(
              trailing: const Icon(Icons.arrow_drop_down_circle_outlined),
              title: const Text('Timeline'),
              onTap: () {
                setState(() {
                  _timelineExpanded = !_timelineExpanded;
                });
              },
            ),
          ),
        ),
        if (_timelineExpanded)
          StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('Groups')
                  .doc(widget.id)
                  .collection('Timeline')
                  .orderBy('Time', descending: true)
                  .snapshots(),
              builder: (context, snapshots) {
                if (snapshots.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                // DateTime prev=DateTime.now();
                return Column(
                  children: [
                    ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        itemCount: snapshots.data!.docs.length,
                        itemBuilder: (context, index) {
                          var data = snapshots.data!.docs[index].data()
                              as Map<String, dynamic>;
                          return FutureBuilder<
                                  DocumentSnapshot<Map<String, dynamic>>>(
                              future: FirebaseFirestore.instance
                                  .collection('Users')
                                  .doc(data['User'])
                                  .get(),
                              builder: (_, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                }
                                if (snapshot.connectionState ==
                                    ConnectionState.done) {
                                  bool isfirst = false;
                                  if (index == 0) {
                                    isfirst = true;
                                  }
                                  bool islast = false;
                                  if (index ==
                                      snapshots.data!.docs.length - 1) {
                                    islast = true;
                                  }
                                  return Padding(
                                    padding: const EdgeInsets.only(left: 18.0),
                                    child: TimelineTile(
                                      axis: TimelineAxis.vertical,
                                      // nodeAlign: TimelineNodeAlign.start,
                                      //node: const Icon(Icons.navigation),
                                      isFirst: isfirst,
                                      isLast: islast,
                                      endChild: ListTile(
                                        leading: Padding(
                                          padding: const EdgeInsets.only(
                                              right: 10.0),
                                          child: Container(
                                            height: 40,
                                            width: 40,
                                            decoration: BoxDecoration(
                                                color: Colors.blueAccent,
                                                borderRadius:
                                                    BorderRadius.circular(200),
                                                image: DecorationImage(
                                                    fit: BoxFit.fill,
                                                    image: NetworkImage(snapshot
                                                        .data!
                                                        .data()!['pfpUrl']))),
                                          ),
                                        ),
                                        subtitle: Text(
                                            "${data['Time'].toDate().hour}:${data['Time'].toDate().minute}    ${data['Time'].toDate().year}|${data['Time'].toDate().month}|${data['Time'].toDate().day}"),
                                        title: Text(
                                            '${snapshot.data!.data()!['UserName']} reached ${widget.checkpoints[data['pos']]}'),
                                      ),
                                      //direction: Axis.vertical,
                                    ),
                                  );
                                }
                                return Container();
                              });
                        }),
                  ],
                );
              }),
      ]),
    );
  }
}
