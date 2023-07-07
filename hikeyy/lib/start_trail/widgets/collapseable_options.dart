import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hikeyy/widgets/app_colors.dart';

class CollapsibleOptions extends StatefulWidget {
  final String id;

  const CollapsibleOptions({super.key, required this.id});

  @override
  _CollapsibleOptionsState createState() => _CollapsibleOptionsState();
}

class _CollapsibleOptionsState extends State<CollapsibleOptions> {
  bool _tripDetailsExpanded = false;
  bool _checkpointsExpanded = false;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 10.0, top: 30),
            child: Container(
              decoration: BoxDecoration(
                color: AppColor.primaryLightColor,
                borderRadius: BorderRadius.circular(30),
              ),
              child: ListTile(
                trailing: const Icon(Icons.arrow_drop_down_outlined),
                title: const Text('Trail Details'),
                onTap: () {
                  setState(() {
                    _tripDetailsExpanded = !_tripDetailsExpanded;
                  });
                },
              ),
            ),
          ),
          if (_tripDetailsExpanded)
            Container(
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(30),
              ),
              margin: const EdgeInsets.symmetric(horizontal: 16),
              padding: const EdgeInsets.all(16),
              child: const Column(
                children: [
                  ListTile(
                    title: Text('Duration'),
                  ),
                  ListTile(
                    title: Text('other details'),
                  ),
                ],
              ),
            ),
          Padding(
            padding: const EdgeInsets.only(bottom: 10.0, top: 20),
            child: Container(
              decoration: BoxDecoration(
                color: AppColor.primaryLightColor,
                borderRadius: BorderRadius.circular(30),
              ),
              child: ListTile(
                trailing: const Icon(Icons.arrow_drop_down_outlined),
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
                        return Container(
                            height: 200,
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(30),
                            ),
                            margin: const EdgeInsets.symmetric(horizontal: 16),
                            padding: const EdgeInsets.all(16),
                            child: ListView.builder(
                              itemBuilder: (context, index) {
                                return Text("${index + 1} . ${points[index]}");
                              },
                              itemCount: snapshots.data!.docs.length,
                            ));
                      });
                })
        ],
      ),
    );
  }
}
