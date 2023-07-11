import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class SeeAllRecommended extends StatefulWidget {
  const SeeAllRecommended({super.key});

  @override
  State<SeeAllRecommended> createState() => _SeeAllRecommendedState();
}

class _SeeAllRecommendedState extends State<SeeAllRecommended> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('Destination').snapshots(),
        builder: (context, snapshots) {
          return (snapshots.connectionState == ConnectionState.waiting)
              ? const Center(
            child: CircularProgressIndicator(),
          )
              : ListView.builder(

              itemCount: snapshots.data!.docs.length,
              itemBuilder: (context, index) {
                var data = snapshots.data!.docs[index].data()
                as Map<String, dynamic>;
                // print("data printing");
                // print(data);
                return GestureDetector(
                    onTap: () {
                      //hehe
                    },

                    //radius vairacha somehow
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 10),
                      child: Container(
                        height: 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const SizedBox(
                              width: 20,
                            ),
                            Text(
                              data['Name'].toString(),
                              style: const TextStyle(
                                  fontFamily: 'Comfortaa',
                              ),
                            ),
                          ],
                        ),
                      ),
                    ));
              });
        },
      ),
    );
  }
}
