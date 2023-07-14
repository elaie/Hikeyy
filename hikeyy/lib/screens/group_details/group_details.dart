import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hikeyy/screens/dashboard/dashboard.dart';
import 'package:hikeyy/screens/home_page/widget/mapwidget.dart';
import 'package:hikeyy/screens/home_page/widget/trails.dart';
import 'package:hikeyy/screens/start_trail/start_trail.dart';
import 'package:hikeyy/widgets/app_buttons.dart';
import 'package:hikeyy/widgets/app_colors.dart';
import 'package:hikeyy/widgets/app_texts.dart';
import 'package:hikeyy/widgets/location_month_icon_row.dart';

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
                //print(members);
                //  print('#####################');
                return Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 15.0, right: 15, top: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
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
                                padding: const EdgeInsets.only(left: 70.0),
                                child: AppText(
                                  text: data['Name'],
                                  fontSize: 25,
                                  color: AppColor.primaryColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(top: 10.0),
                          child: Image(
                              image: AssetImage('assets/images/group.png')),
                        ),
                        Container(
                          width: 800,
                          decoration: BoxDecoration(
                              color: AppColor.primaryLightColor,
                              borderRadius: BorderRadius.circular(30)),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: 40,
                                      width: MediaQuery.of(context).size.width -
                                          40,
                                      child: ListView.builder(
                                          scrollDirection: Axis.horizontal,
                                          itemCount: members.length,
                                          itemBuilder: (context, index) {
                                            return FutureBuilder<
                                                    DocumentSnapshot<
                                                        Map<String, dynamic>>>(
                                                future: FirebaseFirestore
                                                    .instance
                                                    .collection('Users')
                                                    .doc(members[index])
                                                    .get(),
                                                builder: (_, snapshot) {
                                                  if (snapshot
                                                          .connectionState ==
                                                      ConnectionState.waiting) {
                                                    return const Center(
                                                      child:
                                                          CircularProgressIndicator(),
                                                    );
                                                  }
                                                  if (snapshot
                                                          .connectionState ==
                                                      ConnectionState.done) {
                                                    return Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              right: 10.0),
                                                      child: Container(
                                                        height: 40,
                                                        width: 40,
                                                        decoration: BoxDecoration(
                                                            color: Colors
                                                                .blueAccent,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        200),
                                                            image: DecorationImage(
                                                                fit:
                                                                    BoxFit.fill,
                                                                image: NetworkImage(snapshot
                                                                        .data!
                                                                        .data()![
                                                                    'pfpUrl']))),
                                                      ),
                                                    );
                                                  }
                                                  return Container();
                                                });
                                          }),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                  height: 800,
                                  width: 800,
                                  decoration: const BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                            color: Colors.grey,
                                            offset: Offset(0, 1),
                                            blurRadius: 4,
                                            spreadRadius: 2)
                                      ],
                                      color: Colors.white,
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(30),
                                          topRight: Radius.circular(30))),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        top: 30.0, left: 15),
                                    child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              const LocationMonthIconRow(
                                                  location: 'EBC', date: 'Jan'),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 100.0),
                                                child: AppButtons(
                                                    onPressed: () {
                                                      Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                Trails(
                                                                    id: data[
                                                                        'Trail'])),
                                                      );
                                                    },
                                                    child: const AppText(
                                                        text: 'View Trail')),
                                              )
                                            ],
                                          ),
                                          const Padding(
                                            padding: EdgeInsets.only(
                                                right: 15.0, top: 10),
                                            child: Divider(
                                              thickness: 1,
                                            ),
                                          ),
                                          const Padding(
                                            padding: EdgeInsets.only(
                                                top: 10.0, bottom: 30),
                                            child: AppTextSubHeading(
                                                text:
                                                    'Very nice place bla bla add discription about place'),
                                          ),
                                          SizedBox(
                                            width: 350,
                                            height: 200,
                                            child: MapWidget(
                                              id: data['Trail'],
                                            ),
                                          ),
                                        ]),
                                  )),
                            ],
                          ),
                        )
                      ],
                    ),
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
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            contentPadding: EdgeInsets.all(20),
                            title: const Text('Are you sure?'),
                            content: const Text(
                                'Once you start a trail, you cannot go back to dashboard until you have finished your trail'),
                            actions: [
                              AppButtons(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: const AppText(text: 'No')),
                              AppButtons(
                                  onPressed: () {
                                    // Perform the desired actions when 'Yes' is pressed
                                    FirebaseFirestore.instance
                                        .collection('Users')
                                        .doc(FirebaseAuth
                                            .instance.currentUser!.uid)
                                        .update({
                                      'Status': 'Busy',
                                      'Trail': widget.id
                                    }).then((value) {
                                      FirebaseFirestore.instance
                                          .collection('Groups')
                                          .doc(widget.id)
                                          .collection('Locations')
                                          .doc(FirebaseAuth
                                              .instance.currentUser?.uid)
                                          .set({
                                        'Position': null,
                                        'Time': DateTime.now(),
                                        'Status': 'Going'
                                      });
                                    });
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => Dashboard(
                                          page: StartTrail(
                                            id: widget.id,
                                          ),
                                        ),
                                      ),
                                    );
                                    Navigator.of(context)
                                        .pop(); // Close the dialog box
                                  },
                                  child: const AppText(
                                    text: 'Yes',
                                  ))
                            ],
                          );
                        },
                      );
                    },
                    child: const AppText(text: 'Start Trail!')),
                AppButtons(
                    onPressed: () {},
                    child: const AppText(
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
