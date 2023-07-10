import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hikeyy/group_details/widgets/collapseable_options.dart';
import 'package:hikeyy/screens/start_trail/start_trail.dart';
import 'package:hikeyy/widgets/app_colors.dart';
import 'package:hikeyy/widgets/app_texts.dart';

import '../widgets/app_buttons.dart';

class GroupDetails extends StatefulWidget {
  final String id;
  const GroupDetails({super.key, required this.id});

  @override
  State<GroupDetails> createState() => _GroupDetailsState();
}

class _GroupDetailsState extends State<GroupDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
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
              if (snapshot.connectionState == ConnectionState.done) {
                var data = snapshot.data!.data();
                List<dynamic> members = data!['Members'];
                print(members);
                print('########################');
                return SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                  height: 40,
                                  width: 40,
                                  decoration: BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.5),
                                          spreadRadius: 3,
                                          blurRadius: 6,
                                          offset: const Offset(0, 2),
                                        ),
                                      ],
                                      shape: BoxShape.circle,
                                      color: Colors.white),
                                  child: Padding(
                                      padding: const EdgeInsets.only(left: 5.0),
                                      child: IconButton(
                                        icon: const Icon(Icons.arrow_back_ios),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                      ))),
                              Padding(
                                padding: const EdgeInsets.only(right: 50.0),
                                child: AppText(
                                  text: '*enter group name*',
                                  fontSize: 20,
                                  color: AppColor.primaryColor,
                                ),
                              )
                            ],
                          ),
                          const Padding(
                            padding: const EdgeInsets.only(
                              top: 15.0,
                            ),
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: CircleAvatar(
                                    backgroundColor: Colors.green,
                                    radius: 15,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: CircleAvatar(
                                    backgroundColor: Colors.green,
                                    radius: 15,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: CircleAvatar(
                                    backgroundColor: Colors.green,
                                    radius: 15,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 30.0),
                            child: Container(
                              constraints: const BoxConstraints(
                                  maxHeight: 230, maxWidth: 350),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30)),
                              child: Stack(children: [
                                ClipRRect(
                                    borderRadius: BorderRadius.circular(30),
                                    child: Image(
                                      image:
                                          AssetImage('assets/images/EBC.jpg'),
                                      fit: BoxFit.fill,
                                    )),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 10.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30),
                                      gradient: LinearGradient(
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                        colors: [
                                          Colors.transparent,
                                          Colors.grey,
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  top: 100,
                                  left: 20,
                                  child: AppText(
                                    text: 'Destination Name',
                                    fontSize: 20,
                                    color: Colors.white,
                                  ),
                                ),
                                Positioned(
                                    top: 100,
                                    left: 250,
                                    child: Icon(
                                      Icons.star,
                                      color: Colors.yellow,
                                    )),
                                Padding(
                                  padding: EdgeInsets.only(
                                      top: 130, left: 15, right: 15),
                                  child: Divider(
                                    thickness: 1,
                                    color: Colors.white,
                                  ),
                                ),
                                Positioned(
                                  top: 150,
                                  left: 20,
                                  child: Container(
                                    constraints:
                                        const BoxConstraints(maxWidth: 250),
                                    child: AppText(
                                      text:
                                          'The Everest Base Camp trek on the south side, at an elevation of 5,364 m (17,598 ft), is one of the most popular trekking routes in the Himalayas and about 40,000 people per year make the trek there from Lukla Airport (2,846 m (9,337 ft)). Trekkers usually fly from Kathmandu to Lukla to save time and energy before beginning the trek to the base camp.',
                                      color: Color.fromARGB(255, 223, 223, 223),
                                      maxLines: 2,
                                      textOverflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                )
                              ]),
                            ),
                          ),
                          //checkpoints
                          CollapsibleOptions(
                            id: widget.id,
                          ),
                        ]),
                  ),
                );
              }
              return const Center(
                child: CircularProgressIndicator(),
              );
            }),
      ),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(boxShadow: <BoxShadow>[
          BoxShadow(color: Colors.white, blurRadius: 8, spreadRadius: 10),
        ], color: Colors.transparent),
        child: Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 20, bottom: 20),
          child: SizedBox(
            height: 50,
            // decoration: BoxDecoration(color: Colors.amber),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppButtons(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => StartTrail()));
                    },
                    child: const AppText(text: 'Start Trail!')),
                AppButtons(
                    onPressed: () {},
                    child: AppText(
                      text: 'Nearby Devices',
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
