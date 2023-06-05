import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hikeyy/screens/home_page/widget/my_schedule_card.dart';
import 'package:hikeyy/screens/home_page/widget/venu_card.dart';
import 'package:hikeyy/screens/login_signup/login.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _scaffoldkey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldkey,
      drawer: Drawer(
        child: Icon(Icons.add),
      ),
      //extendBodyBehindAppBar: true,
        body: SafeArea(
      child: Container(
        alignment: Alignment.topCenter,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/green_background.png'),
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [


              Padding(
                padding: const EdgeInsets.only(top: 20.0,left: 20,right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        GestureDetector(child: Container(child: const Icon(Icons.add)),onTap:()=> _scaffoldkey.currentState!.openDrawer()),
                        Padding(
                          padding: const EdgeInsets.only(left: 20.0),
                          child: Text('WELCOME UserName!!',style: TextStyle(fontSize: 20),),
                        ),
                      ],
                    ),

                    Icon(Icons.notifications),
                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(top: 250.0),
                child: Container(
                  //height: double.infinity,
                  alignment: Alignment.center,
                  decoration:  BoxDecoration(
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(35), topRight: Radius.circular(35)),
                     color: Colors.grey.shade200.withOpacity(0.5)
                  ),
                  child:  Padding(
                    padding: EdgeInsets.only(
                      top: 25.0,
                    ),
                    child: SingleChildScrollView(
                    //  scrollDirection: Axis.vertical,
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 25.0, right: 25),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Recommended',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w800, fontSize: 17),
                                ),
                                Text('See all')
                              ],
                            ),
                          ),
                          StreamBuilder<QuerySnapshot>(
                            stream: FirebaseFirestore.instance.collection('Destination').snapshots(),
                            builder: (context, snapshots) {
                              if (snapshots.hasError) {
                                return Text('Error: ${snapshots.error}');
                              }
                              if (!snapshots.hasData) {
                                return Text('No data available');
                              }
                              return SingleChildScrollView(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    SizedBox(
                                      height: 200.0,
                                      child: ListView.builder(
                                          physics: ClampingScrollPhysics(),
                                          shrinkWrap: true,
                                          scrollDirection: Axis.horizontal,
                                          padding: const EdgeInsets.all(10),
                                          itemCount: snapshots.data!.docs.length,
                                          itemBuilder: (context, index) {
                                            var data = snapshots.data!.docs[index]
                                                .data() as Map<String, dynamic>;
                                                 return Row(
                                              children: [
                                                 VenuCard(
                                                         venue: data['Name'].toString(),
                                                         location: 'Nepal',
                                                         date: 'July',
                                                       ),
                                              ],
                                            );

                                          }),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                          // SingleChildScrollView(
                          //   scrollDirection: Axis.horizontal,
                          //   child: Row(
                          //     children: [
                          //       VenuCard(
                          //         venue: 'Mt. Everest',
                          //         location: 'Nepal',
                          //         date: 'July',
                          //       ),
                          //       VenuCard(
                          //         venue: 'ABC Babyy',
                          //         location: 'Nepal',
                          //         date: 'July',
                          //       ),
                          //       VenuCard(
                          //         venue: 'ABC Babyy',
                          //         location: 'Nepal',
                          //         date: 'July',
                          //       )
                          //     ],
                          //   ),
                          // ),
                          Padding(
                            padding: EdgeInsets.only(left: 25.0, right: 25),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'My Schedule',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w800, fontSize: 17),
                                ),
                                Text('See all')
                              ],
                            ),
                          ),

                          MyScheduleCard(),
                          MyScheduleCard(),
                          MyScheduleCard(),
                          MyScheduleCard(),
                        ],
                      ),
                    ),
                  ),
                ),
              ),

            ],
          ),
        ),
      ),
    ));
  }
}
