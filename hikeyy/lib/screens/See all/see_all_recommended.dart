import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class see_all_recommended extends StatefulWidget {
  const see_all_recommended({super.key});

  @override
  State<see_all_recommended> createState() => _see_all_recommendedState();
}

class _see_all_recommendedState extends State<see_all_recommended> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('Destination').snapshots(),
        builder: (context, snapshots) {
          return (snapshots.connectionState == ConnectionState.waiting)
              ? Center(
            child: CircularProgressIndicator(),
          )
              : ListView.builder(

              itemCount: snapshots.data!.docs.length,
              itemBuilder: (context, index) {
                var data = snapshots.data!.docs[index].data()
                as Map<String, dynamic>;
                print("data printing");
                print(data);
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
                            SizedBox(
                              width: 20,
                            ),
                            Text(
                              data['Name'].toString(),
                              style: TextStyle(
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
