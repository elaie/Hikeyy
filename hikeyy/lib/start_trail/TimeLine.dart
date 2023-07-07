import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class TimeLine extends StatefulWidget {
  final String id;
  final List checkpoints;

  const TimeLine({Key? key, required this.id, required this.checkpoints})
      : super(key: key);

  @override
  State<TimeLine> createState() => _TimeLineState();
}

class _TimeLineState extends State<TimeLine> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('Groups')
                .doc(widget.id)
                .collection('Timeline').orderBy('Time', descending: true)
                .snapshots(),
            builder: (context, snapshots) {
              if (snapshots.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
             // DateTime prev=DateTime.now();
              return Expanded(
                child: SizedBox(
                  height: 200,
                  width: 800,
                  child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: snapshots.data!.docs.length,
                      itemBuilder: (context, index) {
                        var data = snapshots.data!.docs[index].data()
                            as Map<String, dynamic>;

                        return ListTile(
                            leading: Container(
                              height: 40,
                              width: 50,
                              child: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
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
                                      return Padding(
                                        padding:
                                        const EdgeInsets.only(right: 10.0),
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
                                      );
                                    }
                                    return Container();
                                  }),
                            ),
                            subtitle: Text("${data['Time'].toDate().hour}:${data['Time'].toDate().minute}    ${data['Time'].toDate().year}|${data['Time'].toDate().month}|${data['Time'].toDate().day}"),
                            title: Text(widget.checkpoints[data['pos']]),
                          );

                      }),
                ),
              );
            }),
      ),
    );
  }
}
